from django.urls import path

from .views import *

urlpatterns = [
    path('api/users/', UserView.as_view()),
    path('api/user/<int:id>',UserDetail.as_view()),
    path('api/companies/',CompanyAPIView.as_view()),
    path('api/waste/<int:id>', WasteAPIView.as_view()),
    path('api/waste/seller/<int:id>', seller_list_view),
    path('api/waste/', waste_create_view),
    path('api/report/',ReportView.as_view()),

]
