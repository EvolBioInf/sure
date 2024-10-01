ranseq -l 5000000 > q.fasta
genmap index -F q.fasta -I q_gm.idx
genmap map -I q_gm.idx/ -K 15 -E 0 -O q_gm.out -t 
wrapSeq q_gm.out.txt | head
tail -n +2  q_gm.out.txt |
    tr ' ' '\n' |
    awk 'NR%100==0{print NR/1000000, $1}' |
    plotLine -x "Position (Mb)" -y Mappability
tail -n +2  q_gm.out.txt |
    tr ' ' '\n' |
    sw -w 1000 |
    awk '{print $2/1000000, $3}' |
    plotLine -x "Position (Mb)" -y Mappability -Y "0:1"
tail -n +2  q_gm.out.txt |
    tr ' ' '\n' |
    sw -w 1000 |
    merwin -t 0.98 -w 1000
macle -s q.fasta > q_ma.idx
macle -w 1000 q_ma.idx |
    awk '{print $2/1000000, $3}' |
    plotLine -x "Position (Mb)" -y C_m -Y "0:1"
mantile -l 5000000 -w 1000 -g 0.5 -p 0.05
macle -w 1000 q_ma.idx |
    merwin -t 0.9852 -w 1000 |
    head
macle -w 1000 q_ma.idx |
    merwin -t 0.9852 -w 1000 |
    awk '{l=$3-$2+1;s+=l}END{print s}'
echo '4987400/5000000 * 100' | bc -l
mutator q.fasta > q2.fasta
echo ">q3" > q3.fasta
cat q.fasta q2.fasta |
    grep -v '^>' >> q3.fasta
macle -s q3.fasta > q3_ma.idx
macle -w 1000 q3_ma.idx |
    awk '{print $2/1000000, $3}' |
    plotLine -Y "0:1" -x "Position (Mb)" -y C_m
mantile -l 10000000 -w 1000 -g 0.5 -p 0.05
macle -w 1000 q3_ma.idx |
    merwin -t 0.9855 -w 1000
echo ">q4" > q4.fasta
tail -n +2 q.fasta >> q4.fasta
cutSeq -r 1-2499000,2501001-5000000 -j q2.fasta >> q4.fasta
macle -s q4.fasta > q4_ma.idx
macle -n q4 -w 1000 q4_ma.idx |
    awk '{print $2/1000000, $3}' |
    plotLine -x "Position (Mb)" -y "C_m"
macle -w 1000 q4_ma.idx |
    merwin -t 0.9855 -w 1000
