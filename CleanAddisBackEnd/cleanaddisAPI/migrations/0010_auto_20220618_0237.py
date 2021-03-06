# Generated by Django 3.2.12 on 2022-06-17 23:37

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('cleanaddisAPI', '0009_auto_20220618_0235'),
    ]

    operations = [
        migrations.AlterField(
            model_name='waste',
            name='buyer',
            field=models.ForeignKey(db_constraint=False, null=True, on_delete=django.db.models.deletion.RESTRICT, related_name='buyer', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='waste',
            name='seller',
            field=models.ForeignKey(on_delete=django.db.models.deletion.RESTRICT, to=settings.AUTH_USER_MODEL),
        ),
    ]
