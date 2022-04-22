from django.urls import path

from .views import *
from rest_framework.authtoken.views import obtain_auth_token
from rest_framework_simplejwt import views as jwt_views

urlpatterns = [
    
    path('api/users/', user_signup_view),
    path('api/user/<int:id>',UserDetail.as_view()),
    path('api/companies/',CompanyAPIView.as_view()),
    path('api/waste/<int:pk>', waste_detail_view),
    path('api/waste/<int:pk>/update', waste_update_view),
    path('api/waste/delete/<int:pk>', waste_delete_view),
    path('api/waste/seller/<int:seller>', seller_list_view),
    path('api/waste/buyer/<int:buyer>', buyer_list_view),
    path('api/waste/', waste_create_view),
    path('api/report/',ReportView.as_view()),
    path('api/auth/', jwt_views.token_obtain_pair),
    path('api/auth/refresh', jwt_views.token_refresh),
]
