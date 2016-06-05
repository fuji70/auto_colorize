FROM kaixhin/torch
MAINTAINER github/fuji70

RUN mkdir -p /opt
WORKDIR /opt
RUN git clone https://github.com/satoshiiizuka/siggraph2016_colorization
WORKDIR /opt/siggraph2016_colorization

RUN apt-get install -y wget
RUN sh download_model.sh

RUN mkdir -p working
ENTRYPOINT ["th", "colorize.lua"]
CMD ["ansel_colorado_1941.png", "working/out.png"]
