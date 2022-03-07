process FASTQ_TO_FASTA {

    label "fastx"

    publishDir "${params.reads_dir}/fastq_to_fasta", mode: 'copy'

    input:
    path reads

    output:
    path '*.pro_filtered_fasta', emit: fasta_reads

    script:
    """
    input=\$(basename ${reads})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    fastq_to_fasta \
        ${params.fastq_to_fasta_args} \
        -i <(zcat ${reads}) \
        -o \${prefix}.pro_filtered_fasta \
        &> \${prefix}_fastq_to_fasta.log

    """

}

