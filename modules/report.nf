process REPORT {

    label "philosopher"

    publishDir "results/report", mode: 'copy'

    input:
    val freequant

    output:
    path 'msstats.csv', emit: msstats

    script:
    """
    workd=\$(pwd)

    cd ${params.workspace}
    philosopher report --msstats 2> report.out

	cp msstats.csv peptide.tsv psm.tsv ion.tsv  \$workd
    """

}
