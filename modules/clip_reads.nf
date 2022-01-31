process CLIP_READS {
    
    label "fastx"
    
    publishDir "results/clip_reads", mode: 'copy'
    
    input:
    path reads
    
    output:
    path '*.pro_clipped', emit: clipped_reads
    
    script:
    """
    input=\$(basename ${reads})
    prefix=\$(echo \$input | cut -d '.' -f 1)
    
    fastx_clipper \
    ${params.clip_reads_v} \
    ${params.clip_reads_n} \
    -l ${params.clip_reads_l} \
    ${params.clip_reads_c} \
    ${params.clip_reads_z} \
    -a ${params.clip_reads_adapter} \
    -i <(zcat ${reads}) \
    -o \${prefix}.pro_clipped \
    &> \${prefix}_clip_reads.log
    
    """
    
}
