FROM ubuntu:bionic
LABEL maintainer="Marc Rudolph <marc.a.rudolph@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update \
 && apt-get install -y --no-install-recommends pdfsandwich tesseract-ocr tesseract-ocr-deu \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/* \
 && rm -r /var/cache/apt/*

RUN mkdir -p /data/queue /data/output
WORKDIR /bin

VOLUME [ "/data/queue", "/data/output" ]

ENV POLL_INTERVAL=10
ENV QUEUE_PATH="/data/queue"
ENV TARGET_PATH="/data/output"
ENV LANGUAGES="deu"
ENV PDF_SANDWICH_OPTIONS="-rgb -nopreproc"

ENTRYPOINT [ "/bin/autoocr.sh" ]
CMD [ ]

ADD ./*.sh /bin/
