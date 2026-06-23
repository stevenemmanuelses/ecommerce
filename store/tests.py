from django.test import TestCase, Client
from django.urls import reverse
from django.contrib.auth import get_user_model
from store.models import Category, Product, CartItem

User = get_user_model()

class CartRedirectTests(TestCase):
    def setUp(self):
        self.client = Client()
        self.category = Category.objects.create(name="Scents", slug="scents")
        self.product = Product.objects.create(
            category=self.category,
            name="Rose Musk",
            slug="rose-musk",
            description="Beautiful rose fragrance.",
            price=150000.00,
            stock=10
        )
        self.username = "testbuyer"
        self.password = "securepass123"
        self.user = User.objects.create_user(
            username=self.username,
            password=self.password,
            email="buyer@example.com"
        )
        self.add_url = reverse("store:add_to_cart", kwargs={"slug": self.product.slug})
        self.login_url = reverse("store:login")

    def test_add_to_cart_requires_login(self):
        # 1. Accessing add_to_cart when guest should redirect to login page
        response = self.client.get(self.add_url)
        self.assertEqual(response.status_code, 302)
        expected_redirect = f"{self.login_url}?next={self.add_url}"
        self.assertIn(expected_redirect, response.url)

    def test_add_to_cart_logged_in_standard(self):
        # 2. Accessing add_to_cart when logged in with a regular referer should redirect to referer
        self.client.login(username=self.username, password=self.password)
        referer_url = "/product/rose-musk/"
        response = self.client.get(self.add_url, HTTP_REFERER=referer_url)
        self.assertEqual(response.status_code, 302)
        self.assertEqual(response.url, referer_url)
        
        # Verify cart item was created
        cart_item = CartItem.objects.filter(user=self.user, product=self.product).first()
        self.assertIsNotNone(cart_item)
        self.assertEqual(cart_item.quantity, 1)

    def test_add_to_cart_logged_in_after_login_redirect_loop_prevention(self):
        # 3. Simulating the redirect from login page after authentication.
        # The referer header contains 'login', so it should redirect to '/cart/' instead of back to 'login'
        self.client.login(username=self.username, password=self.password)
        login_referer = f"{self.login_url}?next={self.add_url}"
        response = self.client.get(self.add_url, HTTP_REFERER=login_referer)
        
        # Should redirect to the cart view instead of looping back to login
        self.assertEqual(response.status_code, 302)
        self.assertEqual(response.url, reverse("store:cart"))
        
        # Verify cart item was created
        cart_item = CartItem.objects.filter(user=self.user, product=self.product).first()
        self.assertIsNotNone(cart_item)
