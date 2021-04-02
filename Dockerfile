FROM node AS builder


RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

# Prueba
RUN npm install
RUN $(npm bin)/ng build --prod --aot

FROM nginx
WORKDIR /usr/share/nginx/html/
COPY --from=builder /usr/src/app/dist/my-app/ /usr/share/nginx/html
EXPOSE 80 

CMD nginx -g 'daemon off;'