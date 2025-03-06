#!/bin/bash
text=$(echo $1 | jq -r '.text')
target=$(echo $1 | jq -r '.target')
echo $text | /var/piper/piper --model /var/piper/model.onnx --output-file /output/$target
echo '{"status": "ok"}'