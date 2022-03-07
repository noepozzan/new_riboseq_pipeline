process CLIP_READS {

    label "fastx"

    publishDir "${params.reads_dir}/clip_reads", mode: 'copy'

    input:
    path reads

    output:
    path '*.pro_clipped', emit: clipped_reads

    script:
    """
    input=\$(basename ${reads})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    fastx_clipper \
        ${params.clip_reads_args} \
        -i <(zcat ${reads}) \
        -o \${prefix}.pro_clipped \
        &> \${prefix}_clip_reads.log

    """

}

