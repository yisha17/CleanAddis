# Generated by Django 3.2.12 on 2022-05-20 15:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('cleanaddisAPI', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='publicplace',
            name='latitude',
            field=models.DecimalField(decimal_places=10, max_digits=14),
        ),
        migrations.AlterField(
            model_name='publicplace',
            name='longitude',
            field=models.DecimalField(decimal_places=10, max_digits=14),
        ),
        migrations.AlterField(
            model_name='report',
            name='latitude',
            field=models.DecimalField(decimal_places=10, max_digits=12),
        ),
        migrations.AlterField(
            model_name='report',
            name='longitude',
            field=models.DecimalField(decimal_places=10, max_digits=12),
        ),
    ]