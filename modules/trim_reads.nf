process TRIM_READS {

    label "fastx"

    publishDir "results/trim_reads", mode: 'copy'

    input:
    path reads

    output:
    path '*.pro_trimmed', emit: trimmed_reads

    script:
    """
    input=\$(basename ${reads})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    fastq_quality_trimmer \
    ${params.trim_reads_v} \
    -l ${params.trim_reads_l} \
    -t ${params.trim_reads_t} \
    -Q ${params.trim_reads_Q} \
    ${params.trim_reads_z} \
    -i <(zcat ${reads}) \
    -o \${prefix}.pro_trimmed 2> \${prefix}_trim_reads.log

    """

}

