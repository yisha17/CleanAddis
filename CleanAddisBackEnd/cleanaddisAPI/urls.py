from django.urls import path

from .views import *
from rest_framework.authtoken.views import obtain_auth_token
urlpatterns = [
    path('/auth',obtain_auth_token),
    path('api/users/', UserView.as_view()),
    path('api/user/<int:id>',UserDetail.as_view()),
    path('api/companies/',CompanyAPIView.as_view()),
    path('api/waste/<int:pk>', waste_detail_view),
    path('api/waste/<int:pk>/update', waste_update_view),
    path('api/waste/delete/<int:pk>', waste_delete_view),
    path('api/waste/seller/<int:seller>', seller_list_view),
    path('api/waste/buyer/<int:buyer>', buyer_list_view),
    path('api/waste/', waste_create_view),
    path('api/report/', report_create_view),
    path('api/report/<int:pk>', report_detail_view),
    path('api/report/<int:pk>/update', report_update_view),
    path('api/report/delete/<int:pk>', report_delete_view),
    path('api/report/reportlist/<int:reportedBy>',report_list_view),
    path('api/publicplace/', publicplace_create_view),
    path('api/publicplace/<int:pk>', publicplace_detail_view),
    path('api/publicplace/<int:pk>/update', publicplace_update_view),
    path('api/publicplace/delete/<int:pk>', publicplace_delete_view),
    path('api/seminar/', seminar_create_view),
    path('api/seminar/<int:pk>', seminar_detail_view),
    path('api/seminar/<int:pk>/update', seminar_update_view),
    path('api/seminar/delete/<int:pk>', seminar_delete_view),
]
