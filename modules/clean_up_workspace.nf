process CLEAN_UP_WORKSPACE {

    echo true

    label "philosopher"

    input:
    path report

    script:
    """

    cd ${params.workspace}
    cd ..
    rm -rf ${params.workspace}

    : '
    cd ${params.workspace}

    cd ..
    ln workspace/simple_data_analysis.nf ./
    rm -rf workspace
    mkdir -p workspace
    mv simple_data_analysis.nf workspace/
    '
    """

}
