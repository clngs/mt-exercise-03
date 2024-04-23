#! /bin/bash

scripts=$(dirname "$0")
base=$(realpath $scripts/..)

models=$base/models
data=$base/data
tools=$base/tools
samples=$base/samples

mkdir -p $samples

num_threads=4
device=""
for dropout in 0.0 0.3 0.5 0.7 0.9
do
(cd $tools/pytorch-examples/word_language_model &&
    CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python3 generate.py \
        --data $data/shakespear \
        --words 100 \
        --checkpoint $models/model_shakespear_$dropout.pt \
        --outf $samples/sample_shakespear_$dropout.txt
)
done
