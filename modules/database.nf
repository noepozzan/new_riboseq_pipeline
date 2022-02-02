process DATABASE {

    label 'philosopher'

    publishDir "results/database", mode: 'copy'

    input:
    val workspace
    path db

    output:
    path '*.fas', emit: database

    script:
    """
    workd=\$(pwd)

    cd ${params.workspace}
    philosopher database --custom ${db} #--contam

    cp ${params.workspace}/*.fas \$workd

    """

}
