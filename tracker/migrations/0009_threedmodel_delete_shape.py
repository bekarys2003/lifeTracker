# Generated by Django 4.0.10 on 2025-03-21 02:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tracker', '0008_shape'),
    ]

    operations = [
        migrations.CreateModel(
            name='ThreeDModel',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('file_path', models.CharField(max_length=255)),
                ('description', models.TextField(blank=True)),
            ],
        ),
        migrations.DeleteModel(
            name='Shape',
        ),
    ]
