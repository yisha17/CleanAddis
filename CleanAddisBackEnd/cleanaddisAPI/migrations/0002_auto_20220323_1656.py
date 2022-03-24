# Generated by Django 3.2.12 on 2022-03-23 13:56

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('cleanaddisAPI', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Address',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('subcity', models.CharField(choices=[('Addis Ketema', 'AK'), ('Bole', 'Bole'), ('Nifas Silk', 'NS')], default='B', max_length=20)),
                ('woreda', models.IntegerField(default=1)),
            ],
        ),
        migrations.AddField(
            model_name='user',
            name='email',
            field=models.EmailField(default='', max_length=30),
        ),
        migrations.AddField(
            model_name='user',
            name='profile',
            field=models.ImageField(null=True, upload_to=''),
        ),
        migrations.AddField(
            model_name='user',
            name='username',
            field=models.CharField(default='', max_length=20),
        ),
        migrations.AlterField(
            model_name='user',
            name='device_id',
            field=models.CharField(default='', max_length=20),
        ),
        migrations.AlterField(
            model_name='user',
            name='first_name',
            field=models.CharField(default='', max_length=20),
        ),
        migrations.AlterField(
            model_name='user',
            name='last_name',
            field=models.CharField(default='', max_length=20),
        ),
        migrations.AlterField(
            model_name='user',
            name='password',
            field=models.CharField(default='', max_length=20),
        ),
        migrations.AlterField(
            model_name='user',
            name='role',
            field=models.CharField(default='', max_length=20),
        ),
        migrations.CreateModel(
            name='Company',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('company_name', models.CharField(max_length=20)),
                ('company_email', models.EmailField(max_length=30)),
                ('password', models.CharField(max_length=20)),
                ('role', models.CharField(max_length=20)),
                ('logo', models.ImageField(upload_to='')),
                ('address', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='cleanaddisAPI.address')),
            ],
        ),
        migrations.AddField(
            model_name='user',
            name='address',
            field=models.OneToOneField(default='', on_delete=django.db.models.deletion.CASCADE, to='cleanaddisAPI.address'),
        ),
    ]
