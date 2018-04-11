# STAGE 0 Build the Angular applicatoin in a builder image

# set our base image to the official note alpine image from the docker hub and name it 'node'
FROM node:9.11.1-alpine as builder

# set the working directory of our docker image
WORKDIR /app 


#copy npm package definitions into our working directory
COPY package.json /app/

# download all packages into image
RUN npm install

# copy the entire web project (minus .dockerignore) into image
COPY ./ /app/

# create an environment variable to use in Angular CLI
ARG env=prod

# build the angular app
RUN npm run build -- --prod --environment $env

#STAGE 1 - Create the Prod image from the test image

#set our deploy image to the official NGINX image from the docker hub
FROM nginx:1.13-alpine

#copy the 'dist' folder from tage 0 to NGINX web server directory
COPY --from=builder /app/dist/ /usr/share/nginx/html

#overwrite NGNIX default config with custom config
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf 