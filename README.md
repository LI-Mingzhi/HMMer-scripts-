# HMMer-scripts
Scripts that deal with HMMer output

### Scan protein sequences, predicted by Prokka 1.8, against a profile-HMM database (from Pfam in this case)
```bash

for i in *.faa; do hmmscan --cpu 4 --domtblout $i.hmm Pfam-A.hmm $i > $i.log; done
```

### Only select genes that contain a functional domain or motif. The output is a GFF3 file that only stores domain containing genes
```bash
  
  perl extract_genes_with_domain.pl <hmm file from hmmscan> <prokka gff3 file>
```


