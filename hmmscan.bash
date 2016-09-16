#!/bin/sh

for i in *.faa; do hmmscan --cpu 4 --domtblout $i.hmm Pfam-A.hmm $i > $i.log; done
