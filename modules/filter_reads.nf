process FILTER_READS {

    label "fastx"

    publishDir "results/filter_reads", mode: 'copy'

    input:
    path reads

    output:
    path '*.pro_filtered', emit: filtered_reads

    script:
    """
    input=\$(basename ${reads})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    fastq_quality_filter \
    ${params.filter_reads_v} \
    -q ${params.filter_reads_q} \
    -p ${params.filter_reads_p} \
    -Q ${params.filter_reads_Q} \
    ${params.filter_reads_z} \
    -i <(zcat ${reads}) \
    -o \${prefix}.pro_filtered 2> \${prefix}_filter_reads.log

    """

}
