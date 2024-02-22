const chatId = parseInt(document.querySelector('#chatId').getAttribute("value"));

let chatMessageInput = document.querySelector("#chatMessageInput");
let chatMessageSend = document.querySelector("#chatMessageSend");
let chatMessages = document.querySelector("#chatMessages");
let noChatMessagesError = document.querySelector("#noChatMessagesError");

// focus 'chatMessageInput' when user opens the page
chatMessageInput.focus();

chatMessages.addMessage = function(sender, message, send_at) {
    let new_message = document.createElement("li");

    if (sender === chatMessages.getAttribute("username")) {
        sender = "You";
    }

    new_message.innerHTML = `
        <p>${message}</p>
        <p>Sender : ${sender}</p>
        <p>Send at : ${send_at}</p>
    `;

    chatMessages.appendChild(new_message);
}

chatMessages.show = function() {
    if (chatMessages.innerHTML !== "" && chatMessages.style.display === "none") {
        noChatMessagesError.style.display = "none";
        chatMessages.style.display = "block";
    }
}

// submit if the user presses the enter key
chatMessageInput.onkeyup = function(e) {
    if (e.keyCode === 13) {  // enter key
        chatMessageSend.click();
    }
};

// clear the 'chatMessageInput' and forward the message
chatMessageSend.onclick = function() {
    if (chatMessageInput.value.length === 0) return;
    chatSocket.send(JSON.stringify({
        "message": chatMessageInput.value,
    }));
    chatMessageInput.value = "";
};

let chatSocket = null;

function connect() {
    chatSocket = new WebSocket("ws://" + window.location.host + "/ws/chats/" + chatId + "/");

    chatSocket.onopen = function(e) {
        console.log("Successfully connected to the WebSocket.");
    }

    chatSocket.onclose = function(e) {
        console.log("WebSocket connection closed unexpectedly. Trying to reconnect in 2s...");
        setTimeout(function() {
            console.log("Reconnecting...");
            connect();
        }, 2000);
    };

    chatSocket.onmessage = function(e) {
        const data = JSON.parse(e.data);

        switch (data.type) {
            case "chat_message":
                chatMessages.addMessage(data.message.sender, data.message.message, data.message.send_at);
                chatMessages.show();
                break;
            case "chat_messages":
                data.messages.forEach(function(message) {
                    chatMessages.addMessage(message.sender, message.message, message.send_at);
                });
                chatMessages.show();
            default:
                console.error("Unknown message type !");
                break;
        }
    };

    chatSocket.onerror = function(err) {
        console.log("WebSocket encountered an error: " + err.message);
        console.log("Closing the socket.");
        chatSocket.close();
    }
}
connect();
