# Generated by Django 3.2.12 on 2022-05-29 13:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('cleanaddisAPI', '0003_auto_20220529_0231'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='role',
            field=models.CharField(choices=[('Qorale', 'Qorale'), ('Garbage Collector', 'Garbage Collector'), ('City Admin', 'City Admin'), ('Resident', 'Resident')], default='Resident', max_length=20, null=True),
        ),
    ]