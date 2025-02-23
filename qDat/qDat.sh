datasets download genome accession GCF_000001405.40 \
           --include genome,gff3 \
           --dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory .
path="ncbi_dataset/data/GCF_000001405.40"
path="$path/GCF_000001405.40_GRCh38.p14_genomic.fna"
mv $path hs.fna
mv ncbi_dataset/data/GCF_000001405.40/genomic.gff hs.gff
grep '^>' hs.fna | grep NC
getSeq NC_000021.9 hs.fna > chr21.fna
cres chr21.fna
genmap index -F chr21.fna -I chr21_gm.idx
genmap map -I chr21_gm.idx/ -K 15 -E 0 -O chr21_gm.out -t 
tail -n +2 chr21_gm.out.txt |
    tr ' ' '\n' |
    sw -w 10000 > chr21.map
tr -d N < chr21.fna |
    grep -v '^$' |
    randomizeSeq |
    wrapSeq > chr21r.fna
genmap index -F chr21r.fna -I chr21r_gm.idx
genmap map -I chr21r_gm.idx/ -K 15 -E 0 -O chr21r_gm.out -t 
tail -n +2 chr21r_gm.out.txt |
    tr ' ' '\n' |
    sw -w 10000 |
    cut -f 3 |
    sort -n |
    head -n 2004 |
    tail -n 1
merwin -w 10000 -t 0.9388 chr21.map
genmap map -I chr21_gm.idx/ -K 50 -E 1 -O chr21_gm_1.out -t
tail -n +2 chr21_gm_1.out.txt |
    tr ' ' '\n' |
    sw -w 10000 > chr21_1.map
genmap map -I chr21r_gm.idx/ -K 50 -E 1 -O chr21r_gm_1.out -t
tail -n +2 chr21r_gm_1.out.txt |
    tr ' ' '\n' |
    sw -w 10000 |
    cut -f 3 |
    sort -n |
    head -n 2004 |
    tail -n 1
merwin -w 10000 -t 1 chr21_1.map | head
merwin -w 10000 -t 1 chr21_1.map > map.txt
wc -l map.txt
awk '{l=$3-$2+1;s+=l}END{print s}' map.txt
while read query start end map; do
    cutSeq -r $start-$end chr21.fna
done < map.txt > map.fasta
grep -c '^>' map.fasta
cres map.fasta
grep '^>' map.fasta |
    awk '{print $1}' |
    sort |
    uniq
awk '/^>/{printf ">m%d\n", ++c}!/^>/{print}' map.fasta > t
mv t map.fasta
grep '^>' map.fasta |
        awk '{print $1}' |
        sort |
        uniq |
        wc -l
makeblastdb -in chr21.fna -out chr21 -dbtype nucl
blastn -query map.fasta -db chr21 -outfmt 6 > map.blast
awk -f ../scripts/sp.awk map.blast
macle -s chr21.fna > chr21_ma.idx
macle -w 10000 chr21_ma.idx > chr21.cm
macle -l chr21_ma.idx
mantile -l 46709983 -g 0.4094 -w 10000 -p 0.025
merwin -w 10000 -t 0.9951 chr21.cm > com.txt
wc -l com.txt
awk '{l=$3-$2+1;s+=l}END{print s}' com.txt
while read query start end cm; do
    cutSeq -r $start-$end chr21.fna
done < com.txt > com.fasta
grep -c '^>' com.fasta
cres com.fasta
awk '/^>/{printf ">c%d\n", ++c}!/^>/{print}' com.fasta > t
mv t com.fasta
blastn -query com.fasta -db chr21 -outfmt 6 > com.blast
awk -f ../scripts/sp.awk com.blast
sed 's/stdin/NC_000021.9/' map.txt > t
mv t map.txt
bedtools intersect -wo -a com.txt -b map.txt > inter.txt
head -n 2 inter.txt
wc -l inter.txt
bedtools intersect -wo -a com.txt -b map.txt |
    awk '{l=$3-$2+1;t+=l;s+=$NF}END{print s, s/t*100}'
echo '357971 / 442000' | bc -l
bedtools intersect -v -a com.txt -b map.txt > lone.txt
cat lone.txt
awk '{l=$3-$2+1;s+=l}END{print s}' lone.txt
bedtools intersect -v -a com.txt -b map.txt |
    while read seq start end cm; do
          cutSeq -r $start-$end chr21.fna
    done > lone.fasta
awk '/^>/{printf ">s%d\n", ++c}!/^>/{print}' lone.fasta > t
mv t lone.fasta
blastn -query lone.fasta -db chr21 -outfmt 6 > lone.blast
awk -f ../scripts/sp.awk lone.blast
sort -n -k 9 -r inter.txt |
    head
awk '$1=="NC_000021.9" && $3=="gene"' hs.gff |
    awk '$4<=36714000 && $5>=36686001'
awk '$2>=36588001 && $2<=36814000 {print $2/1000000, $3, "c"}' \
    chr21.cm > chr21.dat
awk '$2>=36588001 && $2<=36814000 {print $2/1000000, $3, "m"}' \
    chr21_1.map >> chr21.dat
echo "36.588001 1 tm" >> chr21.dat
echo "36.814000 1 tm" >> chr21.dat
echo "36.588001 0.9951 tc" >> chr21.dat
echo "36.814000 0.9951 tc" >> chr21.dat
echo "36.688001 0.65 uc"  >> chr21.dat
echo "36.714000 0.65 uc"  >> chr21.dat
echo "36.686001 0.625 um" >> chr21.dat
echo "36.717000 0.625 um" >> chr21.dat
echo "36.699115 0.6 s" >> chr21.dat
echo "36.749917 0.6 s" >> chr21.dat
plotLine -x "Position (Mb)" -y "Uniqueness" chr21.dat
