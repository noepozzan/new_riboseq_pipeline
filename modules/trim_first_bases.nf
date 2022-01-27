process TRIM_FIRST_BASES {

    label "cutadapt"

    publishDir "${params.riboseq_process_data_outDir}/trim_first_bases", mode: 'copy'

    input:
    path reads

    output:
    path '*.trimmed_first_bases', emit: trimmed_first_bases

    script:
    """
    input=\$(basename ${reads})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    (cutadapt \
    --cut ${params.cut} \
    --minimum-length ${params.minimum_length} \
    ${reads} | gzip > \
    \${prefix}.trimmed_first_bases) \
    &> \${prefix}_trim_first_bases.log

    """

}
