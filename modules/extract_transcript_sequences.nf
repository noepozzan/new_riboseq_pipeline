process EXTRACT_TRANSCRIPT_SEQUENCES {

    label "cufflinks"

    publishDir "${params.riboseq_annotate_outDir}/extract_transcript_sequences", mode: 'copy'

    input:
    path gtf
    path genome

    output:
    path 'transcript_sequences.out', emit: transcript_sequences

    script:
    """
    gffread \
        ${gtf} \
        -g ${genome} \
        -w transcript_sequences.out \
        2> extract_transcript_sequences.log

    """

}
