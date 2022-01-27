process WORKSPACE {

    label 'philosopher'

    input:
    path 'riboseq'

    output:
    val 'workspace_init', emit: workspace_init

    script:
    """
    rm -rf ${params.workspace}
    mkdir ${params.workspace}

    mzML_dir=${params.proteomics_reads}
    parentdir_mzML="\$(dirname "\$mzML_dir")"

    mv \${parentdir_mzML}/* ${params.workspace}/

    db_dir=${params.philosopher_db}
    parentdir_db="\$(dirname "\$db_dir")"

    mv ${params.philosopher_db} ${params.workspace}/

    # initialize philosopher workspace in workspace
    cd ${params.workspace}
    philosopher workspace --clean
    philosopher workspace --init

    cp *.mzML \$parentdir_mzML
	cp *.fasta \$parentdir_db
    """

}

