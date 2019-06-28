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

## Passing Parameters to Galago

Since both the jig and Galago specify parameters using a double dash, we can't use
the double dash when specifying a Galago parameter because the jig will think it's a
jig parameter. We also can't use an equal sign when specifying a Galago parameter value
due to the way the jig parses key/value pairs. So, to specify a Galago parameter we use the 
`search_options` field of the `--opts` parameter. For example, if you wanted to change the 
default value of `mu` when running Galago outside of the jig you would specify `--mu=1000`. 
Using the jig, you would specify `--opts search_options="mu:1000"`. 


## Retrieval Methods

The Galago image supports the following retrieval method:

* **QL** : Query likelihood with Dirichlet smoothing.
    * **Parameters** :
        * mu : default 1500. 
        
* **BM25** :  
    * **Parameters** :
        * b : Controls degree of length normalization (values 0..1; default 0.75).
        * k : Normalization parameter for document length (default 1.2).
        * w : Custom weight for term (default 1.0).

* **SDM** : Sequential Dependence Model with Dirichlet smoothing.
    * **Parameters** :
        * uniw : Unigram query component weight (default 0.8).
        * odw : Ordered window query component weight (default 0.15).
        * uww : Unordered window query component weight (default 0.05).
        * windowLimit : Window proximity limit (default 2).
        * fast : Faster operators (true/false) (bigram/ubigram operators).
        * sdm.od.op : Ordered window operator (default "ordered").
        * sdm.uw.op : Unordered window operator (default "unordered").
        * sdm.od.width : Window width (default 1).
        * sdm.uw.width : Window width (default 4).
        
## Expected Results

### robust04

|Galago Parameter(s)| MAP    | P@10    | P@30 |NDCG@10|NDCG@30| 
| ------------- | ------------- |:-------------:| -----:| -----:| -----:|
|QL|0.1948|0.3888|0.2659|0.4038|0.3573|
| QL (--opts search_options="mu:1000")|0.1962|0.3916|0.2663|0.4077|0.3582|
|BM25 (--opts search_options="scorer:bm25")|0.1825|0.3799|0.2581|0.3889|0.3439|
|SDM (--opts search_options="operatorWrap:sdm")|0.1984|0.3888|0.2251|0.3997 |0.3610|


