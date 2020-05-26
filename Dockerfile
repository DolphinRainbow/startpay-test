FROM node:12 as builder

RUN mkdir -p /gitbook && npm config set registry http://r.cnpmjs.org && \
    npm install gitbook-cli -g

WORKDIR /gitbook
ADD gitbook.tar.gz /gitbook
RUN gitbook build

FROM nginx
COPY --from=builder /gitbook/_book /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
