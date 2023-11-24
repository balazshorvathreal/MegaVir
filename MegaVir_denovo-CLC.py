import glob

# Trimmed, denovo folders
DEDUPED = '/home/ngs_lab/MegaVir/dedup/'
DENOVO = '/home/ngs_lab/MegaVir/denovo/'

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
        'megahit -r {input.fa} -o {output} -t 32 --min-contig-len 200'
