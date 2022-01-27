process SEGEMEHL_INDEX {

    label "segemehl"

    publishDir "${params.riboseq_annotate_outDir}/segemehl_index", mode: 'copy'

    input:
    path sequence

    output:
    path 'segemehl_index', emit: segemehl_index

    script:
    """
    segemehl.x \
        -x segemehl_index \
        -d ${sequence} \
        2> segemehl_index.log

    """

}
