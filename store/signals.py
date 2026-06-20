from django.contrib.auth.signals import user_logged_in
from django.dispatch import receiver

from .models import CartItem


@receiver(user_logged_in)
def merge_session_cart(sender, user, request, **kwargs):
    session_key = request.session.session_key
    if not session_key:
        return

    session_items = CartItem.objects.filter(session_key=session_key)
    for item in session_items:
        existing_item, created = CartItem.objects.get_or_create(
            user=user,
            product=item.product,
            defaults={'quantity': item.quantity}
        )
        if not created:
            existing_item.quantity += item.quantity
            existing_item.save()
    session_items.delete()
