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
    phone = models.CharField(max_length= 20,null= True)
    # unknown field type
    device_id = models.CharField(max_length=20, default="",null=True)

   

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

    DO = [
        ('Sell', 'Sell'),
        ('Donate', 'Donate'),
    ]

    seller = models.ForeignKey(User, on_delete = models.DO_NOTHING )
    buyer = models.ForeignKey(User,null=True,on_delete = models.DO_NOTHING,related_name='buyer')
    waste_name = models.CharField(max_length=20)
    waste_type = models.CharField(max_length=20, choices= TYPE_CHOICES)
    for_waste  = models.CharField(choices= DO, max_length =10)
    price_per_unit = models.IntegerField(null=True)
    quantity = models.IntegerField(null=True)
    metric = models.CharField(null=True, max_length = 20)
    image = models.ImageField(null = True)
    loaction = models.CharField(max_length=30,null=True)
    sold = models.BooleanField(null=True)
    bought = models.BooleanField(null=True)
    donated = models.BooleanField(null=True)
    description = models.CharField(max_length=200,null=True)
class Report(models.Model):

    reportID = models.CharField(max_length=20, default="",null=True)
    reportTitle = models.CharField(max_length=20,default="",null=True)
    reportDescription = models.CharField(max_length=20,default="",null=True)
    image = models.ImageField(null=True)    
    loaction = models.CharField(max_length=30,null=True)
    reportedBy = models.ForeignKey(User, on_delete = models.DO_NOTHING )
    
    
class PublicPlace(models.Model):

    TYPE_CHOICES = [
        ('Toilet', 'Toilet'),
        ('Park','Park')
    ]
    placeID = models.CharField(max_length=20, default="",null=True)
    placeName = models.CharField(max_length=20,default="",null=True)
    placeType = models.CharField(max_length=20, choices= TYPE_CHOICES)
    rating = models.CharField(max_length=5,default="",null=True)
    loaction = models.CharField(max_length=30,null=True)

class Seminar(models.Model):
    TYPE_CHOICES = [('Meeting','Meeting'),('Plantation','Plantation'),('Cleaning','Cleaning')]
    seminarID = models.CharField(max_length=20, default="",null=True)
    seminarTitle = models.CharField(max_length=20,default="",null=True)
    seminarDescription = models.CharField(max_length=20,default="",null=True)
    seminarType = models.CharField(max_length=20, choices= TYPE_CHOICES)
    loaction = models.CharField(max_length=30,null=True)

class WorkSchedule(models.Model):
    workID = models.CharField(max_length=20, default="",null=True)
    date = models.DateField(max_length=20, default="",null=True)
    hour = models.DateField(max_length=20, default="",null=True)
    
class Announcement(models.Model):
    notificationID = models.IntegerField(max_length=20,default="",null=True)
    notificationTitle = models.CharField(max_length=20, default="",null=True)
    notificationDescription = models.CharField(max_length=20, default="",null=True)
    formDate = models.DateField(max_length=20, default="",null=True)
    toDate = models.DateField(max_length=20, default="",null=True)
    published = models.DateField(max_length=20, default="",null=True)
    recipient = models.ForeignKey(User, on_delete = models.DO_NOTHING )

