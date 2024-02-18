from django.views.generic import DetailView, ListView

from .models import Post


class HomeView(ListView):
    model = Post
    template_name = "home.html"
    context_object_name = "posts"
    paginate_by = 10

    def get_queryset(self):
        return Post.objects.order_by("created_at")


class PostView(DetailView):
    model = Post
    template_name = "posts/post.html"
