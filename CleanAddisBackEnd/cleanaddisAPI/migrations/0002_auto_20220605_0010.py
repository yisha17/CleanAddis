# Generated by Django 3.2.12 on 2022-06-04 21:10

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('cleanaddisAPI', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='seminar',
            name='imageLink',
            field=models.CharField(default='', max_length=300),
        ),
        migrations.AlterField(
            model_name='seminar',
            name='seminarTitle',
            field=models.CharField(default='', max_length=120, null=True),
        ),
    ]
