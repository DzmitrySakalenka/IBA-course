1.1 Getting started
	Start 3 containers from image that does not automatically exit, such as nginx, detached.
	Stop 2 of the containers leaving 1 up.
	Submitting the output for docker ps -a is enough to prove this exercise has been done.

❯ docker run --name nginx1 -d nginx
❯ docker run --name nginx2 -d nginx
❯ docker run --name nginx3 -d nginx
❯ docker stop nginx1
❯ docker stop nginx2
❯ docker ps -a
CONTAINER ID   IMAGE   COMMAND                  CREATED          STATUS                     PORTS    NAMES
e7d0438fa1d8   nginx   "/docker-entrypoint.…"   34 seconds ago   Up 32 seconds              80/tcp   nginx3
e010ecc5d587   nginx   "/docker-entrypoint.…"   39 seconds ago   Exited (0) 6 seconds ago            nginx2
b651b5afece1   nginx   "/docker-entrypoint.…"   49 seconds ago   Exited (0) 9 seconds ago            nginx1


1.2 Cleanup
	We’ve left containers and a image that won’t be used anymore and are taking space, as docker ps -as and docker images will reveal.
	Clean the docker daemon from all images and containers.
	Submit the output for docker ps -a and docker images

❯ docker container rm $(docker container ls -aq)
❯ docker rmi $(docker images -q)
❯ docker ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS     NAMES
f9716b05174c   nginx:latest   "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   80/tcp    magical_pike
❯ docker images
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
nginx        latest    d1a364dc548d   2 weeks ago   133MB


1.3
	Now that we’ve warmed up it’s time to get inside a container while it’s running!
	Start image devopsdockeruh/exec_bash_exercise, it will start a container with clock-like features and create a log. Go inside the container and use tail -f ./logs.txt to follow the logs. Every 15 seconds the clock will send you a “secret message”.
	Submit the secret message and command(s) given as your answer.

❯ docker run -d --name e3 devopsdockeruh/exec_bash_exercise
❯ docker exec -it e3 bash
root@e92d8b4edc95:/usr/app# tail -F logs.txt
Secret message is:
"Docker is easy"
Wed, 09 Jun 2021 10:29:57 GMT
Wed, 09 Jun 2021 10:30:00 GMT
Wed, 09 Jun 2021 10:30:03 GMT
Wed, 09 Jun 2021 10:30:06 GMT
Secret message is:
"Docker is easy"


1.4
	Create a Dockerfile that starts with FROM devopsdockeruh/overwrite_cmd_exercise. Add a CMD line to the Dockerfile.
	The developer has poorly documented how the application works. Nevertheless once you will execute an application (run a container from an image) you will have some clues on how it works. Your task is to run an application so that it will simulate a number sequence.
	When you will build an image tag it as “docker-sequence” so that docker run docker-sequence starts the application.
	
❯ docker build -f e4.Dockerfile -t e4 .
❯ docker run e4

-h,             --help                  to show this message
-a [age],       --adult [age]           to check if you're older than 18
-c [time],      --clock [time]          to start a clock
-t [size],      --triangle [size]       to draw a triangle, takes second argument as the size

❯ docker run e4 -c
1
2
3
4
5


1.5
	In this exercise we won’t create a new Dockerfile. Image devopsdockeruh/first_volume_exercise has instructions to create a log into /usr/app/logs.txt. Start the container with bind mount so that the logs are created into your filesystem.
	Submit your used commands for this exercise.

❯ docker run -d -it --mount type=bind,source="D:\\logs.txt",target="/usr/app/logs.txt" devopsdockeruh/first_volume_exercise
❯ cat D:\\logs.txt
Wed, 09 Jun 2021 11:44:16 GMT
Wed, 09 Jun 2021 11:44:19 GMT
Wed, 09 Jun 2021 11:44:22 GMT
Wed, 09 Jun 2021 11:44:25 GMT
Secret message is:
"Volume bind mount is easy"
Wed, 09 Jun 2021 11:44:31 GMT

ALT: docker run -d -it --mount type=bind,source="$(pwd)",target="$(pwd)" devopsdockeruh/first_volume_exercise


1.6
	In this exercise we won’t create a new Dockerfile. Image devopsdockeruh/ports_exercise will start a web service in port 80. Use -p flag to access the contents with your browser.
	Submit your used commands for this exercise.

❯ docker run -p 127.0.0.1:80:80 devopsdockeruh/ports_exercise

> ports_exercise@1.0.0 start /usr/app
> node index.js

Listening on port 80, this means inside of the container. Use -p to map the port to a port of your local machine.


1.7 (ONLY EXERCISE 1.10)
	A good developer creates well written READMEs that can be used to create Dockerfiles with ease.
	Clone, fork or download a project from https://github.com/docker-hy/frontend-example-docker.
	Create a Dockerfile for the project and give a command so that the project runs in a docker container with port 5000 exposed and published so when you start the container and navigate to http://localhost:5000 you will see message if you’re successful.
	Submit the Dockerfile.

❯ git clone https://github.com/docker-hy/frontend-example-docker.git
❯ docker build -f e7.Dockerfile -t e7 .
❯ docker run -p 127.0.0.1:5000:5000 e7


1.8
	Lets create a Dockerfile for a Java Spring project: https://github.com/docker-hy/spring-example-project
	The setup should be straightforward with the README instructions. Tips to get you started:
	Use openjdk image FROM openjdk:_tag_ to get java instead of installing it manually. Pick the tag by using the README and dockerhub page.
	You’ve completed the exercise when you see a ‘Success’ message in your browser.

❯ git clone https://github.com/docker-hy/spring-example-project.git
❯ docker build -f e8.Dockerfile -t e8 .
❯ docker run -p 127.0.0.1:8080:8080 e8

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.1.3.RELEASE)
