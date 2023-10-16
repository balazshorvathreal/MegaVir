<h1 class="entry-title" itemprop="headline"> **Introduction** </h1>

MegaVir is a bioinformatic pipeline for virome characterization and genome assembly.

![image](https://github.com/balazshorvathreal/MegaVir/assets/82114449/bb492788-b4b6-4a6a-91d8-fc6565dfc97d)


<h6> **#Manual**

The raw reads obtained from Illumina iSeq100 were quality checked and then trimmed with the CLC Genomics Workbench 22 (Qiagen) and FastQC applications. Poor-quality, ambiguous, and short reads (<50 nucleotides) were discarded during trimming, and PCR primers and Illumina adapters were removed. Next, paired end (PE) reads were merged to enhance quality and reduce data volume. The deduplication step, performed using BBTools, assumed 100% identity and aimed to reduce data volume while enhancing contig length and quality during post de novo assembly. Additionally, deduplication helps in mitigating the bias introduced by PCR artefacts in abundance calculations. For virus detection and virome characterization we used an in-house developed pipeline called MegaVir (v5.1). To minimise the presence of potential false-positive sequences, the metagenomic pipeline incorporated screening of the FASTQ files from the host genome and filtering the rRNA using Ribodetector. 

The pipeline then branches into three paths based on the nature of the analysis employed: 

1. The first path involved direct alignment of reads in amino acid space to the entire NCBI Blast non-redundant protein sequence database (Sayers et al., 2022) using the short-read BLASTx algorithm of Diamond. This approach allows for high sensitivity, down to a single read, and enables the detection of distant homologs by appropriate parameter selection. The method is especially effective for taxonomic classification of viruses and the discovery of novel viral taxa with nucleotide divergence of up to 70%. 

2. The second path employed the metagenome-optimised de novo assembly tool Megahit. The generated contigs (minimum length set to 400 nucleotides) were then classified using Diamond's long-read algorithm. MEGAN6 Community Edition was employed for binning, visualisation, and downstream analysis of results in human-readable formats. Additional manual curation and annotation using CLC Genomics Workbench 22 and Geneious Prime 2023.1 (Dotmatics) as well as CheckV have been implemented to verify the quality and completeness of viral genomes. 

3. The pipeline includes an additional third path which is focused on the analysis of archaeal, bacterial, and eukaryotic metagenome components in the nucleotide space. Contigs generated during de novo assembly were aligned to the full NCBI nucleotide non-redundant database using BLASTn. MEGAN6 served as a front-end interface for further analysis. If a more detailed read-level discovery was required, Kraken2 was employed to obtain a more comprehensive picture of these three major domains.

For abundance calculations, reads were mapped back to taxonomically binned contigs using MEGAN6, and BBMap was chosen for its speed, multithreading capability, and sensitivity. Initially, abundance was recorded as absolute counts, then the reads per contig were normalized.

<h6> **#Dependencies**
