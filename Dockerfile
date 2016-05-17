FROM node

RUN  git clone https://github.com/tensorflow/playground
RUN  cd /playground/

WORKDIR /playground/

RUN  npm install 


EXPOSE  8080


CMD npm run serve
