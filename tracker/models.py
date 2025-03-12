from django.db import models
from users.models import Profile
# Create your models here.

class Schedule(models.Model):
    profile = models.ForeignKey(Profile, on_delete=models.CASCADE, related_name='schedules')
    title = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    start_time = models.TimeField()
    end_time = models.TimeField()

    def __str__(self):
        return f'{self.title} ({self.start_time} - {self.end_time})'

