from django.contrib.auth.forms import UserCreationForm
from django.forms import DateField, EmailField

from .models import UserProfile


class SignupForm(UserCreationForm):
    email = EmailField(max_length=200, help_text="Required", required=True)
    birth_date = DateField(
        help_text="Required. Format: DD/MM/YYYY", required=True, input_formats=["%d/%m/%Y"], label="Birth date"
    )

    class Meta:
        model = UserProfile
        fields = ("username", "email", "password1", "password2", "birth_date")
