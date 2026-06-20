from django.contrib import admin
from .models import Category, Product, Order, CartItem, ReturnRequest

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('name',)}

@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('name', 'price', 'stock', 'image_url', 'created_at')
    prepopulated_fields = {'slug': ('name',)}
    search_fields = ('name', 'category__name')
    list_filter = ('category',)
    fields = ('category', 'name', 'slug', 'description', 'price', 'stock', 'image', 'image_url')

@admin.register(ReturnRequest)
class ReturnRequestAdmin(admin.ModelAdmin):
    list_display = ('id', 'order', 'user', 'status', 'accepted_terms', 'created_at')
    list_filter = ('status', 'accepted_terms', 'created_at')
    search_fields = ('order__id', 'user__username', 'reason')
    list_editable = ('status',)
    actions = ['mark_pending', 'mark_approved', 'mark_rejected']
    readonly_fields = ('created_at',)

    def mark_pending(self, request, queryset):
        queryset.update(status='pending')
    mark_pending.short_description = 'Set status retur menjadi Pending'

    def mark_approved(self, request, queryset):
        queryset.update(status='approved')
    mark_approved.short_description = 'Set status retur menjadi Approved'

    def mark_rejected(self, request, queryset):
        queryset.update(status='rejected')
    mark_rejected.short_description = 'Set status retur menjadi Rejected'

@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'status', 'paid', 'shipping_cost', 'created_at')
    list_filter = ('status', 'paid', 'created_at')
    search_fields = ('id', 'user__username')
    list_editable = ('status',)
    actions = ['set_processing', 'set_shipped', 'set_delivered']
    readonly_fields = ('created_at', 'tracking_code')

    def set_processing(self, request, queryset):
        queryset.update(status='processing')
    set_processing.short_description = 'Set status pesanan menjadi Diproses'

    def set_shipped(self, request, queryset):
        queryset.update(status='shipped')
    set_shipped.short_description = 'Set status pesanan menjadi Dikirim'

    def set_delivered(self, request, queryset):
        queryset.update(status='delivered')
    set_delivered.short_description = 'Set status pesanan menjadi Terkirim'

admin.site.register(CartItem)
