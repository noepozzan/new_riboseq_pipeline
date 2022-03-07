process TRIM_READS {

    //errorStrategy { sleep(Math.pow(2, task.attempt) * 200 as long); return 'retry' }
    //maxRetries 5

    label "fastx"

    publishDir "${params.reads_dir}/trim_reads", mode: 'copy'

    input:
    path reads

    output:
    path '*.pro_trimmed', emit: trimmed_reads

    script:
    """
    input=\$(basename ${reads})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    fastq_quality_trimmer \
        ${params.trim_reads_args} \
        -i <(zcat ${reads}) \
        -o \${prefix}.pro_trimmed \
        &> \${prefix}_trim_reads.log

    """

}
