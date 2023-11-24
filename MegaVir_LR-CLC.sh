#BBDUK deduplication
snakemake -s MegaVir_dedupe-CLC.py -c1

#Megahit de novo assembly
snakemake -s MegaVir_denovo-CLC.py -c2

#Rename Megahit outputs
cd /home/ngs_lab/MegaVir/denovo/
for subdir in *; do mv $subdir/final.contigs.fa $subdir.fa; done;
cd ..

#Binning Megahit outputs with diamond LR
snakemake -s MegaVir_diamond-LR.py -c2

#Meganize LR
/home/ngs_lab/meganCE/tools/daa-meganizer -i /home/ngs_lab/MegaVir/daa/*.daa -lg -top 0.1 -supp 0.000000001 -lcp 51 -ram readCount -mdb /home/ngs_lab/DB/Megan/megan-map-Feb2022.db -t 16 -v
