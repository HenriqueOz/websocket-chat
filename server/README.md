# Websocket Server

Chat websocket server build with node js

To run the project use these docker command inside the project root directory

> **You must've docker desktop installed**

```
git clone https://github.com/Peguinm/websocket-chat-server.git
docker build -t websocket-server .
docker run --rm -p <port>:3000 --name websocket-server-container websocket-server
```

Chat client app in flutter: https://github.com/Peguinm/websocket-chat-app

Chat client terminal: https://github.com/Peguinm/websocket-chat-client
