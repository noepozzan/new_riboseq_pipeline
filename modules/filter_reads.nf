process FILTER_READS {

    label "fastx"

    publishDir "${params.reads_dir}/filter_reads", mode: 'copy'

    input:
    path reads

    output:
    path '*.pro_filtered', emit: filtered_reads

    script:
    """
    input=\$(basename ${reads})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    fastq_quality_filter \
        ${params.filter_reads_args} \
        -i <(zcat ${reads}) \
        -o \${prefix}.pro_filtered \
        &> \${prefix}_filter_reads.log

    """

}

