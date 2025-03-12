from django.urls import path
from . import views
from .views import schedule_list, delete_schedule, schedule_update



urlpatterns = [
    path('schedule/', schedule_list, name='schedule_list'),
    path('schedule/delete/<int:schedule_id>/', delete_schedule, name='delete_schedule'),
    path('schedule/update/<int:pk>/', schedule_update, name='schedule_update'),
]