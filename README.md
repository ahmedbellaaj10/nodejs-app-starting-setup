# Node.js Docker Learning Project

This repository contains a minimal Node.js application designed to help developers learn Docker fundamentals. The application serves as a simple web server that is used to learn how to containerize a Node.js application using Docker.

## Project Structure

```
.
├── Dockerfile         # Contains instructions for building the Docker image
├── package.json       # Node.js project configuration and dependencies
├── server.js          # Simple Node.js web server
└── public/            # Static files directory
```

## Docker Concepts Explained

### Docker Image vs Container

#### Docker Image
- A Docker image is a **read-only template** that contains all the necessary files and configurations to run an application
- Images are **layer-based**, meaning each instruction in the Dockerfile creates a new layer
- Key properties of Docker images:
  - **Read-only**: Once created, images cannot be modified
  - **Layer-based**: Each layer represents a change to the filesystem
  - **Immutable**: To make changes, you create a new image
  - **Reusable**: Images can be used to create multiple containers
  - **Shareable**: Images can be pushed to and pulled from registries (like Docker Hub)

#### Docker Container
- A container is a **running instance** of an image
- Containers are **mutable** and can be modified during runtime
- Each container has its own:
  - Filesystem
  - Network interface
  - Process space
  - Resource limits

## Dockerfile Walkthrough

Let's break down the Dockerfile and understand what happens during image building vs container runtime:

### Image Building Steps (Dockerfile Instructions)

1. **Base Image Selection**
   ```dockerfile
   FROM node
   ```
   - Creates the first layer using the official Node.js image
   - This layer contains the Node.js runtime and npm

2. **Working Directory Setup**
   ```dockerfile
   WORKDIR /app
   ```
   - Creates a new layer setting the working directory
   - All subsequent commands will run from this directory

3. **Dependency Installation**
   ```dockerfile
   COPY package.json /app
   RUN npm install
   ```
   - Copies package.json first (for better layer caching)
   - Creates a new layer with all node_modules
   - This layer contains all application dependencies

4. **Application Code**
   ```dockerfile
   COPY . /app
   ```
   - Creates a new layer with the application code
   - This layer contains all your source files

5. **Port Configuration**
   ```dockerfile
   EXPOSE 80
   ```
   - Documents that the container will listen on port 80
   - This is documentation only, actual port mapping happens at runtime

### Container Runtime (What happens when you run the container)

1. **Container Initialization**
   - Docker creates a new container from the image
   - A new writable layer is added on top of the image layers
   - This layer is called the "container layer"

2. **Command Execution**
   ```dockerfile
   CMD ["node", "server.js"]
   ```
   - The container starts by running this command
   - The Node.js server starts and listens on port 80

## Running the Application

To build and run the application:

```bash
# Build the image
docker build -t nodejs-app .

# Run the container
docker run -p 3000:80 nodejs-app
```

The application will be available at `http://localhost:3000`

## Layer Benefits

The layer-based architecture of Docker images provides several benefits:

1. **Caching**: Docker caches each layer. If a layer hasn't changed, Docker reuses the cached version
2. **Size Efficiency**: Common layers can be shared between images
3. **Build Speed**: Only changed layers need to be rebuilt
4. **Version Control**: Each layer represents a specific state of the filesystem

## Best Practices Demonstrated

1. **Layer Optimization**: Copying package.json before the full codebase to leverage Docker's layer caching
2. **Explicit Port Documentation**: Using EXPOSE to document the container's port
3. **Clean Base Image**: Using the official Node.js image
4. **Proper Working Directory**: Setting a dedicated working directory 
