# use the image named node (look for it locally otherwise pull it from docker hub)
FROM node 

# set the working directory to /app (this is where commands will be executed)
WORKDIR /app 

# copy the package.json file into the image under the working directory to avoid re-downloading the dependencies unless the package.json file has changed
COPY package.json /app

# run the npm install command to install the dependencies (this will read the package.json file)
RUN npm install 

# copy the current directory (except the Dockerfile) into the image under the working directory (in our case it's /app, but if not specified it's the root directory)
COPY . /app

# expose port 80 (from the internal container port) to the outside world
# This command is in fact optional. It documents that a process in the container will expose this port. But you still need to then actually expose the port with -p when running docker run. So technically, -p is the only required part when it comes to listening on a port. Still, it is a best practice to also add EXPOSE in the Dockerfile to document this behavior.
EXPOSE 80 

# run the node server.js command inside the container based on the image above to start the application
CMD ["node", "server.js"]    
