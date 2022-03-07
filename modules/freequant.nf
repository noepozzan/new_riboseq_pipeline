process FREEQUANT {

    label "philosopher"

    publishDir "${params.philosopher_dir}/freequant", mode: 'copy'

    input:
    val filter_fdr

    output:
    val 'freequant_done_pseudo'

    script:
    """
    cd ${params.workspace}

    # Perform label-free quantification via 
    # precursor (MS1) abundances and spectral counting
    philosopher freequant \
        --dir . \
        2> freequant.out

    """

}

