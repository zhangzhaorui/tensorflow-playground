FROM registry.dataos.io/library/node:hehl

RUN  git clone https://github.com/tensorflow/playground
RUN  cd /playground/
#RUN echo "registry=https://registry.npm.taobao.org" > ~/.npmrc
RUN echo "registry=http://registry.cnpmjs.org" > ~/.npmrc
WORKDIR /playground/

RUN  npm install 


EXPOSE  8080


CMD npm run serve
