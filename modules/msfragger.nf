process MSFRAGGER {

    label "msfragger"

    publishDir "results/msfragger/", mode: 'copy'

    input:
    path mzML_file
    path closed_fragger
    path db_file

    output:
    path '*.pepXML', emit: pepXML

    script:
    """
    workd=\$(pwd)

    cd ${params.workspace}

    for VAR in ${mzML_file}
    do

    java -Xmx${params.fragger_ram}g \
        -jar /MSFragger.jar \
        ${closed_fragger} \${VAR}

    done

    cp *.pepXML \$workd

    """

}

