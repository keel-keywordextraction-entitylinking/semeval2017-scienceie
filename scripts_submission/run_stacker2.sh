#! /bin/bash

# file where documents are classified
dc=skip-thoughts/TomKenter-siamese-cbow-faf752ef6a99/PREDS/train+dev+test.out
dir=TEST_RESULTS/FIXED_doc

train=train3+dev

prog=stackedLearner.py

for i in 0 1 2 3 4 5; do 

  cs=`./draw.py`

  python ${prog} ${train} test/scienceie2017_test_unlabelled/ /data/wordvecs/glove.6B.50d.txt ${cs} ${dc} document > ${dir}/dc_stacker_glove50_${i}_${cs}.out & 

  cs=`./draw.py`

  python ${prog} ${train} test/scienceie2017_test_unlabelled/ /data/wordvecs/Glove/glove.6B.100d.txt ${cs} ${dc} document > ${dir}/dc_stacker_glove100_${i}_${cs}.out &

  cs=`./draw.py`

  python ${prog} ${train} test/scienceie2017_test_unlabelled/ /data/wordvecs/Glove/glove.42B.300d.txt ${cs} ${dc} document > ${dir}/dc_stacker_glove300_${i}_${cs}.out

  embeddings=/data/wordvecs/ExtendedDependencyBasedSkip-gram/wiki_extvec_words
  cs=`./draw.py`

  python ${prog} ${train} test/scienceie2017_test_unlabelled/ ${embeddings} ${cs} None document > ${dir}/stacker_kominos100_${i}_${cs}.out &

  embeddings=/data/wordvecs/LevyDep/bow2.words
  cs=`./draw.py`

  python ${prog} ${train} test/scienceie2017_test_unlabelled/ ${embeddings} ${cs} None document > ${dir}/stacker_levy_${i}_${cs}.out & 

done


