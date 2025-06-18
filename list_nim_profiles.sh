IMAGE=${IMAGE:-nvcr.io/nim/meta/llama-3.3-70b-instruct}

sudo docker run --rm --gpus=all -e NGC_API_KEY=$NGC_API_KEY $IMAGE list-model-profiles
