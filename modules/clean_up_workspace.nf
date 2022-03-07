process CLEAN_UP_WORKSPACE {

    label "philosopher"

    input:
    path report

    script:
    """

    cd ${params.workspace}
    cd ..
    rm -rf ${params.workspace}

    """

}

