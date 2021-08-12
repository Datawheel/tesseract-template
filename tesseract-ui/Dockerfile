# syntax=docker/dockerfile:1

# use Node image to build static assets
FROM node:12-alpine AS builder

ARG TESSERACT_URL

WORKDIR /app
RUN npm init @datawheel/tesseract-ui tesseract-ui --server=/tesseract --env=production
COPY ./create-nginx-config.sh ./create-nginx-config.sh
RUN chmod +x create-nginx-config.sh
# create NGINX config with proxy to Tesseract instance
RUN ./create-nginx-config.sh ${TESSERACT_URL} > nginx.conf

WORKDIR /app/tesseract-ui
RUN npm ci
RUN npm run build

# Build the actual server image using built static files
FROM nginx:latest

# copy config
COPY --from=builder /app/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/tesseract-ui/dist /usr/share/nginx/html/
