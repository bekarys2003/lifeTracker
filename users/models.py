from django.db import models
from django.contrib.auth import get_user_model
from django.conf import settings
from django.urls import reverse
import uuid

User = get_user_model()

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    phone_number = models.CharField(max_length=15, null=True)
    gender = models.TextField(blank=True, null=True)
    height = models.FloatField(blank=True, null=True, help_text="Height in meters")
    weight = models.FloatField(blank=True, null=True, help_text="Weight in kilograms")
    body_fat = models.FloatField(blank=True, null=True, help_text="Body fat percentage")
    date_of_birth = models.DateField(blank=True, null=True)
    location = models.CharField(max_length=100, blank=True, null=True)
    profile_picture = models.ImageField(upload_to='profile_pics/', blank=True, null=True)
    active_models = models.ManyToManyField('tracker.ThreeDModel', blank=True, related_name='active_in_profiles')
    available_models = models.ManyToManyField('tracker.ThreeDModel', blank=True, related_name='available_in_profiles')

    def set_active_models(self, model_ids):
        """Set multiple active models"""
        self.active_models.set(model_ids)

    def add_available_model(self, model):
        """Add a model to available models"""
        self.available_models.add(model)

    def __str__(self):
        return f'{self.user.username}'




class Post(models.Model):
    uuid = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    profile = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='posts')
    image = models.ImageField(upload_to='post_images/', blank=True, null=True)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    def __str__(self):
        return f"Post by {self.profile.username}"
    @property
    def likes_count(self):
        return self.post_likes.count()

    @property
    def comments_count(self):
        return self.post_comments.count()

    def get_absolute_url(self):
        return reverse('post_detail', args=[str(self.uuid)])



class Like(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='likes')
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='post_likes')
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'post')

    def __str__(self):
        return f"{self.user.username} likes {self.post.id}"


class Comment(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='comments')
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='post_comments')
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'Comment by {self.user.username} on {self.post.id}'

    class Meta:
        ordering = ['-created_at']