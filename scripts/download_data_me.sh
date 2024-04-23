#! /bin/bash

scripts=$(dirname "$0")
base=$scripts/..

data=$base/data

mkdir -p $data

tools=$base/tools


# download a different interesting data set!


mkdir -p $data/shakespear

mkdir -p $data/shakespear/raw

wget --no-check-certificate https://www.gutenberg.org/cache/epub/573/pg573.txt
mv pg573.txt $data/shakespear/raw/tales.txt

# preprocess slightly

cat $data/shakespear/raw/tales.txt | python3 $base/scripts/preprocess_raw.py > $data/shakespear/raw/tales.cleaned.txt

# tokenize, fix vocabulary upper bound

cat $data/shakespear/raw/tales.cleaned.txt | python3 $base/scripts/preprocess.py --vocab-size 5000 --tokenize --lang "en" --sent-tokenize > \
    $data/shakespear/raw/tales.preprocessed.txt

# split into train, valid and test

head -n 440 $data/shakespear/raw/tales.preprocessed.txt | tail -n 400 > $data/shakespear/valid.txt
head -n 840 $data/shakespear/raw/tales.preprocessed.txt | tail -n 400 > $data/shakespear/test.txt
tail -n 3075 $data/shakespear/raw/tales.preprocessed.txt | head -n 2955 > $data/shakespear/train.txt
