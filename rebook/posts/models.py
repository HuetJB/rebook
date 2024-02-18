from accounts.models import UserProfile
from books.models import Book
from django.db.models import CASCADE, CharField, DateTimeField, FloatField, ForeignKey, ImageField, Model

from rebook.settings import IMAGES_FOLDER


class Post(Model):
    title = CharField(max_length=100)
    description = CharField(max_length=1000)
    created_at = DateTimeField(auto_now_add=True)
    price = FloatField()
    seller = ForeignKey(UserProfile, on_delete=CASCADE)
    book = ForeignKey(Book, on_delete=CASCADE)
    image_1 = ImageField(upload_to=IMAGES_FOLDER, blank=True, null=True)
    image_2 = ImageField(upload_to=IMAGES_FOLDER, blank=True, null=True)
    image_3 = ImageField(upload_to=IMAGES_FOLDER, blank=True, null=True)

    def __unicode__(self):
        return self.title
