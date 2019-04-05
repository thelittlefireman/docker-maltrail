FROM python:2-slim-stretch

RUN apt-get update \ 
    && apt-get upgrade -y \
    && apt-get install -y build-essential libpcap-dev python-pcapy bash git curl schedtool \
    && git clone https://github.com/stamparm/maltrail.git /root/maltrail \
    && pip install pcapy

# CUSTOM malwareworld feeds

RUN  cd /root/maltrail/trails/feeds \
  && curl https://raw.githubusercontent.com/carlospolop/MaltrailWorld/master/trails/feeds/malwareworld_domains.py --output malwareworld_domains.py \
  && curl https://raw.githubusercontent.com/carlospolop/MaltrailWorld/master/trails/feeds/malwareworld_ips.py --output malwareworld_ips.py \
   && python /root/maltrail/core/update.py

WORKDIR /root/maltrail

RUN cd /root/maltrail \
   && pip install -r requirements.txt

#VOLUME /root/maltrail/maltrail.conf

VOLUME /var/log/maltrail

COPY run.sh /root/run.sh

EXPOSE 8338

ENTRYPOINT  ["/bin/bash", "/root/run.sh"]