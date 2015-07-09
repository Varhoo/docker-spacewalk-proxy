# docker-spacewalk-proxy

Create from official wiki page https://fedorahosted.org/spacewalk/wiki/HowToInstallProxy

build:

```
sudo -s
docker build -t spacewalk-proxy .
```

pull and run it:

```
sudo -s
docker pull varhoo/spacewalk-proxy
docker run -p 80:80 -d -P \
           -p 443:443 \
           -p 5222:5222 \
           -p 5269:5269 \
           -p 5280:5280 \
           -e RHN_SERVER=<spacewalk hostname> \
           -e RHN_PASS=<password> \
           -e RHN_USER=<login> \
varhoo/spacewalk-proxy
```
