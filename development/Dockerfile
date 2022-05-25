FROM node:10

WORKDIR /usr/src

COPY package*.json ./

RUN npm install

EXPOSE 3200

CMD ["npm", "run", "dev"]
