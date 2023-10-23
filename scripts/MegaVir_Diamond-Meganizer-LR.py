import glob

# Databases and mapping files
FASTAINFOLDER = '/home/ngs_lab/MegaVir/fasta/'
DAAFOLDER = '/home/ngs_lab/MegaVir/daa/'

# Get all fasta files
FASTAFILES = [file.replace('.fasta', '').replace(FASTAINFOLDER, '') for file in glob.glob(FASTAINFOLDER + '/*.fasta')]

# Snakemake rules
rule all:
    input:
        expand(DAAFOLDER + '{sample}.daa', sample=FASTAFILES)

rule align:
    input:
        fasta=FASTAINFOLDER + '{sample}.fasta',
    output:
        DAAFOLDER + '{sample}.daa'
    shell:
        '/home/ngs_lab/diamond/diamond blastx -q {input.fasta} -d /home/ngs_lab/diamond/nr_virus.dmnd -o {output} -p 16 -long-reads -f 100'

rule MEGANIZER:
    input:
        daa=DAAFOLDER + '{sample}.daa',
    output:
        DAAFOLDER + '{sample}.daa'
    shell:
        '/home/ngs_lab/megan/tools/daa-meganizer -i {input.daa} -lg -top 0.1 -supp 0.000000001 -lcp 51 -ram readCount -mdb /home/ngs_lab/DB/megan-map-Feb2022-ue.db -t 16 -v'
