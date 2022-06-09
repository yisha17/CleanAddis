from cgitb import lookup
from hashlib import new

from telnetlib import STATUS
from turtle import title
from django.http import JsonResponse

from django.shortcuts import render
from rest_framework.views import APIView
from django.contrib.auth import authenticate
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework import generics, permissions, authentication
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.permissions import AllowAny,IsAdminUser,IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from .models import *
from .serializers import *
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes
from django.views.decorators.csrf import csrf_exempt

from rest_framework.parsers import MultiPartParser, FormParser
from geopy.distance import geodesic
from math import sin, cos, sqrt, atan2, radians
from firebase_admin.messaging import Message,Notification
from fcm_django.models import FCMDevice
from push_notifications.models import GCMDevice


@csrf_exempt
def notify(request):
    if request.method == "POST":
        # devices = FCMDevice.objects.filter(name="Deutsch")
        # # devices.send_message(title='heelods',body='sdfsdf',data = {"test":"test"})
        # # devices.send_message(Message(
        # # notification=Notification(data={"title":"76687989","payload":" my payload payload"}),))
        # devices.send_message(
        #     # title="It's now or never: Horn Ok is back!",
        #     # message="Book now to get 50% off!",
        #     # data={
        #     #     "title": "Sfdg",
        #     #     "body": "sgdgsg"
        #     # }
        #     Message(
        #         notification=Notification(
        #             title="title", body="text", image="url"),
        #         topic="Optional topic parameter: Whatever you want",
        #     )
        #     )
        devices = GCMDevice.objects.filter(name="yisak12")
        devices.send_message("Happy name day!")
        return JsonResponse({"status": "ok"})
class RegisterView(generics.GenericAPIView):
    permission_classes = [AllowAny]
    queryset = User.objects.all()
    serializer_class = RegisterSerializer

    def post(self, request, *args,  **kwargs):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            if user:
                json = serializer.data
                return Response(json, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


user_signup_view = RegisterView.as_view()


class MyTokenObtainPairView(TokenObtainPairView):
    serializer_class = MyTokenObtainPairSerializer
custom_token_obtain = MyTokenObtainPairView.as_view()


class UserListView(generics.ListAPIView):

    queryset = User.objects.all()
    serializer_class = UserSerializer
all_user_view = UserListView.as_view()

class UserDetailView(generics.RetrieveAPIView):
    authentication_classes = [authentication.TokenAuthentication]
    queryset = User.objects.all()
    serializer_class = UserSerializer


class UserDeleteView(generics.DestroyAPIView):
    authentication_classes = [authentication.TokenAuthentication]
    queryset = User.objects.all()
    serilaizer_class = UserSerializer


class UserUpdatePasswordView(generics.UpdateAPIView):
    permission_classes = [AllowAny]
    queryset = User.objects.all()
    print("is it what i am seeeing")
    serializer_class = UpdatePasswordSerializer
    lookup_field = 'pk'

user_password_update = UserUpdatePasswordView.as_view()


# class UserUpdateProfileView(generics.UpdateAPIView):
#     permission_classes = [AllowAny]
#     queryset = User.objects.all()
#     serializer_class = UpdateProfileSerializer
#     parser_classes = (MultiPartParser, FormParser)

#     lookup_field = 'pk'
    

# user_profile_update = UserUpdateProfileView.as_view()

class UserView(APIView):

    def get(self, request):

        users = User.objects.all()

        serializer = UserSerializer(users, many=True)

        return Response(serializer.data)

    def post(self, request):
        print("here it is")
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            question = serializer.save()
            serializer = UserSerializer(question)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class UserDetail(APIView):
    parser_classes = (MultiPartParser, FormParser)
    def get_object(self, id):
        try:
            return User.objects.get(id=id)
        except User.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def get(self, request, id):

        user = self.get_object(id)
        
        serializer = UserSerializer(user, context={"request":
                                                   request})
        permission_classes = (IsAdminUser,IsAuthenticated)
        report = Report.objects.filter(reportedBy=id).count()
        sell = Waste.objects.filter(for_waste='Sell', seller=id).count()
        donate = Waste.objects.filter(for_waste='Donation', seller=id).count()
        print(sell)
        print(donate)
        new_dict = {
            "report_count": report,
            "donation_count": donate,
            "sell_count": sell}
        new_dict.update(serializer.data)
        return Response(new_dict)

    def put(self, request, id):

        user = self.get_object(id)

        user_data = request.data
        print(user_data)
        try:
            updated_address = Address.objects.get(
                subcity=user_data['address']['subcity'],
                woreda=user_data['address']['woreda'])
        except Address.DoesNotExist:

            updated_address = Address.objects.create(
                subcity=user_data['address']['subcity'],
                woreda=user_data['address']['woreda'])

        user = User.objects.create(

            first_name=user_data['first_name'],
            last_name=user_data['last_name'],
            username=user_data['username'],
            email=user_data['email'],
            role=user_data['role'],
            password=user_data['password'],
            address=updated_address
        )
        user.save()

        serializer = UserSerializer(user)

        if serializer.is_valid():
            return Response(serializer.data)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id):

        user = self.get_object(id)
        user.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


class CompanyAPIView(APIView):

    def get(self, request):
        company = Company.objects.all()
        serializer = CompanySerializer(company, many=True)
        return Response(serializer.data)

    def post(self, request):

        company_data = request.data

        new_company = Company.objects.create(
            address=Address.objects.get(id=company_data['address']),
            company_name=company_data['company_name'],
            company_email=company_data['company_email'],
            password=company_data['password'],
            role=company_data['role'],
            logo=company_data['logo']
        )

        new_company.save()

        serializer = CompanySerializer(new_company)
        print(serializer.data)
        if serializer.is_valid():
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class RegisterWebView(generics.CreateAPIView):
    
    query = User.objects.all()
    serializer_class = RegisterWebSerializer

user_web_signup = RegisterWebView.as_view()
class ReportCreateAPIView(generics.CreateAPIView):

    query = Report.objects.all()
    parser_classes = (MultiPartParser, FormParser)
    serializer_class = ReportSerializer

    def perform_create(self, serializer):
        return super().perform_create(serializer)


report_create_view = ReportCreateAPIView.as_view()


class ReportDetailAPIView(generics.RetrieveAPIView):

    queryset = Report.objects.all()
    serializer_class = ReportSerializer
    lookup_field = 'pk'


report_detail_view = ReportDetailAPIView().as_view()


class ReportUpdateAPIView(generics.UpdateAPIView):

    queryset = Report.objects.all()
    serializer_class = ReportSerializer
    lookup_field = 'pk'


report_update_view = ReportUpdateAPIView.as_view()


class ReportDeleteAPIView(generics.DestroyAPIView):

    queryset = Report.objects.all()
    serializer_class = ReportSerializer
    lookup_field = 'pk'


report_delete_view = ReportDeleteAPIView.as_view()


class ReportAPIView(generics.ListAPIView):
    queryset = Report.objects.all()
    serializer_class = ReporterSerializer
    lookup_field = 'reportedBy'

    def get_queryset(self):
        return super().get_queryset().filter(
            reportedBy=self.kwargs['reportedBy'])


report_list_view = ReportAPIView.as_view()


class ReportAllAPIView(generics.ListAPIView):
    queryset = Report.objects.all()
    serializer_class = ReporterSerializer


all_report_list_view = ReportAllAPIView.as_view()


class PublicPlaceCreateAPIView(generics.CreateAPIView):

    query = PublicPlace.objects.all()

    serializer_class = PublicPlaceSerializer

    def perform_create(self, serializer):
        return super().perform_create(serializer)


publicplace_create_view = PublicPlaceCreateAPIView.as_view()


class PublicPlaceDetailAPIView(generics.RetrieveAPIView):

    queryset = PublicPlace.objects.all()
    serializer_class = PublicPlaceSerializer
    lookup_field = 'pk'


publicplace_detail_view = PublicPlaceDetailAPIView().as_view()

class PublicPlaceListAPIView(generics.ListAPIView):

    queryset = PublicPlace.objects.all()
    serializer_class = PublicPlaceSerializer
    lookup_field = 'pk'


all_publicplace_view = PublicPlaceListAPIView().as_view()


class PublicPlaceUpdateAPIView(generics.UpdateAPIView):

    queryset = PublicPlace.objects.all()
    serializer_class = PublicPlaceSerializer
    lookup_field = 'pk'


publicplace_update_view = PublicPlaceUpdateAPIView.as_view()


class PublicPlaceDeleteAPIView(generics.DestroyAPIView):

    queryset = PublicPlace.objects.all()
    serializer_class = PublicPlaceSerializer
    lookup_field = 'pk'


publicplace_delete_view = PublicPlaceDeleteAPIView.as_view()


class PublicPlaceList(generics.ListAPIView):
    queryset = PublicPlace.objects.all()
    serializer_class = PublicPlaceSerializer

    # def get_queryset(self):
    #     return super().get_queryset().filter(
    #         placeType=self.kwargs['placeType'])


publicplace_list_view = PublicPlaceList.as_view()


class SeminarCreateAPIView(generics.CreateAPIView):

    query = Seminar.objects.all()

    serializer_class = SeminarSerializer

    def perform_create(self, serializer):
        return super().perform_create(serializer)


seminar_create_view = SeminarCreateAPIView.as_view()


class SeminarListAPIView(generics.ListAPIView):

    queryset = Seminar.objects.all()
    lookup_field = 'pk'
    serializer_class = SeminarSerializer

seminar_list_view = SeminarListAPIView.as_view()


class SeminarDetailAPIView(generics.RetrieveAPIView):

    queryset = Seminar.objects.all()
    serializer_class = SeminarSerializer
    lookup_field = 'pk'


seminar_detail_view = SeminarDetailAPIView().as_view()


class SeminarUpdateAPIView(generics.UpdateAPIView):

    queryset = Seminar.objects.all()
    serializer_class = SeminarSerializer
    lookup_field = 'pk'


seminar_update_view = SeminarUpdateAPIView.as_view()


class SeminarDeleteAPIView(generics.DestroyAPIView):

    queryset = Seminar.objects.all()
    serializer_class = SeminarSerializer
    lookup_field = 'pk'


seminar_delete_view = SeminarDeleteAPIView.as_view()


class WorkScheduleCreateAPIView(generics.CreateAPIView):

    query = WorkSchedule.objects.all()

    serializer_class = WorkScheduleSerializer

    def perform_create(self, serializer):
        return super().perform_create(serializer)


workschedule_create_view = WorkScheduleCreateAPIView.as_view()


class WorkScheduleDetailAPIView(generics.RetrieveAPIView):

    queryset = WorkSchedule.objects.all()
    serializer_class = WorkScheduleSerializer
    lookup_field = 'pk'


workschedule_detail_view = WorkScheduleDetailAPIView().as_view()

class WorkScheduleListAPIView(generics.ListAPIView):

    queryset = WorkSchedule.objects.all()
    serializer_class = WorkScheduleSerializer
    lookup_field = 'pk'


all_workschedule_view = WorkScheduleListAPIView().as_view()


class WorkScheduleUpdateAPIView(generics.UpdateAPIView):

    queryset = WorkSchedule.objects.all()
    serializer_class = WorkScheduleSerializer
    lookup_field = 'pk'


workschedule_update_view = WorkScheduleUpdateAPIView.as_view()


class WorkScheduleDeleteAPIView(generics.DestroyAPIView):

    queryset = WorkSchedule.objects.all()
    serializer_class = WorkScheduleSerializer
    lookup_field = 'pk'


workschedule_delete_view = WorkScheduleDeleteAPIView.as_view()


class AnnouncementCreateAPIView(generics.CreateAPIView):

    query = Announcement.objects.all()

    serializer_class = AnnouncementSerializer

    def perform_create(self, serializer):
        title = self.request.data['notificationTitle']
        description = self.request.data['notificationDescription']
        devices = FCMDevice.objects.filter(name="Deutsch")
        print(devices)
        wer = devices.send_message(Message(
             data={
            "title":title,
            "body":description
        }))
        wer
        print(wer)
        print(title)
        return super().perform_create(serializer)


announcement_create_view = AnnouncementCreateAPIView.as_view()




class AnnouncementDetailAPIView(generics.RetrieveAPIView):

    queryset = Announcement.objects.all()
    serializer_class = AnnouncementSerializer
    lookup_field = 'pk'


announcement_detail_view = AnnouncementDetailAPIView().as_view()


class AnnouncementUpdateAPIView(generics.UpdateAPIView):

    queryset = Announcement.objects.all()
    serializer_class = AnnouncementSerializer
    lookup_field = 'pk'


announcement_update_view = AnnouncementUpdateAPIView.as_view()


class AnnouncementListAPIView(generics.ListAPIView):

    queryset = Announcement.objects.all()
    serializer_class = AnnouncementSerializer
    lookup_field = 'pk'

all_announcement_view = AnnouncementListAPIView.as_view()




class AnnouncementDeleteAPIView(generics.DestroyAPIView):

    queryset = Announcement.objects.all()
    serializer_class = AnnouncementSerializer
    lookup_field = 'pk'


announcement_delete_view = AnnouncementDeleteAPIView.as_view()


class SellerAPIView(generics.ListAPIView):

    permission_classes = (permissions.IsAuthenticated,)
    queryset = Waste.objects.all()
    serializer_class = SellerSerializer
    lookup_field = 'seller'

    def get_queryset(self, type='Plastic'):
        lists = super().get_queryset().filter(
            seller=self.kwargs['seller']).order_by('-post_date')
        return lists


seller_list_view = SellerAPIView.as_view()


class SellerAPIViewByType(generics.ListAPIView):

    permission_classes = (permissions.IsAuthenticated,)
    queryset = Waste.objects.all()
    serializer_class = SellerSerializer
    lookup_field = 'seller'
    filter_fields = ('for_waste', 'waste_type')

    def get_queryset(self):

        lists = super().get_queryset().filter(
            seller=self.kwargs['seller'],
            for_waste=self.kwargs['for_waste'],
            waste_type=self.kwargs['waste_type']).order_by('-post_date')
        print(lists)
        return lists


seller_list_view_by_type = SellerAPIViewByType.as_view()


class WasteCreateAPIView(generics.CreateAPIView):

    queryset = Waste.objects.all()
    parser_classes = (MultiPartParser, FormParser)
    serializer_class = WasteSerializer
    permission_classes = (permissions.IsAuthenticated,)
    
    def perform_create(self, serializer):
        print("herisdfn")
        return super().perform_create(serializer)


waste_create_view = WasteCreateAPIView.as_view()


class WasteDetailAPIView(generics.RetrieveAPIView):

    queryset = Waste.objects.all()
    serializer_class = WasteSerializer
    lookup_field = 'pk'


waste_detail_view = WasteDetailAPIView().as_view()


class WasteAllAPIView(generics.ListAPIView):
    queryset = Waste.objects.all()
    serializer_class = WasteSerializer
    lookup_field = 'pk'


all_waste_list_view = WasteAllAPIView().as_view()


class BuyerAPIView(generics.ListAPIView):
    queryset = Waste.objects.all()
    serializer_class = SellerSerializer
    lookup_field = 'buyer'

    def get_queryset(self):
        return super().get_queryset().filter(
            buyer=self.kwargs['buyer']).order_by('-post_date')


buyer_list_view = BuyerAPIView.as_view()


class AvailableWasteAPIView(generics.ListAPIView):
    queryset = Waste.objects.all()
    serializer_class = WasteSerializer
    lookup_field = 'waste_type'

    def get_queryset(self, sold=False, for_waste='Sell'):
        return super().get_queryset().filter(
            sold=sold, for_waste=for_waste,
            waste_type=self.kwargs['waste_type'],
        ).order_by('-post_date')


waste_list_for_sell = AvailableWasteAPIView.as_view()


class WasteUpdateAPIView(generics.UpdateAPIView):

    queryset = Waste.objects.all()

    serializer_class = WasteSerializer

    lookup_field = 'pk'


waste_update_view = WasteUpdateAPIView.as_view()


class WasteDeleteAPIView(generics.DestroyAPIView):

    queryset = Waste.objects.all()

    serializer_class = WasteSerializer

    lookup_field = 'pk'


waste_delete_view = WasteDeleteAPIView.as_view()


class NotificationCreateView(generics.CreateAPIView):

    queryset = Notifications.objects.all()

    serializer_class = NotificationSerializer


notification_create_view = NotificationCreateView.as_view()


class NotificationView(generics.ListAPIView):

    queryset = Notifications.objects.all()
    serializer_class = NotificationSerializer

    def get_queryset(self):
        return super().get_queryset().filter(
            
        )
