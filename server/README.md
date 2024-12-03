# Websocket Server

Chat websocket server build with node js

To run the project use these docker command inside the project root directory

<br>

> **Run the server**

Clone the project

```
git clone https://github.com/Peguinm/websocket-chat-server.git
```

Run inside the project folder

```
docker build -t websocket-server .
docker run --rm -p <port>:3000 --name websocket-server-container websocket-server

```

<br>

> **optional for logging**

Run inside project folder

```
docker logs -f websocket-server-container 1> logs/logs.log &
docker logs -f websocket-server-container 2> logs/error.log &

```

<br>

Chat client app in flutter: https://github.com/Peguinm/websocket-chat-app

Chat client terminal: https://github.com/Peguinm/websocket-chat-client
