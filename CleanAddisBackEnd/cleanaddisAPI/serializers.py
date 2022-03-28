from rest_framework import serializers
from .models import Address, Company, User



class AddressSerializer(serializers.ModelSerializer):
    model = Address
    fields = '__all__'

class UserSerializer(serializers.ModelSerializer):
    
    address = AddressSerializer()
    class Meta:
        model = User
        depth = 1
        fields = '__all__'



    

class CompanySerializer(serializers.ModelSerializer):

    address = AddressSerializer()
    
    class Meta:

        model = Company
        depth = 1
        fields = '__all__'




   
