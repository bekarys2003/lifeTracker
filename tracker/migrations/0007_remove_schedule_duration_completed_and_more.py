# Generated by Django 4.0.10 on 2025-03-19 02:05

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('tracker', '0006_schedule_duration_schedule_duration_completed_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='schedule',
            name='duration_completed',
        ),
        migrations.RemoveField(
            model_name='schedule',
            name='effort_percentage',
        ),
        migrations.CreateModel(
            name='DailyProgress',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date', models.DateField(default=django.utils.timezone.now)),
                ('duration_completed', models.PositiveIntegerField(default=0)),
                ('effort_percentage', models.PositiveIntegerField(default=0)),
                ('schedule', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='daily_progress', to='tracker.schedule')),
            ],
            options={
                'unique_together': {('schedule', 'date')},
            },
        ),
    ]
