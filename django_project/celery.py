import os
from celery import Celery
from decouple import config
import django

# Set the default Django settings module
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'django_project.settings')

# Create the Celery app
app = Celery('django_project')

# Load Celery settings from Django settings
app.config_from_object('django.conf:settings', namespace='CELERY')

# Auto-discover tasks in all installed apps
app.autodiscover_tasks()