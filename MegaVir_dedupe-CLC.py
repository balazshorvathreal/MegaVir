import glob

# Trimmed, deduplicated folders
TRIMMED = '/home/ngs_lab/MegaVir/CLC_trimmed/'
DEDUPED = '/home/ngs_lab/MegaVir/dedup/'

# Get all combined fasta files
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
        '/media/ngs_lab/6.4Tb-NVRAM/bbmap/dedupe.sh in={input.fa} -out={output} ac=f -Xmx64G'
