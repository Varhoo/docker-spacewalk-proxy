# docker-spacewalk-proxy

Create from official wiki page https://fedorahosted.org/spacewalk/wiki/HowToInstallProxy

build:

```
docker build -t spacewalk-proxy .
```

run:

```
docker run -p 80:80 -d -P \
           -p 443:443 \
           -p 5222:5222 \
           -p 5269:5269 \
           -p 5280:5280 \
           -e RHN_SERVER=<spacewalk hostname> \
           -e RHN_PASS=<password> \
           -e RHN_USER=<login> \
spacewalk-proxy
```
