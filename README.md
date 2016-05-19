# playground 
#FROM node                                                      *基于node.js写的，所以要from一个node的基础镜像
#RUN  git clone https://github.com/tensorflow/playground        *用git clone 拖下要部署程序的代码包
#RUN  cd /playground/                                           *拖下程序的代码包后进入playground这个目录
#WORKDIR /playground/                                           *把工作目录指向playground，也就是接下来运行的所有命令都会在这个目录下执行
#RUN  npm install                                               *用npm命令执行安装  
#EXPOSE  8080                                                   *需要8080端口，所以把8080端口做出来   
#CMD npm run serve                                              *用npm命令启动服务，就可以了 

#部署playground
1.首先我们去将github上的代码build下来

[songzx@openshift-container-deploy2 ~]$ oc new-build https://github.com/asiainfoLDP/szx-playground.git


--> Found Docker image 716fd33 (26 hours old) from Docker Hub for "node"

    * An image stream will be created as "node:latest" that will track the source image
    * A Docker build using source code from https://github.com/asiainfoLDP/szx-playground.git will be created
      * The resulting image will be pushed to image stream "szx-playground:latest"
      * Every time "node:latest" changes a new build will be triggered

--> Creating resources with label build=szx-playground ...
    imagestream "node" created
    imagestream "szx-playground" created
    buildconfig "szx-playground" created
--> Success
    Build configuration "szx-playground" created and build triggered.
    Run 'oc logs -f bc/szx-playground' to stream the build progress.


2.查看一下我们代码build成功与否

[songzx@openshift-container-deploy2 ~]$ oc get po

NAME                     READY     STATUS      RESTARTS   AGE

szx-playground-1-build   0/1       Completed   0          4m

可以看到我们的代码build完成

3.build完成后我们使用命令把服务run起来

[songzx@openshift-container-deploy2 ~]$ oc get is

NAME             DOCKER REPO                                TAGS      UPDATED
node             172.30.188.59:5000/songzx/node             latest    5 minutes ago
szx-playground   172.30.188.59:5000/songzx/szx-playground   latest    About a minute ago
[songzx@openshift-container-deploy2 ~]$ oc run playground --image=172.30.188.59:5000/songzx/szx-playground

deploymentconfig "playground" created


首先我们先查看build好的镜像，然后使用oc run命令去运行这个镜像，等待镜像跑起来


4.查看镜像run的情况

[songzx@openshift-container-deploy2 ~]$ oc get po

NAME                     READY     STATUS      RESTARTS   AGE
playground-1-4bubz       1/1       Running     0          1m
szx-playground-1-build   0/1       Completed   0          7m


我们可以看到镜像已经run起来了，现在我们还剩最后一点工作，就可以正常访问了。


5.我们去查看现在所有的dc，然后把这个dc生成一个svc，并且指定80端口

[songzx@openshift-container-deploy2 ~]$ oc get dc

NAME         REVISION   REPLICAS   TRIGGERED BY

playground    1          1          config

[songzx@openshift-container-deploy2 ~]$ oc expose dc playground --port=80

service "playground" exposed

6.我们把生成的svc再生成一个route，就可以去进行外网访问了

[songzx@openshift-container-deploy2 ~]$ oc get svc

NAME         CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE

playground   172.30.204.201   <none>        80/TCP    1m

[songzx@openshift-container-deploy2 ~]$ oc expose svc playground

route "playground" exposed

我们可以看到route已经生成

7.最后一步，通过查看每个服务对应的route，去进行外网访问。

[songzx@openshift-container-deploy2 ~]$ oc get route

NAME         HOST/PORT                         PATH      SERVICE      TERMINATION   LABELS

playground   playground-songzx.app.dataos.io             playground                 run=playground

8.访问上图中的域名，即可访问我们搭建的这个服务。
