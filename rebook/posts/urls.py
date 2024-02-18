from django.urls import path

from .views import CreatePostView, FavouritesPostsView, PersonnalsPostsView, PostView, post_favourite_action

urlpatterns = [
    path("<int:pk>/", PostView.as_view(), name="post_detail"),
    path("create/", CreatePostView.as_view(), name="post_create"),
    path("personnals/", PersonnalsPostsView.as_view(), name="personnals_posts"),
    path("favourites/", FavouritesPostsView.as_view(), name="favourites_posts"),
    path("favourites/<int:id>/", post_favourite_action, name="post_favourite_action"),
]
