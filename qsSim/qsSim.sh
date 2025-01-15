stan -t 5 -n 7 -c -s 2 |
    plotTree
ls targets/
ls neighbors/
cres targets/*
cres neighbors/*
makeFurDb -t targets -n neighbors -d fur.db
fur -d fur.db/ > markers.fasta
head -n 1 markers.fasta
head -n 1 markers.fasta |
    awk -f cut.awk
sblast markers.fasta targets/t2.fasta
