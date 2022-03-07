process WORKSPACE {

    label 'philosopher'

    input:
    path ribotish_speptide

    output:
    val 'tubel'

    script:
    """
    # create new working directory (remove old if applicable,
    # to be sure that there is a fresh new workspace)
    rm -rf ${params.workspace}
    mkdir ${params.workspace}

    # move input files to working directory

    for VAR in ${params.proteomics_reads}
    do
        mv \$VAR ${params.workspace}/
    done

    # move the predicted sPeptides file to the workspace
    mv ${ribotish_speptide} ${params.workspace}/

    # initialize philosopher in the philosopher
    # working directory which is called workspace
    cd ${params.workspace}
    philosopher workspace --clean
    philosopher workspace --init

    # copy input files back to data folder as a backup
    dir=${params.proteomics_reads}
    parentdir="\$(dirname "\$dir")"
    cp *.mzML \$parentdir

    """

}

