from cgitb import lookup
from hashlib import new
from django.shortcuts import render
from rest_framework.views import APIView


from rest_framework import generics,permissions ,authentication

from rest_framework import mixins
from rest_framework.response import Response
from rest_framework import status
from .models import *
from .serializers import *




class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class =  UserSerializer

class UserListView(generics.ListAPIView):

    queryset = User.objects.all()
    serializer_class = UserSerializer


class UserDetailView(generics.RetriveAPIView):
    authentication_classes = [authentication.TokenAuthentication]
    queryset = User.objects.all()
    serializer_class = UserSerializer

class UserDeleteView(generics.DestroyAPIView):
    authentication_classes = [authentication.TokenAuthentication]
    queryset = User.objects.all()
    serilaizer_class = UserSerializer


class UserUpdateView(generics.DestroyAPIView):
    authentication_classes = [authentication.TokenAuthentication]
    queryset = User.objects.all()
    serilaizer_class = UserSerializer


class UserView(APIView):

    def get(self, request):
 
        users = User.objects.all()

        serializer = UserSerializer(users, many=True)

        return Response(serializer.data)

    def post(self, request):

        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            question = serializer.save()
            serializer = UserSerializer(question)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class UserDetail(APIView):

    def get_object(self, id):
        try:
            return User.objects.get(id=id)
        except User.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

    def get(self, request, id):

        user = self.get_object(id)

        serializer = UserSerializer(user)

        return Response(serializer.data)

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




class ReportCreateAPIView(generics.CreateAPIView):

    query = Waste.objects.all()

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
            reportedBy = self.kwargs['reportedBy'])
report_list_view = ReportAPIView.as_view()


class SellerAPIView(generics.ListAPIView):
    authentication_classes = [authentication.TokenAuthentication]
    queryset = Waste.objects.all()
    serializer_class = SellerSerializer
    lookup_field = 'seller'

    def get_queryset(self):

        return super().get_queryset().filter(
            seller=self.kwargs['seller'])


seller_list_view = SellerAPIView.as_view()



class SellerAPIView(generics.ListAPIView):
    
    authentication_classes = [authentication.TokenAuthentication]
    queryset = Waste.objects.all()
    serializer_class = SellerSerializer
    lookup_field = 'seller'

    def get_queryset(self):

        return super().get_queryset().filter(
            seller=self.kwargs['seller'])


seller_list_view = SellerAPIView.as_view()


class WasteCreateAPIView(generics.CreateAPIView):

    queryset = Waste.objects.all()

    serializer_class = WasteSerializer

    def perform_create(self, serializer):
        return super().perform_create(serializer)


waste_create_view = WasteCreateAPIView.as_view()

class WasteDetailAPIView(generics.RetrieveAPIView):

    queryset = Waste.objects.all()
    serializer_class = WasteSerializer
    lookup_field = 'pk'

waste_detail_view = WasteDetailAPIView().as_view()


class BuyerAPIView(generics.ListAPIView):
    queryset = Waste.objects.all()
    serializer_class = SellerSerializer
    lookup_field = 'buyer'


    def get_queryset(self):

        return super().get_queryset().filter(
            seller = self.kwargs['buyer'])

buyer_list_view = BuyerAPIView.as_view()


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
