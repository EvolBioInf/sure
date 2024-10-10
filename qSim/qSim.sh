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
    plotLine -x "Position (Mb)" -y Mappability -Y "0:1.1"
tail -n +2  q_gm.out.txt |
    tr ' ' '\n' |
    sw -w 1000 |
    cut -f 3 |
    sort -n |
    head -n 2500 |
    tail -n 1
tail -n +2  q_gm.out.txt |
    tr ' ' '\n' |
    sw -w 1000 |
    merwin -t 0.992 -w 1000 |
    head
tail -n +2  q_gm.out.txt |
    tr ' ' '\n' |
    sw -w 1000 |
    merwin -t 0.992 -w 1000 |
    awk '{l=$3-$2+1;s+=l}END{print s}'
echo '4990800/5000000*100' | bc -l
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
genmap index -F q3.fasta -I q3_gm.idx
genmap map -I q3_gm.idx -K 15 -E 0 -O q3_gm.out -t
tail -n +2 q3_gm.out.txt |
    tr ' ' '\n' |
    head -n 5000000 |
    sw -w 1000 > q3.map
awk '{print $2/1000000, $3}' q3.map |
    plotLine -x "Position (Mb)" -y Mappability -Y "0:1.1"
randomizeSeq q3.fasta > q3r.fasta
genmap index -F q3r.fasta -I q3r_gm.idx
genmap map -I q3r_gm.idx -K 15 -E 0 -O q3r_gm.out -t
grep -v '^>' q3r_gm.out.txt |
    tr ' ' '\n' |
    sw -w 1000 |
    cut -f 3 q3r.map |
    sort -n |
    head -n 5000 |
    tail -n 1
merwin -t 0.986 q3.map
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
genmap index -F q4.fasta -I q4_gm.idx
genmap map -I q4_gm.idx -K 15 -E 0 -O q4_gm.out -t
grep -v '^>' q4_gm.out.txt |
    tr ' ' '\n' |
    head -n 5000000 |
    sw -w 1000 > q4.map
    awk '{print $2/1000000, $3}' q4.map |
    plotLine -x "Position (Mb)" -y Mappability -Y "0:1.1"
merwin -w 1000 -t 0.986 q4.map
macle -s q4.fasta > q4_ma.idx
macle -n q4 -w 1000 q4_ma.idx |
    awk '{print $2/1000000, $3}' |
    plotLine -x "Position (Mb)" -y "C_m"
macle -w 1000 q4_ma.idx |
    merwin -t 0.9855 -w 1000
