#!/usr/bin/env bash
# Modified from version in: https://github.com/osirrc/indri-docker

# Turn the TREC topic format into a Galago batch search.

INDEX="/"$1
TOPICFILE=$2
TOPK=$3
OUTFILENAME=$4
RESFILE=/output/$4

BATCH_SEARCH_QUERIES="./batch-search.json"

#Reformat the topic file (original TREC format) into one galago can process
python3 /formatTopics.py "${TOPICFILE}" "${BATCH_SEARCH_QUERIES}"

#start searching
echo "ROBUST04 ... Processing topics"
/work/galago-3.15-bin/bin/galago batch-search "${BATCH_SEARCH_QUERIES}" --index="${INDEX}"  --requested=${TOPK}  "${OPTIONS}"  >> ${RESFILE}
