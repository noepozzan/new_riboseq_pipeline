process REPORT {

    label "philosopher"

    echo true

    publishDir "${params.philosopher_dir}/report", mode: 'copy'

    input:
    val freequant

    output:
    path '*'

    script:
    """
    workd=\$(pwd)

    cd ${params.workspace}

    # reports about the findings for easy interpretation
    philosopher report \
        --msstats \
        --decoys \
        2> report.out

    cp msstats.csv peptide.tsv psm.tsv ion.tsv  \$workd
    """

}

