FROM nodejs

RUN sudo yum -y install npm
RUN sudo git clone https://github.com/tensorflow/playground
RUN sudo npm install 
RUN sudo npm run serve 

EXPOSE  8080
