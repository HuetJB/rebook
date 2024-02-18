from django.forms import CharField, DateField, ImageField, IntegerField, ModelForm, SelectDateWidget, Textarea

from .models import Post


class CreatePostForm(ModelForm):
    title = CharField(max_length=100, required=True)
    description = CharField(max_length=1000, required=True, widget=Textarea(attrs={"rows": 1, "cols": 100}))
    price = IntegerField(required=True)
    book_title = CharField(max_length=100, required=True)
    book_author = CharField(max_length=100, required=True)
    book_published_at = DateField(required=True, label="Published at", widget=SelectDateWidget)
    image_1 = ImageField(required=True)
    image_2 = ImageField(required=False)
    image_3 = ImageField(required=False)

    class Meta:
        model = Post
        fields = (
            "title",
            "description",
            "price",
            "book_title",
            "book_author",
            "book_published_at",
            "image_1",
            "image_2",
            "image_3",
        )
