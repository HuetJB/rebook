from django.urls import path

from .consumers import ChatsConsumer

websocket_urlpatterns = [
    path("ws/chats/<int:chat_id>/", ChatsConsumer.as_asgi()),
]
