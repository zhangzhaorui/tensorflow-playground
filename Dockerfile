FROM node

RUN  git clone https://github.com/tensorflow/playground
RUN  cd /playground/
RUN  npm install 


EXPOSE  8080


CMD npm run server
