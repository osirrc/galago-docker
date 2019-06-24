# galago-docker

# OSIRRC Docker Image for Galago 

[**Michael Zarozinski**](https://github.com/mzarozinski)

This is the docker image for [Galago v3.15](https://sourceforge.net/projects/lemur/) conforming to the [OSIRRC jig](https://github.com/osirrc/jig/) for the [Open-Source IR Replicability Challenge (OSIRRC) at SIGIR 2019](https://osirrc.github.io/osirrc2019/).

This image is based on the Indri image by [**Claudia Hauff**](https://github.com/chauff) (https://github.com/osirrc/indri-docker)

+ Supported test collections: `robust04`
+ Supported hooks: `index`, `search`

## Quick Start

First, clone the [`jig`](https://github.com/osirrc/jig) and follow its setup instructions - in particular, do not forget to also clone and install `trec_eval` inside the `jig` directory!
