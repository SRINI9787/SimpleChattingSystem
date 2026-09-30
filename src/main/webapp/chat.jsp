<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String username =
        (String) session.getAttribute("username");

    if (username == null) {

        response.sendRedirect("login.jsp");

        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width,
                 initial-scale=1.0">

    <title>Connect - Chat</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {

            height: 100vh;

            font-family:
                "Segoe UI",
                Arial,
                sans-serif;

            background:
                #f3f4f8;

            display: flex;

            align-items: center;

            justify-content: center;

        }

        .app {

            width: 1100px;

            height: 720px;

            max-width: 96%;

            max-height: 94vh;

            background: white;

            border-radius: 24px;

            overflow: hidden;

            display: grid;

            grid-template-columns:
                280px 1fr;

            box-shadow:
                0 25px 70px
                rgba(30,30,60,0.14);

        }

        /* SIDEBAR */

        .sidebar {

            background:
                linear-gradient(
                    160deg,
                    #211b50,
                    #40318d
                );

            color: white;

            padding: 25px;

            display: flex;

            flex-direction: column;

        }

        .logo {

            display: flex;

            align-items: center;

            gap: 12px;

            font-weight: 700;

            font-size: 20px;

            margin-bottom: 40px;

        }

        .logo-icon {

            width: 40px;

            height: 40px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 12px;

            background:
                rgba(255,255,255,0.13);

        }

        .profile {

            padding: 18px;

            border-radius: 16px;

            background:
                rgba(255,255,255,0.1);

            margin-bottom: 30px;

        }

        .avatar {

            width: 52px;

            height: 52px;

            border-radius: 50%;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 20px;

            font-weight: 700;

            background:
                linear-gradient(
                    135deg,
                    #9b8cff,
                    #6c5ce7
                );

            margin-bottom: 12px;

        }

        .profile-name {

            font-weight: 600;

            margin-bottom: 5px;

        }

        .online {

            font-size: 12px;

            color: #9ff0ba;

        }

        .online::before {

            content: "●";

            margin-right: 6px;

        }

        .section-title {

            font-size: 11px;

            text-transform: uppercase;

            letter-spacing: 1px;

            color:
                rgba(255,255,255,0.5);

            margin-bottom: 12px;

        }

        .receiver-box {

            background:
                rgba(255,255,255,0.08);

            border-radius: 12px;

            padding: 12px;

        }

        .receiver-box input {

            width: 100%;

            border: none;

            outline: none;

            background: transparent;

            color: white;

            font-size: 14px;

        }

        .receiver-box input::placeholder {

            color:
                rgba(255,255,255,0.5);

        }

        .hint {

            font-size: 11px;

            line-height: 1.5;

            color:
                rgba(255,255,255,0.5);

            margin-top: 12px;

        }

        .sidebar-bottom {

            margin-top: auto;

            font-size: 11px;

            color:
                rgba(255,255,255,0.45);

        }

        /* CHAT */

        .chat-area {

            display: flex;

            flex-direction: column;

            min-width: 0;

        }

        .chat-header {

            height: 80px;

            padding: 0 28px;

            border-bottom:
                1px solid #eeeeF3;

            display: flex;

            align-items: center;

            justify-content: space-between;

        }

        .contact {

            display: flex;

            align-items: center;

            gap: 13px;

        }

        .contact-avatar {

            width: 45px;

            height: 45px;

            border-radius: 50%;

            display: flex;

            align-items: center;

            justify-content: center;

            color: white;

            font-weight: 700;

            background:
                linear-gradient(
                    135deg,
                    #6d5ce7,
                    #8b7cf5
                );

        }

        .contact-name {

            font-weight: 700;

            color: #242436;

        }

        .contact-status {

            font-size: 11px;

            color: #9a9aab;

            margin-top: 3px;

        }

        .chat-content {

            flex: 1;

            overflow-y: auto;

            padding: 28px;

            background:
                #fafafd;

        }

        .empty {

            height: 100%;

            display: flex;

            flex-direction: column;

            align-items: center;

            justify-content: center;

            color: #a4a4b5;

            text-align: center;

        }

        .empty-icon {

            width: 70px;

            height: 70px;

            border-radius: 22px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #eeecff;

            font-size: 30px;

            margin-bottom: 15px;

        }

        .empty strong {

            color: #555568;

            margin-bottom: 5px;

        }

        .message-row {

            display: flex;

            margin-bottom: 15px;

        }

        .message-row.mine {

            justify-content: flex-end;

        }

        .bubble {

            max-width: 65%;

            padding: 12px 15px;

            border-radius: 17px;

            background: white;

            color: #383849;

            box-shadow:
                0 3px 12px
                rgba(40,40,70,0.05);

        }

        .mine .bubble {

            color: white;

            background:
                linear-gradient(
                    135deg,
                    #6d5ce7,
                    #5744c5
                );

            border-bottom-right-radius: 5px;

        }

        .message-row:not(.mine)
        .bubble {

            border-bottom-left-radius: 5px;

        }

        .sender {

            font-size: 10px;

            font-weight: 700;

            margin-bottom: 5px;

            color: #7567dc;

        }

        .mine .sender {

            color:
                rgba(255,255,255,0.75);

        }

        .message-text {

            font-size: 14px;

            line-height: 1.5;

            white-space: pre-wrap;

            overflow-wrap: anywhere;

        }

        .time {

            font-size: 9px;

            margin-top: 6px;

            opacity: 0.55;

            text-align: right;

        }

        /* SEND */

        .composer {

            padding: 18px 25px;

            border-top:
                1px solid #eeeeF3;

            background: white;

        }

        .composer-box {

            display: flex;

            align-items: center;

            gap: 10px;

            padding: 7px;

            background: #f5f5fa;

            border-radius: 15px;

        }

        .composer-box input {

            flex: 1;

            border: none;

            outline: none;

            background: transparent;

            padding: 11px;

            font-size: 14px;

            color: #333;

        }

        .send-button {

            width: 44px;

            height: 44px;

            border: none;

            border-radius: 12px;

            color: white;

            background:
                linear-gradient(
                    135deg,
                    #6d5ce7,
                    #5140b8
                );

            cursor: pointer;

            font-size: 18px;

            transition: 0.2s;

        }

        .send-button:hover {

            transform:
                translateY(-2px);

        }

        @media(max-width: 750px) {

            .app {

                grid-template-columns: 1fr;

                height: 94vh;

            }

            .sidebar {

                display: none;

            }

            .bubble {

                max-width: 80%;

            }

        }

    </style>

</head>

<body>

<div class="app">

    <!-- SIDEBAR -->

    <aside class="sidebar">

        <div class="logo">

            <div class="logo-icon">
                💬
            </div>

            Connect

        </div>


        <div class="profile">

            <div class="avatar">

                <%= username
                    .substring(0, 1)
                    .toUpperCase() %>

            </div>

            <div class="profile-name">
                <%= username %>
            </div>

            <div class="online">
                Online
            </div>

        </div>


        <div class="section-title">
            Chat with
        </div>


        <div class="receiver-box">

            <input
                id="receiver"
                type="text"
                placeholder="Username..."
                autocomplete="off">

        </div>


        <div class="hint">

            Enter another registered username
            to start a conversation.

            <br><br>

            Try:

            <b>alice</b>,
            <b>bob</b> or
            <b>john</b>

        </div>


        <div class="sidebar-bottom">

            Simple Chatting System<br>
            JSP • Servlet • AJAX • JDBC

        </div>

    </aside>


    <!-- CHAT -->

    <main class="chat-area">


        <header class="chat-header">

            <div class="contact">

                <div
                    class="contact-avatar"
                    id="contactAvatar">

                    ?

                </div>

                <div>

                    <div
                        class="contact-name"
                        id="contactName">

                        Select a user

                    </div>

                    <div
                        class="contact-status"
                        id="contactStatus">

                        Choose someone to chat with

                    </div>

                </div>

            </div>

        </header>


        <div
            class="chat-content"
            id="chatBox">

            <div class="empty">

                <div class="empty-icon">
                    💬
                </div>

                <strong>
                    Start a conversation
                </strong>

                <span>
                    Enter a username on the left.
                </span>

            </div>

        </div>


        <div class="composer">

            <div class="composer-box">

                <input
                    id="message"
                    type="text"
                    placeholder="Write a message..."
                    autocomplete="off">

                <button
                    class="send-button"
                    onclick="sendMessage()">

                    ➤

                </button>

            </div>

        </div>

    </main>

</div>


<script>

    const currentUser =
        "<%= username %>";


    const receiverInput =
        document.getElementById(
            "receiver"
        );


    const messageInput =
        document.getElementById(
            "message"
        );


    const chatBox =
        document.getElementById(
            "chatBox"
        );


    function updateContact() {

        const receiver =
            receiverInput.value.trim();

        const contactName =
            document.getElementById(
                "contactName"
            );

        const contactStatus =
            document.getElementById(
                "contactStatus"
            );

        const contactAvatar =
            document.getElementById(
                "contactAvatar"
            );


        if (receiver === "") {

            contactName.textContent =
                "Select a user";

            contactStatus.textContent =
                "Choose someone to chat with";

            contactAvatar.textContent =
                "?";

            return;
        }


        contactName.textContent =
            receiver;

        contactStatus.textContent =
            "Conversation";

        contactAvatar.textContent =
            receiver
                .substring(0, 1)
                .toUpperCase();
    }


    function showEmpty() {

        chatBox.innerHTML = `

            <div class="empty">

                <div class="empty-icon">
                    💬
                </div>

                <strong>
                    No messages yet
                </strong>

                <span>
                    Say hello and start chatting.
                </span>

            </div>

        `;
    }


    function loadMessages() {

        const receiver =
            receiverInput.value.trim();


        if (receiver === "") {

            return;
        }


        fetch(
            "chat?receiver=" +
            encodeURIComponent(receiver)
        )

        .then(response => {

            return response.json();

        })

        .then(messages => {

            chatBox.innerHTML = "";


            if (messages.length === 0) {

                showEmpty();

                return;
            }


            messages.forEach(
                function(msg) {

                    const row =
                        document.createElement(
                            "div"
                        );


                    row.className =
                        "message-row";


                    if (
                        msg.sender ===
                        currentUser
                    ) {

                        row.classList.add(
                            "mine"
                        );
                    }


                    const bubble =
                        document.createElement(
                            "div"
                        );


                    bubble.className =
                        "bubble";


                    const sender =
                        document.createElement(
                            "div"
                        );

                    sender.className =
                        "sender";

                    sender.textContent =
                        msg.sender;


                    const text =
                        document.createElement(
                            "div"
                        );

                    text.className =
                        "message-text";

                    text.textContent =
                        msg.message;


                    const time =
                        document.createElement(
                            "div"
                        );

                    time.className =
                        "time";

                    time.textContent =
                        msg.time;


                    bubble.appendChild(
                        sender
                    );

                    bubble.appendChild(
                        text
                    );

                    bubble.appendChild(
                        time
                    );

                    row.appendChild(
                        bubble
                    );

                    chatBox.appendChild(
                        row
                    );
                }
            );


            chatBox.scrollTop =
                chatBox.scrollHeight;

        })

        .catch(error => {

            console.error(
                "Message loading error:",
                error
            );

        });
    }


    function sendMessage() {

        const receiver =
            receiverInput.value.trim();

        const message =
            messageInput.value.trim();


        if (receiver === "") {

            alert(
                "Enter a username first."
            );

            receiverInput.focus();

            return;
        }


        if (message === "") {

            messageInput.focus();

            return;
        }


        const data =
            new URLSearchParams();


        data.append(
            "receiver",
            receiver
        );

        data.append(
            "message",
            message
        );


        fetch("chat", {

            method: "POST",

            headers: {

                "Content-Type":
                    "application/x-www-form-urlencoded"

            },

            body:
                data.toString()

        })

        .then(response =>
            response.text()
        )

        .then(result => {

            if (result === "success") {

                messageInput.value = "";

                loadMessages();

                messageInput.focus();

            } else {

                alert(result);

            }

        })

        .catch(error => {

            console.error(
                "Send error:",
                error
            );

            alert(
                "Unable to send message."
            );
        });
    }


    receiverInput.addEventListener(
        "input",
        function() {

            updateContact();

            loadMessages();

        }
    );


    messageInput.addEventListener(
        "keydown",
        function(event) {

            if (event.key === "Enter") {

                event.preventDefault();

                sendMessage();

            }

        }
    );


    setInterval(
        function() {

            if (
                receiverInput.value.trim()
                !== ""
            ) {

                loadMessages();

            }

        },
        2000
    );

</script>

</body>

</html>