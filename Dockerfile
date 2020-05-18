FROM node:lts-alpine as build-stage

WORKDIR /app

COPY package*.json ./

RUN NPM install

COPY . .

RUN npm build

# Production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stager /app/dist /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]



