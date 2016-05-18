# playground 
#FROM node                                                      *基于node.js写的，所以要from一个node的基础镜像
#RUN  git clone https://github.com/tensorflow/playground        *用git clone 拖下要部署程序的代码包
#RUN  cd /playground/                                           *拖下程序的代码包后进入playground这个目录
#WORKDIR /playground/                                           *把工作目录指向playground，也就是接下来运行的所有命令都会在这个目录下执行
#RUN  npm install                                               *用npm命令执行安装  
#EXPOSE  8080                                                   *需要8080端口，所以把8080端口做出来   
#CMD npm run serve                                              *用npm命令启动服务，就可以了
