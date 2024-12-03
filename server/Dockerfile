FROM node:lts-alpine
WORKDIR /app

COPY . .

RUN npm install
CMD [ "node", "--env-file=.env", "src/index.js"]