FROM node.js

RUN git clone https://github.com/tensorflow/playground
RUN npm install node.js
RUN npm run server node.js

EXPOSE  8080
