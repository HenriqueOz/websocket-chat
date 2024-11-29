import { Server } from "socket.io";
import { MessageModel } from "../models/message_model.js";
import { UserModel } from "../models/user_model.js";
import { MessageType } from "../models/message_type.js";

export class Socket {
  static inst = null;
  users = new Map();

  constructor(server) {
    this.socket = new Server(server);
    this.events();
  }

  static init(server) {
    if (this.inst === null) {
      this.inst = new Socket(server);
    }
    return this.inst;
  }

  events() {
    this.socket.on("connection", (client) => {
      console.log("new connection id: ", client.id);

      client.on("connection-message", (data) => {
        const name = JSON.parse(data)["name"];
        this.users.set(client.id, new UserModel({ name: name }));

        this.broadcastMessage({ body: `${name} joined` });
      });

      client.on("message", (data) => {
        const message = MessageModel.fromJson({ json: data });

        console.log(
          `message from: ${message.author}, connection_id: ${client.id}`
        );

        message.messageType = MessageType.member;

        this.socket.except(client.id).emit("message", JSON.stringify(message));
      });

      client.on("disconnect", () => {
        const user = this.users.get(client.id);

        console.log(`connection close id: ${client.id}`);

        if (user != undefined) {
          this.broadcastMessage({
            body: `${user.name} left`,
          });
          this.users.delete(client.id);
        }
      });
    });
  }

  sendConnectionMessage({ exceptions = [], connectionId }) {
    this.socket
      .except(exceptions)
      .to(connectionId)
      .emit(
        "connection-message",
        JSON.stringify({
          connectionId: connectionId,
        })
      );
  }

  broadcastMessage({ body }) {
    this.socket.emit(
      "message",
      JSON.stringify(
        new MessageModel({
          author: "System",
          body: body,
          date: new Date().toISOString(),
          messageType: MessageType.system,
        })
      )
    );
  }
}
