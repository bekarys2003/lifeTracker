# Generated by Django 4.0.10 on 2025-03-18 19:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tracker', '0002_remove_schedule_id_schedule_uuid'),
    ]

    operations = [
        migrations.AddField(
            model_name='schedule',
            name='streak',
            field=models.PositiveIntegerField(default=0),
        ),
    ]
