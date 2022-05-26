from re import T
from tkinter import CASCADE
from django.db import models
from django.forms import CharField
from django.contrib.auth.models import (
    BaseUserManager, AbstractBaseUser
)
from django.contrib.auth.models import AbstractUser
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


def upload_to(instance, filename):
    return 'images/{filename}'.format(filename=filename)

class User(AbstractUser):

    username = models.CharField(max_length=20,unique=True, default="")
    email = models.EmailField(max_length=30,default="")
    role = models.CharField(max_length=20, default="Resident", null = True)
    profile = models.ImageField(upload_to=upload_to, null=True)
    phone = models.CharField(max_length= 20,null= True)
    device_id = models.CharField(max_length=20, default="",null=True)
    
    class Meta(AbstractUser.Meta):
       swappable = 'AUTH_USER_MODEL'



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
        ('E-waste','E-waste'),
        ('Glass','Glass'),
        ('Fabric','Fabric')
    ]

    DO = [
        ('Sell', 'Sell'),
        ('Donation', 'Donation'),
    ]

    seller = models.ForeignKey(User, on_delete = models.DO_NOTHING )
    buyer = models.ForeignKey(User,null=True,on_delete = models.DO_NOTHING,related_name='buyer')
    waste_name = models.CharField(max_length=20)
    waste_type = models.CharField(max_length=20, choices= TYPE_CHOICES)
    for_waste  = models.CharField(choices= DO, max_length =10)
    price_per_unit = models.IntegerField(null=True)
    quantity = models.IntegerField(null=True)
    metric = models.CharField(null=True, max_length = 20)
    image = models.ImageField(upload_to = upload_to, null = True)
    loaction = models.CharField(max_length=30,null=True)
    sold = models.BooleanField(null=True)
    bought = models.BooleanField(null=True)
    donated = models.BooleanField(null=True)
    description = models.CharField(max_length=200,null=True)
    post_date = models.DateTimeField(auto_now_add=True)

class Report(models.Model):

    
    reportTitle = models.CharField(max_length=20,default="",null=True)
    reportDescription = models.CharField(max_length=20,default="",null=True)
    isResolved = models.BooleanField(default= False)
    image = models.ImageField(upload_to=upload_to, null=True)
    longitude = models.DecimalField(max_digits=12, decimal_places=10)
    latitude = models.DecimalField(max_digits=12, decimal_places=10)
    reportedBy = models.ForeignKey(User, on_delete = models.DO_NOTHING,null= True )
    post_date = models.DateTimeField(auto_now_add=True)
    
class PublicPlace(models.Model):

    TYPE_CHOICES = [
        ('Toilet', 'Toilet'),
        ('Park','Park')
    ]
    placeName = models.CharField(max_length=20,default="",null=True)
    placeType = models.CharField(max_length=20, choices= TYPE_CHOICES)
    rating = models.IntegerField( null=True)
    longitude = models.DecimalField(max_digits= 14,decimal_places=10,unique=True )
    latitude = models.DecimalField(max_digits=14, decimal_places=10, unique=True)

    


class Seminar(models.Model):
    TYPE_CHOICES = [('Meeting','Meeting'),('Plantation','Plantation'),('Cleaning','Cleaning')]
    seminarTitle = models.CharField(max_length=20,default="",null=True)
    seminarDescription = models.CharField(max_length=20,default="",null=True)
    seminarType = models.CharField(max_length=20, choices= TYPE_CHOICES)
    

class WorkSchedule(models.Model):
    workID = models.CharField(max_length=20, default="",null=True)
    date = models.DateField(max_length=20, default="",null=True)
    hour = models.DateField(max_length=20, default="",null=True)
    
class Announcement(models.Model):
    notificationTitle = models.CharField(max_length=20, default="",null=True)
    notificationDescription = models.CharField(max_length=20, default="",null=True)
    formDate = models.DateField(max_length=20, default="",null=True)
    toDate = models.DateField(max_length=20, default="",null=True)
    published = models.DateField(max_length=20, default="",null=True)
    recipient = models.ForeignKey(User, on_delete = models.DO_NOTHING )


