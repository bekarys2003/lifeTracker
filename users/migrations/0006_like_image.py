# Generated by Django 4.0.10 on 2025-02-27 05:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0005_post_like'),
    ]

    operations = [
        migrations.AddField(
            model_name='like',
            name='image',
            field=models.ImageField(blank=True, null=True, upload_to='post_images/'),
        ),
    ]
