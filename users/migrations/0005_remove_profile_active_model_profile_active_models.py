# Generated by Django 4.0.10 on 2025-03-28 02:34

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tracker', '0011_threedmodel_scale'),
        ('users', '0004_profile_active_model_profile_available_models'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='profile',
            name='active_model',
        ),
        migrations.AddField(
            model_name='profile',
            name='active_models',
            field=models.ManyToManyField(blank=True, related_name='active_in_profiles', to='tracker.threedmodel'),
        ),
    ]
