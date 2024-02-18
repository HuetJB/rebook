from django.urls import path

from .views import CreatePostView, PostView

urlpatterns = [
    path("<int:pk>/", PostView.as_view(), name="post_detail"),
    path("create/", CreatePostView.as_view(), name="post_create"),
]
