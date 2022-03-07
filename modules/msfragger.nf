process MSFRAGGER {

    label "msfragger"

    publishDir "${params.philosopher_dir}/msfragger/", mode: 'copy'

    input:
    path mzML_file
    path closed_fragger
    path db_file

    output:
    path '*.pepXML'

    script:
    """
    workd=\$(pwd)

    # change to working directory
    cd ${params.workspace}

    # search for matches of the predicted peptides
    # in the peptiomics data
    for VAR in ${mzML_file}
    do

    java -Xmx${params.fragger_ram}g \
        -jar /MSFragger.jar \
        ${closed_fragger} \
        \${VAR}

    done

    cp *.pepXML \$workd

    """

}

