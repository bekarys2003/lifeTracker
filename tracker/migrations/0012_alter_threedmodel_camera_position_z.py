# Generated by Django 4.0.10 on 2025-03-28 02:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tracker', '0011_threedmodel_scale'),
    ]

    operations = [
        migrations.AlterField(
            model_name='threedmodel',
            name='camera_position_z',
            field=models.FloatField(blank=True, default=1.2, null=True),
        ),
    ]
