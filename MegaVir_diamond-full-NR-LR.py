import glob

# Denovo output and diamond files
MEGAHITOUT = '/home/ngs_lab/MegaVir/denovo/'
DAAFOLDER = '/home/ngs_lab/MegaVir/daa/'

# Get all fasta files
FASTAFILES = [file.replace('fa','').replace(MEGAHITOUT, '') for file in glob.glob(MEGAHITOUT + '*.fa')]

# Snakemake rules
rule all:
    input:
        expand(DAAFOLDER + '{sample}daa', sample=FASTAFILES)

rule align:
    input:
        fasta=MEGAHITOUT + '{sample}fa'
    output:
        DAAFOLDER + '{sample}daa'
    shell:
        '/home/ngs_lab/diamond/diamond blastx -q {input.fasta} -d /home/ngs_lab/diamond/NR_202306-taxmap.dmnd -o {output} -p 32 --long-reads -f 100'
