from django.contrib import admin
from .models import Schedule, DailyProgress, ThreeDModel
# Register your models here.

admin.site.register(Schedule)

admin.site.register(DailyProgress)

admin.site.register(ThreeDModel)
