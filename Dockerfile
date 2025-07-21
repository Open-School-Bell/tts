FROM python:3.12-slim

COPY entrypoint.sh /

RUN python3 -m pip install piper-tts[http]

RUN python3 -m piper.download_voices en_GB-southern_english_female-low

EXPOSE 5000

ENTRYPOINT ["/entrypoint.sh"]