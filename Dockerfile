# Use a lightweight base image
FROM node:alpine as build

ADD . /app
WORKDIR /app

RUN npm install
RUN npm run build

FROM alpine
COPY --from=build /app/build /www
