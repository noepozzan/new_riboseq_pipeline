process PEPTIDEPROPHET {

    label "philosopher"

    publishDir "${params.philosopher_dir}/peptideprophet", mode: 'copy'

    input:
    path db
    path pepXML

    output:
    path "interact*.pep.xml"

    script:
    """
    workd=\$(pwd)

    cd ${params.workspace}

    # peptide assignment validation
    philosopher peptideprophet \
        ${params.peptideprophet_args} \
        --database ${db} \
        ${pepXML}

    cp ${params.workspace}/interact*.pep.xml \$workd

    """

}

