# Generated by Django 5.0.2 on 2024-02-18 12:07

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies: list = []

    operations = [
        migrations.CreateModel(
            name="Book",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("title", models.CharField(max_length=100)),
                ("description", models.CharField(max_length=1000)),
                ("author", models.CharField(max_length=100)),
                ("publication_date", models.DateField()),
                ("created_at", models.DateField(auto_now_add=True)),
                ("pages", models.IntegerField()),
                ("price", models.FloatField()),
                ("images", models.ImageField(blank=True, null=True, upload_to="images/")),
            ],
        ),
    ]
