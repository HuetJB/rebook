from django.urls import path

from .views import ChatDetailView, ChatsListView, create_chat_from_post, delete_chat

urlpatterns = [
    path("create/<int:post_id>/", create_chat_from_post, name="create_chat_from_post"),
    path("", ChatsListView.as_view(), name="personals_chats"),
    path("<int:pk>/", ChatDetailView.as_view(), name="chat_detail"),
    path("<int:chat_id>/delete/", delete_chat, name="delete_chat"),
]
