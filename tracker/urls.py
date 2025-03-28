from django.urls import path
from . import views
from .views import schedule_list, delete_schedule, schedule_update



urlpatterns = [
    path('schedule/', schedule_list, name='schedule_list'),
    path('schedule/delete/<uuid:pk>/', delete_schedule, name='delete_schedule'),
    path('schedule/update/<uuid:pk>/', schedule_update, name='schedule_update'),
    path('schedule/<uuid:pk>/', views.schedule_detail, name='schedule_detail'),
    path('schedule/<uuid:pk>/complete/', views.mark_schedule_completed, name='mark_schedule_completed'),
    path('api/active-models/', views.get_active_models, name='get_active_models'),
]