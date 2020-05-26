FROM node:12 as builder

RUN mkdir -p /gitbook && npm config set registry https://registry.npm.taobao.org &&
    npm install -g gitbook-cli

WORKDIR /gitbook
ADD gitbook.tar.gz /gitbook
CMD ['gitbook','build']

FROM nginx
COPY --from=builder /gitbook/_book /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
