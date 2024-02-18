# Generated by Django 5.0.2 on 2024-02-18 18:33

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("posts", "0002_alter_post_favourite"),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.RemoveField(
            model_name="post",
            name="favourite",
        ),
        migrations.AddField(
            model_name="post",
            name="have_in_favourite",
            field=models.ManyToManyField(blank=True, related_name="posts_in_favourite", to=settings.AUTH_USER_MODEL),
        ),
    ]
