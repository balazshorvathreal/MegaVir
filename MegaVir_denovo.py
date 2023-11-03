import glob

# Trimmed, denovo folders
TRIMMED = '/home/ngs_lab/MegaVir/trimmed/Test1/trimmed/'
DENOVO = '/home/ngs_lab/MegaVir/denovo/'
MEGAHIT = '/home/ngs_lab/MEGAHIT-1.2.9-Linux-x86_64-static/bin/'

# Get all fastq files
TRIMMEDFILES = [file.replace('.fastq.gz', '').replace(TRIMMED, '') for file in glob.glob(TRIMMED + '*.fastq.gz')]

# Snakemake rules
rule all:
    input:
        expand(DENOVO + '{sample}', sample=TRIMMEDFILES)

rule denovo:
    input:
        unpaired=TRIMMED + '{sample}.fastq.gz'
    output:
        directory(DENOVO + '{sample}')
    shell:
        MEGAHIT + 'megahit -r {input.unpaired} -o {output} -t 16 --min-contig-len 400'
