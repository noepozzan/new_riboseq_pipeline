process GENERATE_CHANGE_PARAMS {

    label 'msfragger'

    publishDir "${params.philosopher_outDir}/generate_change_params", mode: 'copy'

    input:
    path db
    path change_file_script

    output:
    path 'closed_fragger.params', emit: params

    script:
    """
    java -jar /MSFragger.jar --config

    python ${change_file_script} ${db} closed_fragger.params

    cp closed_fragger.params ${params.workspace}

    """

}
