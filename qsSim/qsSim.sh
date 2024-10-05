stan -t 5 -n 7 -c -T queries -N subjects |
    plotTree
ls queries/
ls subjects/
cres queries/*
cres subjects/*
kec e -t queries/ -n subjects/  --min 100 -o diff.fasta
grep '^>' diff.fasta
sblast diff.fasta queries/q1.fasta
ranseq -l 200 |
    tail -n +2 >> queries/q1.fasta
kec e -t queries/ -n subjects/  --min 100 -o diff.fasta
grep '^>' diff.fasta
sblast diff.fasta queries/q1.fasta
makeFurDb -t queries -n subjects -d qs.db
fur -d qs.db/ > markers.fasta
head -n 1 markers.fasta
head -n 1 markers.fasta |
    awk -f cut.awk
sblast markers.fasta queries/q5.fasta
