from django.contrib.auth.views import LoginView
from django.urls import path

from .forms import UserLoginForm
from .views import ProfileView, SignUpView

urlpatterns = [
    path("signup/", SignUpView.as_view(), name="signup"),
    path("profile/", ProfileView.as_view(), name="profile"),
    path(
        "login/",
        LoginView.as_view(template_name="accounts/login.html", authentication_form=UserLoginForm),
        name="login",
    ),
]
