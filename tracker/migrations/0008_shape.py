# Generated by Django 4.0.10 on 2025-03-19 23:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tracker', '0007_remove_schedule_duration_completed_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='Shape',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('type', models.CharField(choices=[('1', 'Sphere'), ('2', 'Box'), ('3', 'Cylinder')], max_length=1)),
                ('color', models.CharField(help_text='hex', max_length=7)),
            ],
        ),
    ]
