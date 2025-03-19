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
    duration = models.PositiveIntegerField(help_text="Duration in minutes")
    start_time = models.TimeField()
    end_time = models.TimeField()
    completed_at = models.DateTimeField(null=True, blank=True)

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


class DailyProgress(models.Model):
    schedule = models.ForeignKey('Schedule', on_delete=models.CASCADE, related_name='daily_progress')
    date = models.DateField(default=timezone.now)  # Date of the progress entry
    duration_completed = models.PositiveIntegerField(default=0)  # Completed duration for the day
    effort_percentage = models.PositiveIntegerField(default=0)  # Effort percentage for the day

    def __str__(self):
        return f"{self.schedule.title} - {self.date}"

    class Meta:
        unique_together = ('schedule', 'date')