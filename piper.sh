#!/bin/bash
text=$(echo $1 | jq -r '.text')
target=$(echo $1 | jq -r '.target')
speed=$(echo $1 | jq -r '.speed')
echo $text | /var/piper/piper --length_scale $speed --model /var/piper/model.onnx --output-file /output/$target &> /dev/null
cat /output/$target
