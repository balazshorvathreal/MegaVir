snakemake -s MegaVir_trim.py -c16

#Combine PE and orphan readsets
cd /home/ngs_lab/MegaVir/trimmed/Test1/trimmed
ls | awk -F '_S' '!x[$1]++{print $1}' | while read -r line
do
    cat $line* > $line-combined\.fastq.gz
done
rm logs-combined.fastq.gz

snakemake -s /home/ngs_lab/MegaVir/MegaVir_denovo.py -c16

#Rename Megahit outputs
cd /home/ngs_lab/MegaVir/denovo/
for subdir in *; do mv $subdir/final.contigs.fa $subdir.fa; done;

snakemake -s /home/ngs_lab/MegaVir/MegaVir_diamond-CLC-LR.py -c16
/home/ngs_lab/megan/tools/daa-meganizer -i /home/ngs_lab/MegaVir/daa/*.daa -lg -top 0.1 -supp 0.000000001 -lcp 51 -ram readCount -mdb /home/ngs_lab/DB/megan-map-Feb2022-ue.db -t 16 -v
