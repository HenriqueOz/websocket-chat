# Websocket Server

Chat websocket server build with node js

To run the project use these docker command inside the project root directory

> **You must've docker desktop installed**

```
docker build -t websocket-server .
docker run -d -p <host>:<port>:3000 websocket-server
docker run --rm -p 10.24.24.169:3000:3000 websocket-server
```

Chat client app in flutter: https://github.com/Peguinm/websocket-chat-app

Chat client terminal: https://github.com/Peguinm/websocket-chat-client
