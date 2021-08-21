FROM node:10.23.2

WORKDIR /usr/src

COPY package*.json ./

RUN npm install

EXPOSE 3200

CMD ["npm", "run", "dev"]
