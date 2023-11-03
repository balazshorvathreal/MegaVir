import glob

# Trimmed, deduplicated folders
TRIMMED = '/home/ngs_lab/MegaVir/trimmed/'
DEDUPED = '/home/ngs_lab/MegaVir/dedup/'

# Get all fasta files
TRIMMEDFILES = [file.replace('.fa', '').replace(TRIMMED, '') for file in glob.glob(TRIMMED + '*.fa')]

# Snakemake rules
rule all:
    input:
        expand(DEDUPED + '{sample}.fa', sample=TRIMMEDFILES)

rule dedupe:
    input:
        fa=TRIMMED + '{sample}.fa'
    output:
        DEDUPED + '{sample}.fa'
    shell:
        '/home/ngs_lab/bbmap/dedupe.sh in={input.fa} -out={output} ac=f -Xmx64G'