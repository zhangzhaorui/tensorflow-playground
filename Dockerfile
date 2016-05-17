FROM node

RUN  git clone https://github.com/tensorflow/playground
RUN  cd playground/
RUN  npm install 
RUN  npm run server 

EXPOSE  8080
