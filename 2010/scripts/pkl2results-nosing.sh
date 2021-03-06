#! /bin/bash
# argument: the name, without extension, of a pickled python set of gambles, assumed to have the extension .pkl
# prerequisites:
# * binaries from the cdd and lrs bundles installed in ~/bin/
# * the python scripts of the constraints bundle in the present working directory 
# output: processed H- (.ine) and V-polyhedral (.ext, .adj) format files; the former contain coherence constraints, the latter extreme lower previsions

./constraints.py $1.pkl > $1.ine
~/bin/gredund $1.ine > $1-nr.ine
./cardinality.py $1.pkl | ~/bin/fourier_gmp $1-nr.ine > $1-nosing.ine # remove singletons
sed '/input/,/Nonredundant/d' $1-nosing.ine | ~/bin/lcdd_gmp > $1-nosing.ext
~/bin/adjacency_gmp $1-nosing.ext > $1-nosing.adj
