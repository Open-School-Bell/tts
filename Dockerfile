FROM python:3.12-slim

ARG PIPER_VERSION=1.3.0

RUN apt-get update
RUN apt-get install nginx -y
RUN mkdir -p /app

ADD nginx.conf /etc/nginx/sites-enabled/default

RUN python3 -m pip install piper-tts[http]==${PIPER_VERSION}

RUN python3 -m piper.download_voices en_GB-southern_english_female-low

# Put the current verion, piper version and python version into the status file
RUN echo {'"version"': '"2.0.1"', '"piperVersion"': '"'${PIPER_VERSION}'"', '"pythonVersion"': '"'${PYTHON_VERSION}'"'} > /app/status.json

EXPOSE 80

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]