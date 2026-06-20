from django.urls import path
from . import views

app_name = 'store'

urlpatterns = [
    path('', views.landing_view, name='landing'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('register/', views.register_view, name='register'),
    path('account/', views.account_view, name='account'),
    path('orders/<int:order_id>/tracking/', views.order_tracking_view, name='order_tracking'),
    path('orders/<int:order_id>/review/', views.order_review_view, name='order_review'),
    path('cart/', views.cart_view, name='cart'),
    path('cart/add/<slug:slug>/', views.add_to_cart, name='add_to_cart'),
    path('cart/update/', views.update_cart, name='update_cart'),
    path('cart/remove/<int:item_id>/', views.remove_from_cart, name='remove_from_cart'),
    path('cart/checkout/', views.checkout_view, name='checkout'),
    path('cart/payment/', views.payment_view, name='payment'),
    path('orders/<int:order_id>/pay/', views.order_payment_view, name='order_payment'),
    path('return/<int:order_id>/', views.return_request_view, name='return_request'),
    path('return-review/', views.return_review, name='return_review'),
    path('return-review/<int:return_id>/action/', views.return_review_action, name='return_review_action'),
    path('orders/manage/', views.order_management_view, name='order_management'),
    path('orders/<int:order_id>/update-status/', views.update_order_status, name='update_order_status'),
    path('product/new/', views.product_create, name='product_create'),
    path('product/<slug:slug>/edit/', views.product_edit, name='product_edit'),
    path('product/<slug:slug>/', views.product_detail, name='product_detail'),
    path('category/<slug:slug>/', views.category_view, name='category'),
    path('orders/<int:order_id>/cancel/', views.cancel_order, name='cancel_order'),
    path('orders/<int:order_id>/invoice/', views.download_invoice, name='download_invoice'),
]
