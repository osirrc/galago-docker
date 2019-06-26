# OSIRRC Docker Image for Galago 

[![Build Status](https://travis-ci.com/osirrc/galago-docker.svg?branch=master)](https://travis-ci.com/osirrc/galago-docker)

[**Michael Zarozinski**](https://github.com/mzarozinski)

This is the docker image for [Galago v3.15](https://sourceforge.net/projects/lemur/) conforming to the [OSIRRC jig](https://github.com/osirrc/jig/) for the [Open-Source IR Replicability Challenge (OSIRRC) at SIGIR 2019](https://osirrc.github.io/osirrc2019/).
This image is available on [Docker Hub](https://hub.docker.com/r/osirrc2019/galago).

This image is based on the Indri image by [**Claudia Hauff**](https://github.com/chauff) (https://github.com/osirrc/indri-docker)

+ Supported test collections: `robust04`
+ Supported hooks: `index`, `search`

## Quick Start

First, clone the [`jig`](https://github.com/osirrc/jig) and follow its setup instructions - in particular, do not forget to also clone and install `trec_eval` inside the `jig` directory.

-------------------------------


The following `jig` command can be used to index TREC disks 4/5 for `robust04`:

```
python run.py prepare \
  --repo osirrc2019/galago \
  --tag v0.0.2 \
  --collections robust04=/path/to/disk45=trectext
```

The following `jig` command can be used to perform a retrieval run on the collection with the `robust04` test collection.

```
python run.py search \
  --repo osirrc2019/galago \
  --tag v0.0.2 \
  --output ./output \
  --top_k 1000 \
  --qrels qrels/qrels.robust04.txt \
  --topic topics/topics.robust04.txt \
  --collection robust04 \
  --opts out_file_name="output_robust04.txt" 
```

## Retrieval Methods

The Galago image supports the following retrieval method:

+ **QL** : Query likelihood with Dirichlet smoothing, mu default 1500. 

## Expected Results

### robust04

| MAP    | P@10    | P@30 | NDCG@10   |  NDCG@30   | 
| ------------- |:-------------:| -----:| -----:| -----:|
| 0.1948      | 0.3888 |  0.2659|0.4038 |0.3573 |

