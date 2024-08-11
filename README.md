
# Api (Expressjs) 

This project contains the api using expressjs

## Features

- Docker Compose for MongoDB and Express.js service
- Dockerfile to create a Docker image for the app
- Azure Pipeline to build and push the image
- The pipeline will use a Helm chart template located in another repo, update the values.yaml, and then deploy


## Development server

Run `npm run dev-server` to start the api server in development mode (using nodemon).
### Dockerfile Production

```dockerfile
FROM node:21-alpine

# Copy dependency definitions
COPY package.json package-lock.json ./

# disabling ssl for npm for Dev or if you are behind proxy
RUN npm set strict-ssl false


## installing and Storing node modules on a separate layer will prevent unnecessary npm installs at each build
RUN npm i && mkdir /app && mv ./node_modules ./app

# Change directory so that our commands run inside this new directory
WORKDIR /app

# Get all the code needed to run the app
COPY . /app/

# Expose the port the app runs in
EXPOSE 3000

USER node

# Serve the app
CMD ["npm", "start"]

```

## Run Docker Compose

Run `docker-compose up -d` to start the backend express service and MongoDB.
- The backend service will now be available at localhost:3000, and the frontend can start using it.

Run `docker-compose down` to stop.

### Azure Pipeline

``` azure-pipelines.yml
Pipeline
│
├── Trigger: Branches include 'main'
│
├── Pool: yarb
│
├── Resources
│   └── Repositories
│       └── helmchart-repo (GitHub)
│
├── Steps
│   │
│   ├── Check Helm Installation
│   │
│   ├── Set Image Tags
│   │
│   ├── Build and Push Docker Image with Unique Tag
│   │
│   ├── Tag and Push Docker Image with Latest Tag
│   │
│   ├── Checkout helmchart-repo
│   │
│   ├── Check Directory Files
│   │
│   ├── Update Image Tag in values.yaml
│   │
│   ├── Deploy Express HelmChart
│   │
│   ├── Rollback Helm Deployment (on deployment failure)
│   │
│   ├── Clean Up Old Docker Images Locally
│   │
│   ├── Clean WORKDIR
│      └── Clean Workspace 
   
```

HelmChart URL: https://github.com/yousabu/contacts-system-helmchart.git
frontend URL : https://github.com/yousabu/contacts-system-frontend.git

