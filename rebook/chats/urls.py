from django.urls import path

from .views import ChatsListView, create_chat_from_post, delete_chat, get_chat, send_message

urlpatterns = [
    path("create/<int:post_id>/", create_chat_from_post, name="create_chat_from_post"),
    path("", ChatsListView.as_view(), name="personals_chats"),
    path("<int:chat_id>/", get_chat, name="chat_detail"),
    path("<int:chat_id>/delete/", delete_chat, name="delete_chat"),
    path("<int:chat_id>/send_message/", send_message, name="send_message"),
]
