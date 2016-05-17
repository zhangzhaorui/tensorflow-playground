FROM nodejs

RUN git clone https://github.com/tensorflow/playground
RUN npm install 
RUN npm run serve 

EXPOSE  8080
