process REPORT {

    label "philosopher"

    publishDir "${params.philosopher_outDir}/report", mode: 'copy'

    input:
    val freequant

    output:
    path 'msstats.csv', emit: msstats

    script:
    """
    workd=\$(pwd)

    cd ${params.workspace}
    philosopher report --msstats 2> report.out

    cp msstats.csv \$workd
    """

}
