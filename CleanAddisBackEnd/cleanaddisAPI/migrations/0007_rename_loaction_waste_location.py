# Generated by Django 3.2.12 on 2022-06-14 14:00

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('cleanaddisAPI', '0006_rename_message_announcement_notification_body'),
    ]

    operations = [
        migrations.RenameField(
            model_name='waste',
            old_name='loaction',
            new_name='location',
        ),
    ]
