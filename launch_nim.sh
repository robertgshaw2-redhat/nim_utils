IMAGE=${IMAGE:-nvcr.io/nim/meta/llama-3.3-70b-instruct}

if [[ ! -v NIM_MODEL_PROFILE ]]; then
  echo "NIM_MODEL_PROFILE is unset."
  exit 0
fi

sudo docker run -it --rm \
  --gpus all \
  --shm-size=16GB \
  -e NGC_API_KEY=$NGC_API_KEY \
  -e NIM_MODEL_PROFILE=$NIM_MODEL_PROFILE \
  -e NIM_ENABLE_KV_CACHE_REUSE=1 \
  -v "$LOCAL_NIM_CACHE:/opt/nim/.cache" \
  -p 8000:8000 \
  $IMAGE