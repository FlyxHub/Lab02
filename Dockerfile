FROM node:latest
EXPOSE 9000
WORKDIR /home/node/app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["node", "index.js"]
