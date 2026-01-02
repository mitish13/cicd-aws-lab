# Using nginx alpine as base image
# nginx is a web server that can serve static website pages efficiently; also used for reverse proxy, load balancing, and HTTP caching.
FROM nginx:alpine

# nginx has default static files, we will delete that first
RUN rm -rf /usr/share/nginx/html/* 

# copy our index.html file to the default nginx html directory
COPY src/index.html /usr/share/nginx/html/

# Both below commands is optional

# exposing port 80 is just for documentation purpose; as docker container automatically will expose the port used by the main process running inside the container.
EXPOSE 80

# nginx:alpine image already has default comand to start nginx server and set daemon off; but we are adding here for clarity.
CMD ["nginx", "-g", "daemon off;"]
# Docker container always runs by main process, if that process stops, the container stops.
# Here we are running cmd 'nginx -g daemon off'; because if not doing so, nginx will start and then daemonize itself, 
# then start child process and exit the main process, which will cause the container to stop. 
# By using this command, we keep the nginx process in the foreground, ensuring that the container remains running.



