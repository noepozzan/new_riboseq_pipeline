process PROTEINPROPHET {

    label "philosopher"

    publishDir "${params.philosopher_dir}/proteinprophet", mode: 'copy'

    input:
    path pepxml

    output:
    path "interact.prot.xml"

    script:
    if( params.skip_proteinprophet == true )
        """
        workd=\$(pwd)

        cd ${params.workspace}

        touch interact.prot.xml

        cp ${params.workspace}/interact.prot.xml \$workd
        """

    else if( params.skip_proteinprophet == false )
        """
        workd=\$(pwd)

        cd ${params.workspace}

        # group peptides by their corresponding protein(s)
        # to compute probabilities that those proteins were
        # present in in the original sample
        philosopher proteinprophet \
            ${pepxml} \
            2> proteinprophet.out

        cp ${params.workspace}/interact.prot.xml \$workd

        """

}

