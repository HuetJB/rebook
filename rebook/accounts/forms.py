from datetime import date

from django.contrib.auth.forms import UserCreationForm
from django.forms import DateField, EmailField, SelectDateWidget

from .models import UserProfile


class SignupForm(UserCreationForm):
    email = EmailField(max_length=200, help_text="Required", required=True)
    birth_date = DateField(
        required=True, label="Birth Date", widget=SelectDateWidget(years=range(1900, date.today().year + 1))
    )

    class Meta:
        model = UserProfile
        fields = ("username", "email", "password1", "password2", "birth_date")
