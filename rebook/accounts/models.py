from django.contrib.auth.models import AbstractUser
from django.db.models import DateField


class UserProfile(AbstractUser):
    birth_date = DateField(null=True, blank=True)

    def __str__(self):
        return self.username

    def get_birth_date(self) -> str:
        if self.birth_date:
            return self.birth_date.strftime("%Y-%m-%d")
        return ""
