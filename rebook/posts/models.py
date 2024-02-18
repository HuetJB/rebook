from accounts.models import UserProfile
from django.db.models import CASCADE, CharField, DateField, DateTimeField, ForeignKey, ImageField, IntegerField, Model

from rebook.settings import IMAGES_FOLDER


class Post(Model):
    title = CharField(max_length=100)
    description = CharField(max_length=1000)
    created_at = DateTimeField(auto_now_add=True)
    price = IntegerField()
    seller = ForeignKey(UserProfile, on_delete=CASCADE)

    book_title = CharField(max_length=100)
    book_author = CharField(max_length=100)
    book_published_at = DateField()

    image_1 = ImageField(upload_to=IMAGES_FOLDER, blank=True, null=True)
    image_2 = ImageField(upload_to=IMAGES_FOLDER, blank=True, null=True)
    image_3 = ImageField(upload_to=IMAGES_FOLDER, blank=True, null=True)

    def __unicode__(self):
        return f"{self.title} - {self.book_title} ({self.book_author}) - {self.seller.__unicode__()}"


class Favorite(Model):
    user = ForeignKey(UserProfile, on_delete=CASCADE)
    post = ForeignKey(Post, on_delete=CASCADE)
    created_at = DateTimeField(auto_now_add=True)

    def __unicode__(self):
        return f"{self.user.username} - {self.post.__unicode__()}"
