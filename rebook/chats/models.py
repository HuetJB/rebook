from accounts.models import UserProfile
from django.db.models import CASCADE, DateTimeField, ForeignKey, Model, TextField
from posts.models import Post


class Chat(Model):
    created_at = DateTimeField(auto_now_add=True)
    purchaser = ForeignKey(UserProfile, on_delete=CASCADE)
    post = ForeignKey(Post, on_delete=CASCADE, related_name="chats")

    def get_seller(self):
        return self.post.seller

    def __str__(self):
        return f"{self.post} - {self.get_seller()} - {self.purchaser}"


class Message(Model):
    message = TextField()
    send_at = DateTimeField(auto_now_add=True)
    sender = ForeignKey(UserProfile, on_delete=CASCADE)
    chat = ForeignKey(Chat, on_delete=CASCADE, related_name="messages")

    def __str__(self):
        return self.message

    def get_send_at(self) -> str:
        return self.send_at.strftime("%Y-%m-%d %H:%M:%S")

    def to_dict(self) -> dict:
        return {"sender": self.sender.username, "message": self.message, "send_at": self.get_send_at()}
