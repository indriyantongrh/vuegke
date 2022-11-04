FROM node:12.18.1-alphine AS build
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

#create nginxserver
FROM nginx:1.19.0-alphine AS prod-stage
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off" ]