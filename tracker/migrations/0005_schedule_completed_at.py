# Generated by Django 4.0.10 on 2025-03-18 19:56

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tracker', '0004_schedule_updated_at'),
    ]

    operations = [
        migrations.AddField(
            model_name='schedule',
            name='completed_at',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]
