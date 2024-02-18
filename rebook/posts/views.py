from django.contrib.auth.decorators import login_required
from django.urls import reverse_lazy
from django.utils.decorators import method_decorator
from django.views.generic import CreateView, DetailView, ListView

from .forms import CreatePostForm
from .models import Post


class HomeView(ListView):
    model = Post
    template_name = "home.html"
    context_object_name = "posts"
    paginate_by = 10

    def get_queryset(self):
        return Post.objects.order_by("created_at")


class FavoritesPostView(ListView):
    model = Post
    template_name = "posts/favorites.html"
    context_object_name = "posts"
    paginate_by = 10

    def get_queryset(self):
        return Post.objects.order_by("created_at")


class PostView(DetailView):
    model = Post
    template_name = "posts/post.html"


@method_decorator(login_required, name="dispatch")
class CreatePostView(CreateView):
    form_class = CreatePostForm
    success_url = reverse_lazy("home")
    template_name = "posts/create_post.html"

    def form_valid(self, form):
        form.instance.seller = self.request.user
        return super().form_valid(form)
