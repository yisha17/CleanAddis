from django.urls import path

from .views import *

urlpatterns = [
    path('api/users/', UserView.as_view()),
    path('api/user/<int:id>',UserDetail.as_view()),
    path('api/companies/',CompanyAPIView.as_view()),
    path('api/waste/<int:id>', WasteAPIView.as_view()),
    path('api/waste/seller/<int:id>', seller_list_view),
    path('api/waste/', waste_create_view),
    path('api/report/', report_create_view),
    path('api/report/<int:pk>', report_detail_view),
    path('api/report/<int:pk>/update', report_update_view),
    path('api/report/delete/<int:pk>', report_delete_view),
    path('api/report/reportlist/<int:reportedBy>',report_list_view),


]
