from django.urls import path

from .views import CreatePostView, FavouritesPostsView, PersonnalsPostsView, PostView, delete_post, favourite_post

urlpatterns = [
    path("<int:pk>/", PostView.as_view(), name="post_detail"),
    path("create/", CreatePostView.as_view(), name="post_create"),
    path("personnals/", PersonnalsPostsView.as_view(), name="personnals_posts"),
    path("favourites/", FavouritesPostsView.as_view(), name="favourites_posts"),
    path("<int:post_id>/favourite/", favourite_post, name="favourite_post"),
    path("<int:post_id>/delete/", delete_post, name="delete_post"),
]
