process SEGEMEHL_INDEX {

    label "segemehl"

    publishDir "results/segemehl_index", mode: 'copy'

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
