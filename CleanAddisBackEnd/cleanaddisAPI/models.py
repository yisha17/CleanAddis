from tkinter import CASCADE
from django.db import models
from django.forms import CharField

# Create your models here.


class Address(models.Model):

    class meta:
        verbose_name_plural = 'Addresses'
    
    SUBCITY_CHOICES = [
        ('Addis Ketema','AK'),
        ('Bole','Bole'),
        ('Nifas Silk','NS')

    ]

    subcity = models.CharField(max_length=20,choices=SUBCITY_CHOICES,default='B')
    woreda = models.IntegerField(default=1)


class User(models.Model):

    first_name = models.CharField(max_length=20, default="")
    last_name = models.CharField(max_length=20, default="")
    username = models.CharField(max_length=20, default="")
    password = models.CharField(max_length=20, default="")
    email = models.EmailField(max_length=30,default="")
    role = models.CharField(max_length=20, default="")
    profile = models.ImageField(null=True)
    address = models.OneToOneField(Address, on_delete=models.CASCADE,default="")
    # unknown field type
    device_id = models.CharField(max_length=20, default="")

    def __str__(self):
        return self.first_name


class Company(models.Model):

    class meta:
        verbose_name_plural = 'Companies'
    company_name = models.CharField(max_length=20)
    company_email = models.EmailField(max_length=30)
    password = models.CharField(max_length=20)
    role = models.CharField(max_length=20)
    logo = models.ImageField()
    address = models.OneToOneField(Address, on_delete=models.CASCADE)
