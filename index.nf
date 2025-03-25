#! /usr/bin/env nextflow

nextflow.enable.dsl=2

params.reads = "$projectDir/data/sequences/SRR29867405_{1,2}.fastq"
params.genref = "$projectDir/data/reference/GCF_000001405.40_GRCh38.p14_genomic.fna"
params.multiqc = "$projectDir/multiqc"
params.outdir = "./results"

log.info """\
    Variant Calling Pipeline
    ===================================
    reference: ${params.genref}
    reads        : ${params.reads}
    outdir       : ${params.outdir} 
    """
    .stripIndent(true)

   process INDEX {
    container 'quay.io/biocontainers/bwa:0.7.18--h577a1d6_2'

    input:
    path reference

    output:
    path 'bwa_index'

    script:
    """
    bwa index -p bwa_index $reference
    """
}

workflow {
    index_ch = Channel.of(params.genref)
    INDEX(index_ch)
}
