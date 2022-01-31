process REMOVE_MULTIMAPPERS {

    label "pysam"

    publishDir "${params.riboseq_process_data_outDir}/remove_multimappers", mode: 'copy'

    input:
    path mapped_sam

    output:
    path '*.mapped_unique_sam', emit: unique_sam

    script:
    """
    input=\$(basename ${mapped_sam})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    grep -P \"^@|\tNH:i:1\t\" ${mapped_sam} \
    	> \${prefix}.mapped_unique_sam \
    	2> \${prefix}_remove_multimappers.log

    """

}
