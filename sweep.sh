CONCURRENCIES=(1 25 50 100 150 200)

INPUT_LEN=650
OUTPUT_LEN=150
PREFIX_LEN=500
CC_MULT=30
MODEL=${MODEL:-RedHatAI/Llama-3.3-70B-Instruct-FP8-dynamic}
TOKENIZER=${TOKENIZER:-RedHatAI/Llama-3.3-70B-Instruct-FP8-dynamic}


for CONCURRENCY in "${CONCURRENCIES[@]}";
do
    NUM_PROMPTS=$(($CC_MULT * $CONCURRENCY))
    
    echo ""
    echo "===== RUNNING $MODEL FOR $NUM_PROMPTS PROMPTS WITH $CONCURRENCY ====="
    echo ""

    python3 ..vllm//benchmarks/benchmark_serving.py \
        --served-model-name $MODEL \
        --model $TOKENIZER \
        --dataset-name random \
        --random-prefix-len $PREFIX_LEN \
        --random-input-len $INPUT_LEN \
        --random-output-len $OUTPUT_LEN \
        --max-concurrency $CONCURRENCY \
        --num-prompts $NUM_PROMPTS \
        --seed $(date +%s) \
        --percentile-metrics ttft,tpot,itl,e2el \
        --metric-percentiles 90,95,99 \
        --ignore-eos

done