import glob

# Trimmed, deduplicated folders
TRIMMED = '/home/ngs_lab/MegaVir/trimmed/Iseq_run/trimmed/'
DEDUPED = '/home/ngs_lab/MegaVir/dedup/'

# Get all combined fastq files
TRIMMEDFILES = [file.replace('.gz', '').replace(TRIMMED, '') for file in glob.glob(TRIMMED + '*combined.fastq.gz')]

# Snakemake rules
rule all:
    input:
        expand(DEDUPED + '{sample}', sample=TRIMMEDFILES)
rule dedupe:
    input:
        fastq=TRIMMED + '{sample}.fastq.gz'
    output:
        DEDUPED + '{sample}.fastq'
    shell:
        '/home/ngs_lab/bbmap/dedupe.sh in={input.fastq} -out={output} ac=f -Xmx64G'


