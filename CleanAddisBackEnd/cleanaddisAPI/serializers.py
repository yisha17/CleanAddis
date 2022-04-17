from cgitb import lookup
from dataclasses import field
from rest_framework import serializers
from yaml import serialize
from .models import Address, Announcement, Company, PublicPlace, Report, Seminar, User, Waste, WorkSchedule


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
