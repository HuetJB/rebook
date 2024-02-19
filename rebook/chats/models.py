from accounts.models import UserProfile
from django.db.models import CASCADE, DateTimeField, ForeignKey, Model, TextField
from posts.models import Post


class Chat(Model):
    created_at = DateTimeField(auto_now_add=True)
    purchaser = ForeignKey(UserProfile, on_delete=CASCADE)
    post = ForeignKey(Post, on_delete=CASCADE, related_name="chats")

    def __str__(self):
        return f"{self.post} - {self.seller} - {self.purchaser}"


class Message(Model):
    message = TextField()
    send_at = DateTimeField(auto_now_add=True)
    sender = ForeignKey(UserProfile, on_delete=CASCADE)
    chat = ForeignKey(Chat, on_delete=CASCADE, related_name="messages")

    def __str__(self):
        return self.message
