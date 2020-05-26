FROM node:12 as builder
RUN mkdir -p /gitbook && npm config set registry http://r.cnpmjs.org && \
    npm install gitbook-cli -g
WORKDIR /gitbook
ADD gitbook.tar.gz /gitbook
RUN gitbook build && cd _book && tar -zcvf gitbook.tar.gz *

FROM nginx
COPY --from=builder /gitbook/_book/gitbook.tar.gz /
RUN tar -zxvf /gitbook.tar.gz -C /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
