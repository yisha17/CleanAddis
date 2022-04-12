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
        ('Nifas Silk','NS'),
        ('Kolfe','Kolfe')

    ]

    subcity = models.CharField(max_length=20,choices=SUBCITY_CHOICES,default='B')
    woreda = models.IntegerField(default=1)


class User(models.Model):

    username = models.CharField(max_length=20, default="")
    password = models.CharField(max_length=20, default="")
    email = models.EmailField(max_length=30,default="")
    role = models.CharField(max_length=20, default="",null = True)
    profile = models.ImageField(null=True)
    address = models.ForeignKey(Address, on_delete=models.DO_NOTHING,null=True)
    phone = models.CharField(max_length= 20,null= True)
    # unknown field type
    device_id = models.CharField(max_length=20, default="",null=True)

    def __str__(self):
        return self.first_name

    def __iter__(self):
        return [field.value_to_string(self) for field in Address._meta.fields]


class Company(models.Model):

    class meta:
        verbose_name_plural = 'Companies'
    company_name = models.CharField(max_length=20)
    company_email = models.EmailField(max_length=30)
    password = models.CharField(max_length=20)
    role = models.CharField(max_length=20)
    logo = models.ImageField(null = True)
    address = models.ForeignKey(Address, on_delete=models.CASCADE)

    def __str__(self):
        return self.company_name



class Waste(models.Model):

    

    TYPE_CHOICES = [
        ('Plastic', 'Plastic'),
        ('Organic','Organic'),
        ('Metal','Metal'),
        ('Aluminium', 'Almuinium'),
        ('Paper','Paper'),
        ('Old Gadgets','Old Gadgets'),
        ('Glass','Glass')
    ]

    waste_name = models.CharField(max_length=20)
    waste_type = models.CharField(max_length=20, choices= TYPE_CHOICES)
    price_per_unit = models.IntegerField(null=True)
    quantity = models.IntegerField(null=True)
    weight = models.IntegerField(null=True)
    image = models.ImageField(null = True)
    loaction = models.CharField(max_length=30,null=True)
    sold = models.BooleanField(null=True)
    bought = models.BooleanField(null=True)
    donated = models.BooleanField(null=True)
    description = models.CharField(max_length=200,null=True)
    
    
