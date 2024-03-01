from django.contrib.auth.views import (
    LoginView,
    PasswordChangeView,
    PasswordResetCompleteView,
    PasswordResetConfirmView,
    PasswordResetDoneView,
    PasswordResetView,
)
from django.urls import path

from .forms import UserLoginForm, UserPasswordChangeForm, UserPasswordResetForm, UserPasswordResetSetPasswordForm
from .views import ProfileView, SignUpView

urlpatterns = [
    path("signup/", SignUpView.as_view(), name="signup"),
    path("profile/", ProfileView.as_view(), name="profile"),
    path(
        "login/",
        LoginView.as_view(template_name="accounts/login.html", authentication_form=UserLoginForm),
        name="login",
    ),
    path(
        "password_change/",
        PasswordChangeView.as_view(
            template_name="accounts/password_change_form.html", form_class=UserPasswordChangeForm
        ),
        name="password_change",
    ),
    path(
        "password_change/done/",
        PasswordChangeView.as_view(
            template_name="accounts/password_change_done.html", form_class=UserPasswordChangeForm
        ),
        name="password_change_done",
    ),
    path(
        "password_reset/",
        PasswordResetView.as_view(template_name="accounts/password_reset_form.html", form_class=UserPasswordResetForm),
        name="password_reset",
    ),
    path(
        "password_reset/done/",
        PasswordResetDoneView.as_view(template_name="accounts/password_reset_done.html"),
        name="password_reset_done",
    ),
    path(
        "reset/<uidb64>/<token>/",
        PasswordResetConfirmView.as_view(
            template_name="accounts/password_reset_confirm.html", form_class=UserPasswordResetSetPasswordForm
        ),
        name="password_reset_confirm",
    ),
    path(
        "reset/done/",
        PasswordResetCompleteView.as_view(template_name="accounts/password_reset_complete.html"),
        name="password_reset_complete",
    ),
]
