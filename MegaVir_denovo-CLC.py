import glob

# Trimmed, denovo folders
DEDUPED = '/home/ngs_lab/MegaVir/dedup/'
DENOVO = '/home/ngs_lab/MegaVir/denovo/'
MEGAHIT = '/home/ngs_lab/MEGAHIT-1.2.9-Linux-x86_64-static/bin/'

# Get all fasta files
DEDUPEDFILES = [file.replace('.fa', '').replace(DEDUPED, '') for file in glob.glob(DEDUPED + '*.fa')]

# Snakemake rules
rule all:
    input:
        expand(DENOVO + '{sample}', sample=DEDUPEDFILES)

rule denovo:
    input:
        fa=DEDUPED + '{sample}.fa'
    output:
        directory(DENOVO + '{sample}')
    shell:
        MEGAHIT + 'megahit -r {input.fa} -o {output} -t 16 --min-contig-len 400'
