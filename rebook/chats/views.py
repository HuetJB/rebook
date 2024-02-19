from accounts.models import UserProfile
from django.contrib.auth.decorators import login_required
from django.db.models.manager import BaseManager
from django.http import HttpResponseRedirect
from django.shortcuts import get_object_or_404, redirect
from django.urls import reverse
from django.utils.decorators import method_decorator
from django.views.generic import DetailView, ListView
from posts.models import Post

from .models import Chat


@method_decorator(login_required, name="dispatch")
class ChatsListView(ListView):
    model = Chat
    template_name = "chats/chats.html"
    context_object_name = "chats"
    paginate_by = 10

    def get_queryset(self):
        return get_chats(user=self.request.user)


@method_decorator(login_required, name="dispatch")
class ChatDetailView(DetailView):
    model = Chat
    template_name = "chats/chat.html"


def get_chats(user: UserProfile) -> BaseManager[Chat]:
    return (Chat.objects.filter(purchaser=user) | Chat.objects.filter(post__seller=user)).order_by("-created_at")


@login_required
def create_chat_from_post(request, post_id):
    post = get_object_or_404(Post, pk=post_id)

    if post.seller == request.user or get_chats(request.user).filter(post=post).exists():
        return HttpResponseRedirect(reverse("post_detail", kwargs={"pk": post_id}))

    chat = Chat.objects.create(post=post, purchaser=request.user)

    return redirect("chat_detail", pk=chat.pk)
