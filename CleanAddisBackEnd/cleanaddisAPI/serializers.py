from rest_framework import serializers
from .models import Address, Company, User, Waste


class AddressSerializer(serializers.ModelSerializer):
    model = Address
    fields = '__all__'


class UserSerializer(serializers.ModelSerializer):

    address = serializers.RelatedField

    class Meta:
        model = User
        depth = 1
        fields = '__all__'


class CompanySerializer(serializers.ModelSerializer):

    address = AddressSerializer(many=True)

    class Meta:

        model = Company
        depth = 1
        fields = '__all__'


class WasteSerializer(serializers.ModelSerializer):

    class Meta:
        model = Waste
        fields = '__all__'


class BuyerSerializer(serializers.ModelSerializer):

    class Meta:
        model = Waste
        lookup_field = 'buyer'
        fields = '__all__'


class SellerSerializer(serializers.ModelSerializer):

    class Meta:
        model = Waste
        lookup_field = 'seller'
        fields = '__all__'
