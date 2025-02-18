from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import Profile

@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'bio', 'date_of_birth', 'location')  # Fields to display in the admin list view
    list_filter = ('location',)  # Add filters for the list view
    search_fields = ('user__username', 'bio', 'location')  # Add search functionality
    raw_id_fields = ('user',)  # Use a raw ID widget for the user field (useful for large datasets)