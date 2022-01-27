process QUANTIFY {

    label "philosopher"

    publishDir "${params.philosopher_outDir}/quantify", mode: 'copy'

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
