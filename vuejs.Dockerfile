# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY /app/package*.json ./
RUN yarn install
COPY /app .

RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
