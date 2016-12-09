# docker-spacewalk-proxy

This images is created from official wiki page https://fedorahosted.org/spacewalk/wiki/HowToInstallProxy25

build:

```
docker build -t spacewalk-proxy .
```

pull and run it:

```
docker pull varhoo/spacewalk-proxy
docker run -p 80:80 -d \
           -p 443:443 \
           -p 5222:5222 \
           -p 5269:5269 \
           -p 5280:5280 \
           -e RHN_SERVER=<spacewalk hostname> \
           -e RHN_PASS=<password> \
           -e RHN_USER=<login> \
varhoo/spacewalk-proxy
```
