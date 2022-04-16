# Generated by Django 3.2.12 on 2022-04-16 03:26

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('cleanaddisAPI', '0004_auto_20220415_2148'),
    ]

    operations = [
        migrations.AddField(
            model_name='waste',
            name='bought_by',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.DO_NOTHING, related_name='buyer', to='cleanaddisAPI.user'),
        ),
        migrations.AlterField(
            model_name='waste',
            name='for_waste',
            field=models.CharField(choices=[('Sell', 'Sell'), ('Donate', 'Donate')], max_length=10),
        ),
    ]
