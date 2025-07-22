# Text To Speech

Uses [piper](https://github.com/OHF-Voice/piper1-gpl) to perform text to speech.

Built as a docker container with nginx to proxy to the piper webserver. This allows us to pin the piper version and keep a stable image ourselves.