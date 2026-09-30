<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Connect - Login</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {

            min-height: 100vh;

            font-family:
                "Segoe UI",
                Arial,
                sans-serif;

            background:
                linear-gradient(
                    135deg,
                    #17153a,
                    #302b63,
                    #5f4bb6
                );

            display: flex;

            justify-content: center;

            align-items: center;

            padding: 20px;

        }

        .login-wrapper {

            width: 900px;

            max-width: 100%;

            min-height: 560px;

            display: grid;

            grid-template-columns:
                1fr 1fr;

            background: rgba(
                255,
                255,
                255,
                0.96
            );

            border-radius: 28px;

            overflow: hidden;

            box-shadow:
                0 30px 80px
                rgba(0, 0, 0, 0.35);

        }

        /* LEFT */

        .brand-section {

            position: relative;

            padding: 55px;

            color: white;

            background:
                linear-gradient(
                    145deg,
                    #7161ef,
                    #4935a7
                );

            display: flex;

            flex-direction: column;

            justify-content: center;

        }

        .brand-section::before {

            content: "";

            position: absolute;

            width: 220px;

            height: 220px;

            border-radius: 50%;

            background:
                rgba(255,255,255,0.08);

            top: -70px;

            right: -70px;
        }

        .brand-icon {

            width: 65px;

            height: 65px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 20px;

            background:
                rgba(255,255,255,0.15);

            font-size: 32px;

            margin-bottom: 30px;
        }

        .brand-section h1 {

            font-size: 42px;

            line-height: 1.1;

            margin-bottom: 18px;

        }

        .brand-section p {

            font-size: 16px;

            line-height: 1.7;

            opacity: 0.85;

            max-width: 350px;

        }

        .features {

            margin-top: 35px;

        }

        .feature {

            display: flex;

            align-items: center;

            gap: 12px;

            margin: 15px 0;

            font-size: 14px;

        }

        .feature-icon {

            width: 30px;

            height: 30px;

            border-radius: 50%;

            background:
                rgba(255,255,255,0.16);

            display: flex;

            justify-content: center;

            align-items: center;

        }

        /* RIGHT */

        .login-section {

            padding: 55px;

            display: flex;

            flex-direction: column;

            justify-content: center;

        }

        .login-section h2 {

            color: #202033;

            font-size: 30px;

            margin-bottom: 8px;

        }

        .subtitle {

            color: #8b8b9d;

            margin-bottom: 32px;

            font-size: 14px;

        }

        .input-group {

            margin-bottom: 20px;

        }

        .input-group label {

            display: block;

            font-size: 13px;

            font-weight: 600;

            color: #45455a;

            margin-bottom: 8px;

        }

        .input-box {

            position: relative;

        }

        .input-box span {

            position: absolute;

            left: 15px;

            top: 50%;

            transform:
                translateY(-50%);

            font-size: 18px;

            color: #9292a6;

        }

        .input-box input {

            width: 100%;

            padding: 14px 15px 14px 45px;

            border: 1px solid #e3e3eb;

            border-radius: 12px;

            outline: none;

            font-size: 14px;

            background: #fafafe;

            transition: 0.2s;

        }

        .input-box input:focus {

            border-color: #6d5ce7;

            background: white;

            box-shadow:
                0 0 0 4px
                rgba(109,92,231,0.1);

        }

        .login-button {

            width: 100%;

            border: none;

            padding: 15px;

            border-radius: 12px;

            color: white;

            font-size: 15px;

            font-weight: 600;

            cursor: pointer;

            background:
                linear-gradient(
                    135deg,
                    #6d5ce7,
                    #4935a7
                );

            box-shadow:
                0 10px 20px
                rgba(91,73,190,0.25);

            transition: 0.2s;

        }

        .login-button:hover {

            transform: translateY(-2px);

            box-shadow:
                0 14px 25px
                rgba(91,73,190,0.3);

        }

        .error {

            color: #d93025;

            background: #fff0ef;

            padding: 11px;

            border-radius: 10px;

            margin-bottom: 18px;

            font-size: 13px;

        }

        .demo {

            text-align: center;

            color: #9999aa;

            font-size: 12px;

            margin-top: 22px;

        }

        @media(max-width: 700px) {

            .login-wrapper {

                grid-template-columns: 1fr;

            }

            .brand-section {

                display: none;
            }

            .login-section {

                padding: 35px 25px;
            }
        }

    </style>

</head>

<body>

<div class="login-wrapper">

    <div class="brand-section">

        <div class="brand-icon">
            💬
        </div>

        <h1>
            Talk.<br>
            Connect.<br>
            Share.
        </h1>

        <p>
            A simple and beautiful place
            to connect with people through
            instant messages.
        </p>

        <div class="features">

            <div class="feature">
                <div class="feature-icon">⚡</div>
                Instant messaging
            </div>

            <div class="feature">
                <div class="feature-icon">🔒</div>
                Private conversations
            </div>

            <div class="feature">
                <div class="feature-icon">🕒</div>
                Message history
            </div>

        </div>

    </div>


    <div class="login-section">

        <h2>
            Welcome back
        </h2>

        <div class="subtitle">
            Sign in to continue chatting
        </div>


        <%
            String error =
                request.getParameter("error");

            if (error != null) {
        %>

            <div class="error">
                <%= error %>
            </div>

        <%
            }
        %>


        <form
            action="login"
            method="post">

            <div class="input-group">

                <label>
                    Username
                </label>

                <div class="input-box">

                    <span>👤</span>

                    <input
                        type="text"
                        name="username"
                        placeholder="Enter your username"
                        autocomplete="username"
                        required>

                </div>

            </div>


            <div class="input-group">

                <label>
                    Password
                </label>

                <div class="input-box">

                    <span>🔒</span>

                    <input
                        type="password"
                        name="password"
                        placeholder="Enter your password"
                        autocomplete="current-password"
                        required>

                </div>

            </div>


            <button
                class="login-button"
                type="submit">

                Sign In →

            </button>

        </form>


        <div class="demo">
            Demo accounts: alice / 1234
            &nbsp; • &nbsp;
            bob / 1234
        </div>

    </div>

</div>

</body>

</html>