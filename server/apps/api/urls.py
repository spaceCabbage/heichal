from django.urls import path
from . import views

app_name = 'api'

urlpatterns = [
    path('health/', views.health_check, name='health-check'),
    path('info/', views.api_info, name='api-info'),
]