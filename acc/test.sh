sblast fur.fasta t1.fasta |
    awk -f acc.awk -v ts=4501 -v te=5500 -v tl=10000 > r2.txt
d=$(diff r1.txt r2.txt)
if [[ "$d" != "" ]]; then
    echo "fail: $d"
else
    echo "pass"
fi
