process FASTQ_TO_FASTA {

    label "fastx"

    publishDir "${params.riboseq_process_data_outDir}/fastq_to_fasta", mode: 'copy'

    input:
    path reads

    output:
    path '*.pro_filtered_fasta', emit: fasta_reads

    script:
    """
    input=\$(basename ${reads})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    fastq_to_fasta \
    ${params.fq_to_fa_v} \
    ${params.fq_to_fa_n} \
    ${params.fq_to_fa_r} \
    -i <(zcat ${reads}) \
    -o \${prefix}.pro_filtered_fasta \
	2> \${prefix}_fastq_to_fasta.log

    """

}

