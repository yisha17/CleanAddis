from rest_framework import serializers
from .models import Address, User



class AddressSerializer(serializers.ModelSerializer):
    model = Address
    fields = ['subcity','woreda']

class UserSerializer(serializers.Serializer):
    address = AddressSerializer(read_only = True)
    class Meta:
        model = User
        fields = '__all__'



   
