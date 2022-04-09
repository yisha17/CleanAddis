from django.urls import path

from .views import CompanyAPIView, UserView, UserDetail

urlpatterns = [
    path('api/users/', UserView.as_view()),
    path('api/user/<int:id>',UserDetail.as_view()),
    path('api/companies/',CompanyAPIView.as_view())
]
