from django.contrib import admin

from .models import Favorite, Post

admin.site.register(Favorite)
admin.site.register(Post)
