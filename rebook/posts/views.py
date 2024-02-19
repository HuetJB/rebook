from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect
from django.shortcuts import get_object_or_404
from django.urls import reverse, reverse_lazy
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
        return Post.objects.order_by("-created_at")


class PostView(DetailView):
    model = Post
    template_name = "posts/post.html"


@method_decorator(login_required, name="dispatch")
class PersonnalsPostsView(ListView):
    model = Post
    template_name = "posts/personnals_posts.html"
    context_object_name = "posts"
    paginate_by = 10

    def get_queryset(self):
        return Post.objects.filter(seller=self.request.user).order_by("-created_at")


@method_decorator(login_required, name="dispatch")
class FavouritesPostsView(ListView):
    model = Post
    template_name = "posts/favourites_posts.html"
    context_object_name = "posts"
    paginate_by = 10

    def get_queryset(self):
        return self.request.user.posts_in_favourite.order_by("-created_at")


@method_decorator(login_required, name="dispatch")
class CreatePostView(CreateView):
    form_class = CreatePostForm
    success_url = reverse_lazy("home")
    template_name = "posts/create_post.html"

    def form_valid(self, form):
        form.instance.seller = self.request.user
        return super().form_valid(form)


@login_required
def favourite_a_post(request, post_id):
    post = get_object_or_404(Post, id=post_id)

    if post.have_in_favourite.filter(id=request.user.id).exists():
        post.have_in_favourite.remove(request.user)
    else:
        post.have_in_favourite.add(request.user)

    return HttpResponseRedirect(reverse("post_detail", kwargs={"pk": id}))
