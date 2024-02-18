from django.urls import path

from .views import PostView

urlpatterns = [
    path("<int:pk>/", PostView.as_view(), name="post_detail"),
]
