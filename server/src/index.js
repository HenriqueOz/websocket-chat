import express from "express";
import http from "http";
import { Socket } from "./web_socket/ws.js";
import cors from "cors";
import router from "./routes/routes.js";
import { env } from "process";

const HOST_NAME = env.HOST;
const PORT = env.PORT;

const corsOptions = {
  origin: `http://${HOST_NAME}:${PORT}`,
  methods: ["GET", "POST"],
};

const app = express();

app.use(cors(corsOptions));
app.use((req, res, next) => {
  const begin = Date.now();

  const duration = Date.now() - begin;
  console.log(
    `[${new Date().toISOString()}] ${req.method} ${req.originalUrl} ${
      res.statusCode
    } - ${duration}ms`
  );

  next();
});
app.use("/", router);

const server = http.createServer();
Socket.init(server);

server.listen(PORT, HOST_NAME, () => {
  console.log(`server running at http://${HOST_NAME}:${PORT}`);
});
