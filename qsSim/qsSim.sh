stan -t 5 -n 7 -c -s 2 |
    plotTree
ls targets/
ls neighbors/
cres targets/*
cres neighbors/*
kec e -t targets/ -n neighbors/  --min 100 -o diff.fasta
grep '^>' diff.fasta
bash sortSeq.sh diff.fasta > tmp
mv tmp diff.fasta
sblast diff.fasta targets/t1.fasta
ranseq -l 200 |
    tail -n +2 >> targets/t1.fasta
kec e -t targets/ -n neighbors/  --min 100 -o diff.fasta
bash sortSeq.sh diff.fasta > tmp
mv tmp diff.fasta
grep '^>' diff.fasta
sblast diff.fasta targets/t1.fasta
makeFurDb -t targets -n neighbors -d fur.db
fur -d fur.db/ > markers.fasta
head -n 1 markers.fasta
head -n 1 markers.fasta |
    awk -f cut.awk
sblast markers.fasta targets/t2.fasta
