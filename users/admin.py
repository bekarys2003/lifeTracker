from django.contrib import admin

# Register your models here.
from django.contrib import admin
from .models import Profile, Post

@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'gender', 'height', 'weight', 'body_fat', 'date_of_birth', 'location')
    search_fields = ('user__username', 'location')



admin.site.register(Post)
