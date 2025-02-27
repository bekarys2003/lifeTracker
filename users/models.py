from django.db import models
from django.contrib.auth import get_user_model
from django.conf import settings


User = get_user_model()

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    gender = models.TextField(blank=True, null=True)
    height = models.FloatField(blank=True, null=True, help_text="Height in meters")
    weight = models.FloatField(blank=True, null=True, help_text="Weight in kilograms")
    body_fat = models.FloatField(blank=True, null=True, help_text="Body fat percentage")
    date_of_birth = models.DateField(blank=True, null=True)
    location = models.CharField(max_length=100, blank=True, null=True)
    profile_picture = models.ImageField(upload_to='profile_pics/', blank=True, null=True)

    def __str__(self):
        return f'{self.user.username}'


class Schedule(models.Model):
    profile = models.ForeignKey(Profile, on_delete=models.CASCADE, related_name='schedules')
    title = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    start_time = models.TimeField()
    end_time = models.TimeField()

    def __str__(self):
        return f'{self.title} ({self.start_time} - {self.end_time})'



class Post(models.Model):
    profile = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='posts')
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Post by {self.profile.username} at {self.created_at}"



class Like(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='likes')
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='likes')
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'post')  # Ensure a user can only like a post once

    def __str__(self):
        return f"{self.user.username} likes {self.post.id}"