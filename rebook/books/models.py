from django.db.models import CharField, DateField, IntegerField, Model


class Book(Model):
    title = CharField(max_length=100)
    description = CharField(max_length=1000)
    author = CharField(max_length=100)
    publication_date = DateField()
    pages = IntegerField()

    def __unicode__(self):
        return self.title
