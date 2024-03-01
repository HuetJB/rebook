from django.contrib.auth.forms import (
    AuthenticationForm,
    PasswordChangeForm,
    PasswordResetForm,
    SetPasswordForm,
    UserCreationForm,
    UsernameField,
)
from django.forms import CharField, DateField, DateInput, EmailField, PasswordInput, TextInput

from .models import UserProfile


class UserLoginForm(AuthenticationForm):
    def __init__(self, *args, **kwargs):
        super(UserLoginForm, self).__init__(*args, **kwargs)

    username = UsernameField(widget=TextInput(attrs={"placeholder": "Username"}), label="", required=True)
    password = CharField(widget=PasswordInput(attrs={"placeholder": "Password"}), label="", required=True)


class UserPasswordChangeForm(PasswordChangeForm):
    def __init__(self, *args, **kwargs):
        super(UserPasswordChangeForm, self).__init__(*args, **kwargs)

    old_password = CharField(widget=PasswordInput(attrs={"placeholder": "Old Password"}), label="", required=True)
    new_password1 = CharField(widget=PasswordInput(attrs={"placeholder": "New Password"}), label="", required=True)
    new_password2 = CharField(
        widget=PasswordInput(attrs={"placeholder": "New Password Confirmation"}), label="", required=True
    )


class UserPasswordResetForm(PasswordResetForm):
    def __init__(self, *args, **kwargs):
        super(UserPasswordResetForm, self).__init__(*args, **kwargs)

    email = EmailField(widget=TextInput(attrs={"placeholder": "Email"}), label="", required=True)


class UserPasswordResetSetPasswordForm(SetPasswordForm):
    def __init__(self, *args, **kwargs):
        super(UserPasswordResetSetPasswordForm, self).__init__(*args, **kwargs)

    new_password1 = CharField(widget=PasswordInput(attrs={"placeholder": "New Password"}), label="", required=True)
    new_password2 = CharField(
        widget=PasswordInput(attrs={"placeholder": "New Password Confirmation"}), label="", required=True
    )


class SignupForm(UserCreationForm):
    username = UsernameField(widget=TextInput(attrs={"placeholder": "Username"}), label="", required=True)
    email = EmailField(max_length=200, widget=TextInput(attrs={"placeholder": "Email"}), label="", required=True)
    birth_date = DateField(widget=DateInput(attrs={"type": "date"}), label="Birth Date ", required=True)
    password1 = CharField(widget=PasswordInput(attrs={"placeholder": "Password"}), label="", required=True)
    password2 = CharField(widget=PasswordInput(attrs={"placeholder": "Password Confirmation"}), label="", required=True)

    class Meta:
        model = UserProfile
        fields = ("username", "email", "password1", "password2", "birth_date")
