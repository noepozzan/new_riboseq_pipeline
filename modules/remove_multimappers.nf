process REMOVE_MULTIMAPPERS {

    label "pysam"

    publishDir "${params.riboseq_process_data_outDir}/remove_multimappers", mode: 'copy'

    input:
    path transcripts_mapped_sam

    output:
    path '*.transcripts_mapped_unique_sam', emit: unique_sam

    script:
    """
    input=\$(basename ${transcripts_mapped_sam})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    grep -P \"^@|\tNH:i:1\t\" ${transcripts_mapped_sam} \
    	> \${prefix}.transcripts_mapped_unique_sam \
    	2> \${prefix}_remove_multimappers.log

    """

}
