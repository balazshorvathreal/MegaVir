import glob

# Trimmed, denovo folders
DEDUPED = '/home/ngs_lab/MegaVir/dedup/'
DENOVO = '/home/ngs_lab/MegaVir/denovo/'
MEGAHIT = '/home/ngs_lab/MEGAHIT-1.2.9-Linux-x86_64-static/bin/'

# Get all deduplicated fastq files
DEDUPEDFILES = [file.replace('.fastq', '').replace(DEDUPED, '') for file in glob.glob(DEDUPED + '*fastq')]

# Snakemake rules
rule all:
    input:
        expand(DENOVO + '{sample}', sample=DEDUPEDFILES)

rule denovo:
    input:
        fastq=DEDUPED + '{sample}.fastq'
    output:
        directory(DENOVO + '{sample}')
    shell:
        MEGAHIT + 'megahit -r {input.fastq} -o {output} -t 16 --min-contig-len 200'
