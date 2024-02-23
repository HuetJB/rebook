from django.forms import (
    CharField,
    DateField,
    DateInput,
    FileInput,
    ImageField,
    IntegerField,
    ModelForm,
    NumberInput,
    Textarea,
    TextInput,
)

from .models import Post


class CreatePostForm(ModelForm):
    _validates_images_mimetypes = "image/png,image/jpeg"

    title = CharField(max_length=100, widget=TextInput(attrs={"placeholder": "Title"}), required=True, label="")
    description = CharField(
        max_length=1000, required=True, widget=Textarea(attrs={"placeholder": "Description"}), label=""
    )
    price = IntegerField(min_value=0, widget=NumberInput(attrs={"placeholder": "Price"}), required=True, label="")
    book_title = CharField(
        max_length=100, widget=TextInput(attrs={"placeholder": "Book Title"}), required=True, label=""
    )
    book_author = CharField(
        max_length=100, widget=TextInput(attrs={"placeholder": "Book Author"}), required=True, label=""
    )
    book_published_at = DateField(widget=DateInput(attrs={"type": "date"}), required=True, label="Published At ")
    image_1 = ImageField(
        required=True, label="First Image ", widget=FileInput(attrs={"accept": _validates_images_mimetypes})
    )
    image_2 = ImageField(
        required=False, label="Second Image ", widget=FileInput(attrs={"accept": _validates_images_mimetypes})
    )
    image_3 = ImageField(
        required=False, label="Third Image ", widget=FileInput(attrs={"accept": _validates_images_mimetypes})
    )

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
