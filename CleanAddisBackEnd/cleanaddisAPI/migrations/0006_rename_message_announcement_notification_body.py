# Generated by Django 3.2.12 on 2022-06-14 13:02

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('cleanaddisAPI', '0005_auto_20220614_0416'),
    ]

    operations = [
        migrations.RenameField(
            model_name='announcement',
            old_name='message',
            new_name='notification_body',
        ),
    ]
