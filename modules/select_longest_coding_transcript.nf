process SELECT_LONGEST_CODING_TRANSCRIPT {

    label "htseq"

    publishDir "results/select_longest_coding_transcript", mode: 'copy'

    input:
    path input_gtf
    path select_longest_ct_py

    output:
    path 'longest_coding_transcript_per_gene.gtf', emit: longest_ct

    script:
    """
    python ${select_longest_ct_py} \
        --gtf ${input_gtf} \
        --out longest_coding_transcript_per_gene.gtf \
        2> select_longest_coding_transcript.log

    """

}
