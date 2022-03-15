from django.db import models
from django.forms import CharField

# Create your models here.


class User(models.Model):

    first_name = models.CharField(max_length=20)
    last_name = models.CharField(max_length=20)
    password = models.CharField(max_length=20)
    role = models.CharField(max_length=20)
    #unknown field type
    device_id = models.CharField(max_length=20)
     



