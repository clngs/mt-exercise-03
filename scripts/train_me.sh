#! /bin/bash

scripts=$(dirname "$0")
base=$(realpath $scripts/..)

models=$base/models
data=$base/data
tools=$base/tools
logs=$base/logs

mkdir -p $models
mkdir -p $logs

num_threads=4
device=""

SECONDS=0

for dropout in 0.0 0.3 0.5 0.7 0.9
do
    echo "dropout: $dropout"
    (cd "$tools/pytorch-examples/word_language_model" && pwd && 
        CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python3 main.py --data "$data/shakespear" \
            --epochs 40 \
            --log-interval 100 \
            --emsize 200 --nhid 200 --dropout $dropout --tied \
            --save $models/model_shakespear_$dropout.pt \
            --perplexity-log "$logs/perplexity_shakespear_$dropout.log"
    )
    echo "time taken:"
    echo "$SECONDS seconds"
done 
