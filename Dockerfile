FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json . 

RUN npm install

COPY . . 

RUN  npm run build


#multi step build phase for production environment 
FROM nginx 

#so elasticbeanstalk can use it as the port to be mapped for incoming traffic
EXPOSE 80

#copy the build files from first step into the folder where neginx serves content
COPY --from=builder /app/build /usr/share/nginx/html

