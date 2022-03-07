process GFFREAD {

    label "gffread"

    publishDir "${params.ribotish_dir}/gffread", mode: 'copy'

    input:
    path genome
    path genome_fai
    path gtf

    output:
    path 'transcripts.fa', emit: fasta

    script:
    """

    gffread \
        -w transcripts.fa \
        -g ${genome} \
        ${gtf}

    """

}

