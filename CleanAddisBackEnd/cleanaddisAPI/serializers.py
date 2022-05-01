from cgitb import lookup
from dataclasses import field
from rest_framework import serializers
from yaml import serialize
from .models import Address, Announcement, Company, PublicPlace, Report, Seminar, User, Waste, WorkSchedule





class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        extra_kwargs = {'password': {'write_only': True}}
        fields = '__all__'


class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username','email', 'password']
        extra_kwargs = {
            'password': {'write_only': True},
        }
    def create(self, validated_data):
        password = validated_data.pop('password', None)
        # as long as the fields are the same, we can just use this
        instance = self.Meta.model(**validated_data)
        if password is not None:
            instance.set_password(password)
        instance.save()
        return instance    
    # def create(self, validated_data):
    #     user = User(
    #         username = validated_data['username'],    
    #         email = validated_data['email'], 
    #         )
    #     user.set_password(validated_data['password'])
    #     return user

    # def create(self, validated_data):
    #     user = User(
    #         email=validated_data['email'],
    #         username=validated_data['username']
    #     )
    #     user.set_password(validated_data['password'])
    #     user.save()
    #     return user


class AddressSerializer(serializers.ModelSerializer):
    model = Address
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

class ReportSerializer(serializers.ModelSerializer):

    class Meta:
        model = Report
        fields = '__all__'
class ReporterSerializer(serializers.ModelSerializer):

    class Meta:
        model = Report
        fields = '__all__'
        lookup_field = 'reportedBy'
class PublicPlaceSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = PublicPlace
        fields = '__all__'
class SeminarSerializer(serializers.ModelSerializer):

    class Meta:
        model = Seminar
        fields = '__all__'
class WorkScheduleSerializer(serializers.ModelSerializer):

    class Meta:
        model = WorkSchedule
        fields = '__all__'
class AnnouncementSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Announcement
        fields = '__all__'
