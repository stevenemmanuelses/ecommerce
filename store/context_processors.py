from django.db.models import Sum
from .models import CartItem, Category


def cart_count(request):
    if request.user.is_authenticated:
        count = CartItem.objects.filter(user=request.user).aggregate(total_quantity=Sum('quantity')).get('total_quantity')
        return {'cart_count': count or 0}

    session_key = request.session.session_key
    if not session_key:
        return {'cart_count': 0}
    count = CartItem.objects.filter(session_key=session_key).aggregate(total_quantity=Sum('quantity')).get('total_quantity')
    return {'cart_count': count or 0}


def categories(request):
    return {'categories': Category.objects.all()}
