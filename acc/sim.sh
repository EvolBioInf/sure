stan -o
makeFurDb -t targets -n neighbors -d test.db -o
fur -d test.db > fur.fasta
sblast fur.fasta targets/t1.fasta |
    awk -f acc.awk -v ts=4501 -v te=5500 -v tl=10000
