from django.contrib.auth.views import LoginView, PasswordChangeView
from django.urls import path

from .forms import UserChangePasswordForm, UserLoginForm
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
            template_name="accounts/password_change_form.html", form_class=UserChangePasswordForm
        ),
        name="password_change",
    ),
    path(
        "password_change/done/",
        PasswordChangeView.as_view(
            template_name="accounts/password_change_done.html", form_class=UserChangePasswordForm
        ),
        name="password_change_done",
    ),
]
