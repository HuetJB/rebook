from accounts.models import UserProfile
from django.contrib.auth.decorators import login_required
from django.db.models.manager import BaseManager
from django.shortcuts import get_object_or_404, redirect
from django.utils.decorators import method_decorator
from django.views.generic import DetailView, ListView
from posts.models import Post

from .models import Chat, Message


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

    if post.seller != request.user and get_chats(request.user).filter(post=post).exists():
        return redirect("post_detail", pk=post_id)

    chat = Chat.objects.create(post=post, purchaser=request.user)

    return redirect("chat_detail", pk=chat.pk)


@login_required
def delete_chat(request, chat_id):
    chat = get_object_or_404(Chat, pk=chat_id)
    chat.delete()
    return redirect("personals_chats")


# @login_required
# def get_chat_messages(request, chat_id):
#     chat = get_object_or_404(Chat, pk=chat_id)
#     messages: BaseManager[Message] = chat.messages
#     return JsonResponse({"messages": list(messages.values())})


@login_required
def send_message(request, chat_id):
    chat = get_object_or_404(Chat, pk=chat_id)

    Message.objects.create(chat=chat, sender=request.user, message=request.POST["message"])

    return redirect("chat_detail", pk=chat_id)
