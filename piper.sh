#!/bin/bash
text=$(echo $1 | jq '.text')
target=$(echo $1 | jq '.target')
echo $text | /var/piper/piper --model /var/piper/model.onnx --output-file /output/$target
echo '{"status": "ok"}'