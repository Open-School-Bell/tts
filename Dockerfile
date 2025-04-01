FROM ncarlier/webhookd:latest

ARG TARGETPLATFORM
ARG PIPER_VERSION=1.2.0

USER root

RUN apk add wget libstdc++
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi \
    && cd /tmp \
    && wget https://github.com/rhasspy/piper/releases/download/v${PIPER_VERSION}/piper_${ARCHITECTURE}.tar.gz \
    && tar -xvf piper_${ARCHITECTURE}.tar.gz \
    && cp -r ./piper /var
RUN cd /var/piper \
    && wget https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/southern_english_female/low/en_GB-southern_english_female-low.onnx?download=true -O model.onnx \
    && wget https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/southern_english_female/low/en_GB-southern_english_female-low.onnx.json?download=true.json -O model.onnx.json

RUN mkdir -p /output
RUN chmod 777 /output

ADD ./piper.sh /scripts/piper.sh
RUN chown webhookd:webhookd /scripts/piper.sh
RUN chmod +x /scripts/piper.sh

ADD ./status.sh /scripts/status.sh
RUN chown webhookd:webhookd /scripts/status.sh
RUN chmod +x /scripts/status.sh

RUN echo {'"version"': '"1.0.1"', '"piperVersion"': '"'${PIPER_VERSION}'"'} > /var/piper/status.json

USER webhookd

CMD [ "webhookd" ]