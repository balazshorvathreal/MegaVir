<h1 class="entry-title" itemprop="headline"> Introduction </h1>

MegaVir is a bioinformatic pipeline for virome characterization and genome assembly.

![image](https://github.com/balazshorvathreal/MegaVir/assets/82114449/8f5690c1-8315-4ea6-93eb-9246db7d7a85)

<h1 class="entry-title" itemprop="headline"> Workflow </h1>

The raw reads obtained from Illumina NGS systems were quality-checked and then trimmed with the CLC Genomics Workbench 22 (Qiagen) and FastQC applications. Poor-quality, ambiguous, and short reads (<50 nucleotides) were discarded during trimming, and PCR primers and Illumina adapters were removed. Next, paired-end (PE) reads were merged to enhance quality and reduce data volume. The deduplication step, performed using BBTools, assumed 100% identity and aimed to reduce data volume while enhancing contig length and quality during post de novo assembly. Additionally, deduplication helps in mitigating the bias introduced by PCR artefacts in abundance calculations. To minimize the presence of potential false-positive sequences, the metagenomic pipeline incorporated screening of the FASTQ files from the host genome and filtering the rRNA using Ribodetector. 

The pipeline then branches into three paths based on the nature of the analysis employed: 

1. The first path involved direct alignment of reads in amino acid space to the entire NCBI Blast non-redundant protein sequence database using the short-read BLASTx algorithm of Diamond. This approach allows for high sensitivity, down to a single read, and enables the detection of distant homologs by appropriate parameter selection. The method is especially effective for taxonomic classification of viruses and the discovery of novel viral taxa with nucleotide divergence of up to 70%. 

2. The second path employed the metagenome-optimized _de novo_ assembly tool Megahit. The generated contigs (minimum length set to 400 nucleotides) were then classified using Diamond's long-read algorithm. MEGAN6 Community Edition was employed for binning, visualization, and downstream analysis of results in human-readable formats. Additional manual curation and annotation using CLC Genomics Workbench 22 and Geneious Prime 2023.1 (Dotmatics) as well as CheckV have been implemented to verify the quality and completeness of viral genomes. 

3. The pipeline includes an additional third path which is focused on the analysis of archaeal, bacterial, and eukaryotic metagenome components in the nucleotide space. Contigs generated during de novo assembly were aligned to the full NCBI nucleotide non-redundant database using BLASTn. MEGAN6 served as a front-end interface for further analysis. If a more detailed read-level discovery was required, Kraken2 was employed to obtain a more comprehensive picture of these three major domains.

For abundance calculations, reads were mapped back to taxonomically binned contigs using MEGAN6, and BBMap was chosen for its speed, multithreading capability, and sensitivity. Initially, abundance was recorded as absolute counts, then the reads per contig were normalized.

<h1 class="entry-title" itemprop="headline"> Dependencies </h1>
<ul dir="auto">
<li><a href="https://snakemake.github.io/">Snakemake</a></li>
<li><a href="https://github.com/s-andrews/FastQC">FastQC </a></li>
<li><a href="https://multiqc.info/">MultiQC</a></li> 
<li><a href="https://sourceforge.net/projects/bbmap">BBMap</a></li>
<li><a href="https://anaconda.org/bioconda/trimmomatic">Trimmomatic (conda install -c bioconda trimmomatic)</a></li>  
<li><a href="https://github.com/hzi-bifo/RiboDetector">Ribodetector</a></li>
<li><a href="https://github.com/voutcn/megahit">Megahit</a></li>
<li><a href="https://github.com/bbuchfink/diamond">DIAMOND</a></li>
<li><a href="https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST">BLAST</a></li> 
<li><a href="https://ftp.ncbi.nlm.nih.gov/blast/db">BLAST Databases</a></li> 
<li><a href="https://github.com/husonlab/megan-ce">Megan CE</a></li>
<li><a href=https://digitalinsights.qiagen.com/products-overview/discovery-insights-portfolio/analysis-and-visualization/qiagen-clc-genomics-workbench">CLC Genomics Workbench</a></li>
<li><a href="https://www.geneious.com/download/">Geneious Prime</a></li>
</ul>
