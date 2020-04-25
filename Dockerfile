FROM node:12.14.0-alpine

WORKDIR /app
ADD app /app

CMD node index.js
