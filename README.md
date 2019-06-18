# glycosilation
Search for glycosilation proteins

- O-glycosilation
run as: searchOglicosilation.pl file X Y\
. file = fasta file with protein sequences\
. X = window size\
. Y = Ser+Thr percent threshold\

- N-glycosilation
run as: searchOglicosilation.pl file X\
. file = fasta file with protein sequences\
. X = sequence pattern (default: N[^P][STC])

Example files:\
./Umaydis_valid_orf_prot_121009 (fasta file)
um_transmembrane.txt (annotation file with transmembrane proteins)
