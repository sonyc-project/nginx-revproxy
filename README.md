# nginx-revproxy

## WebProxy using NGINX and Lets encrypt containers

With these containers, you can spin up multiple sites using domains and
subdomains by leveraging NGINX's reverse proxy connections automatically
to container ports listening on 80 or 443. The letsencrypt container
monitors for SSL certificates and re/creates them.

### How to Use it?

Any container that you want to be exposed, you need to:

- Make sure that they are connected to the same network that the nginx
containers are.

- When spinning up the containers, make sure to pass 3 environment
variables:
    - VIRTUAL_HOST=subdomain.domain.com
    - LETSENCRYPT_HOST=subdomain.domain.com
    - LETSENCRYPT_EMAIL=admin@admin.com (defaults to .env DEFAULT_EMAIL or sonyc.project@gmail.com)
    - VIRTUAL_PORT: 1234 (optional, only needed if your container service is listening on port other than 80 or 443)

- To override certain compose values, copy the `env.sample` to `.env` and edit it according to the requirements

- Create the network `docker network create webproxy`
- Finally, run `docker-compose up -d`

### Updates

To update without downtime, do:

```bash
git pull # or whatever updates
docker-compose up -d --no-deps --build
```


### Security Considerations

- While the internet-facing `nginx-web` service does not have docker socket mounted,
it is running in privileged mode because it needs to bind the host's port 80.

- `nginx-gen` and `nginx-letsencrypt` are also running in privileged mode with
docker socket mounted in `ro` mode.


### Credits

Without the repositories below this webproxy wouldn´t be possible.

Credits goes to:
- docker-compose-letsencrypt-nginx-proxy-companion [@evertramos](https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion)
- nginx-proxy [@jwilder](https://github.com/jwilder/nginx-proxy)
- docker-gen [@jwilder](https://github.com/jwilder/docker-gen)
- docker-letsencrypt-nginx-proxy-companion [@JrCs](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion)

> Note: The docker-compose.yml, as-is, is running fine but will be heavily
> modified in near future to adapt it for other swarm services.
