from json import dumps as json_dumps
from json import loads as json_loads

from accounts.models import UserProfile
from asgiref.sync import async_to_sync
from channels.generic.websocket import WebsocketConsumer

from .models import Chat, Message


class ChatsConsumer(WebsocketConsumer):
    def __init__(self, *args, **kwargs):
        super().__init__(args, kwargs)
        self.chat_id = None
        self.chat_group_name = None
        self.chat = None
        self.user = None

    def _user_auth_check(self):
        return self.user.is_authenticated and (self.chat.get_seller() == self.user or self.chat.purchaser == self.user)

    def connect(self):
        self.chat_id = self.scope["url_route"]["kwargs"]["chat_id"]
        self.chat_group_name = f"chat_{self.chat_id}"
        self.chat = Chat.objects.get(id=self.chat_id)
        self.user: UserProfile = self.scope["user"]

        if self._user_auth_check():
            # connection has to be accepted
            self.accept()

            # join the room group
            async_to_sync(self.channel_layer.group_add)(
                self.chat_group_name,
                self.channel_name,
            )
        else:
            self.close()

    def disconnect(self, close_code):
        async_to_sync(self.channel_layer.group_discard)(
            self.chat_group_name,
            self.channel_name,
        )

    def receive(self, text_data=None, bytes_data=None):
        text_data_json = json_loads(text_data)
        message = text_data_json["message"]

        if not self._user_auth_check():
            return

        message = Message.objects.create(message=message, sender=self.user, chat=self.chat)

        # send chat message event to the room
        async_to_sync(self.channel_layer.group_send)(
            self.chat_group_name, {"type": "chat_message", "message": message.to_dict()}
        )

    def chat_message(self, event):
        self.send(text_data=json_dumps(event))
