from django.db import models
from users.models import Profile
# Create your models here.
import os
from decouple import config, Csv
from twilio.rest import Client
from django.utils import timezone
from datetime import datetime, timedelta
from .tasks import send_schedule_notification
import uuid


class Schedule(models.Model):
    uuid = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    profile = models.ForeignKey(Profile, on_delete=models.CASCADE, related_name='schedules')
    title = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    streak = models.PositiveIntegerField(default=0)
    updated_at = models.DateTimeField(auto_now=True)
    start_time = models.TimeField()
    end_time = models.TimeField()

    def __str__(self):
        return f'{self.title} ({self.start_time} - {self.end_time})'


    def save(self, *args, **kwargs):
        now = timezone.now()  # Timezone-aware datetime
        start_datetime = datetime.combine(now.date(), self.start_time)  # Timezone-naive datetime
        start_datetime = timezone.make_aware(start_datetime)  # Convert to timezone-aware

        if start_datetime < now:
            start_datetime += timedelta(days=1)

        delay = (start_datetime - now).total_seconds()

        if self.profile.phone_number:
            send_schedule_notification.apply_async(
                args=[self.profile.phone_number, f"Your schedule '{self.title}' is starting now!"],
                countdown=delay
            )
        super().save(*args, **kwargs)