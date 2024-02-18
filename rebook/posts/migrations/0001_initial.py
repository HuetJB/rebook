# Generated by Django 5.0.2 on 2024-02-18 14:57

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name="Book",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("title", models.CharField(max_length=100)),
                ("description", models.CharField(max_length=1000)),
                ("author", models.CharField(max_length=100)),
                ("published_at", models.DateField()),
                ("pages", models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name="Post",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("title", models.CharField(max_length=100)),
                ("description", models.CharField(max_length=1000)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
                ("price", models.FloatField()),
                ("image_1", models.ImageField(blank=True, null=True, upload_to="static/images")),
                ("image_2", models.ImageField(blank=True, null=True, upload_to="static/images")),
                ("image_3", models.ImageField(blank=True, null=True, upload_to="static/images")),
                ("book", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to="posts.book")),
                ("seller", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
