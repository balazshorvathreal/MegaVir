snakemake -s MegaVir_dedupe.py -c16
snakemake -s MegaVir_denovo.py -c16
cd /home/ngs_lab/MegaVir/denovo/
for subdir in *; do mv $subdir/final.contigs.fa $subdir.fa; done;
cd ..
snakemake -s MegaVir_diamond-LR.py -c16
/home/ngs_lab/megan/tools/daa-meganizer -i /home/ngs_lab/MegaVir/daa/*.daa -lg -top 0.1 -supp 0.000000001 -lcp 51 -ram readCount -mdb /home/ngs_lab/DB/megan-map-Feb2022-ue.db -t 16 -v