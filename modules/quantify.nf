process QUANTIFY {

    label "philosopher"

    publishDir "results/quantify", mode: 'copy'

    input:
    val filterandfdr

    output:
    val 'freequant', emit: quant

    script:
    """
    cd ${params.workspace}
    philosopher freequant --dir . 2> freequant.out

    """

}
