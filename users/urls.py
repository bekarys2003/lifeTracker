from django.urls import path
from . import views
# from django.contrib.auth import views as auth_views
from .views import profile_update, public_profile, schedule_list, schedule_create, schedule_update, delete_schedule, post_list, like_post

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
    path('schedule/', schedule_list, name='schedule_list'),
    path('schedule/delete/<int:schedule_id>/', delete_schedule, name='delete_schedule'),
    path('schedule/update/<int:pk>/', schedule_update, name='schedule_update'),
    path('posts/', post_list, name='post_list'),
    path('post-create/', views.create_post, name='post_create'),
    path('posts/<uuid:post_id>/like/', views.like_post, name='like_post'),
    path('delete-post/<uuid:post_id>/', views.delete_post, name='delete_post'),
    path('posts/<uuid:post_id>/', views.post_detail, name='post_detail'),

    ]

