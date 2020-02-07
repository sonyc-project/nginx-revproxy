FROM nginx

ADD conf.d/ /etc/nginx/conf.d
ADD https://raw.githubusercontent.com/jwilder/nginx-proxy/master/nginx.tmpl \
    /etc/docker-gen/templates/nginx.tmpl
