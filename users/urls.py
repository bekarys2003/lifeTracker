from django.urls import path
from . import views
# from django.contrib.auth import views as auth_views
from .views import profile_update, public_profile, schedule

urlpatterns = [
    path("", views.home),
    path('register/', views.register, name='register'),
    path('login', views.custom_login, name='login'),
    path('logout', views.custom_logout, name='logout'),
    path('profile/create/', views.create_profile, name='profile_create'),
    path('profile/update/', profile_update, name='profile_update'),
    path('profile/<str:username>/', public_profile, name='public_profile'),
    path('activate/<uidb64>/<token>', views.activate, name='activate'),
    path('password_change', views.password_change, name="password_change"),
    path('password_reset', views.password_reset_request, name='password_reset'),
    path('reset/<uidb64>/<token>', views.passwordResetConfirm, name='password_reset_confirm'),
    path('schedule/', schedule, name='schedule'),
]

