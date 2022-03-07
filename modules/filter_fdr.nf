process FILTER_FDR {

    label "philosopher"

    echo true

    publishDir "${params.philosopher_dir}/filter_fdr", mode: 'copy'

    input:
    path pepxml
    path protxml

    output:
    val "filtering_done_pseudo"

    script:
    if( params.skip_proteinprophet == true )
        """
        cd ${params.workspace}

        philosopher filter \
            ${params.philosopher_filter_args} \
            --pepxml ${pepxml}

        """
    else if( params.skip_proteinprophet == false && params.combine_peptideprophet == true )
        """
        cd ${params.workspace}

        philosopher filter \
            ${params.philosopher_filter_args} \
            --pepxml ${pepxml} \
            --protxml ${protxml}

        """
    else if( params.skip_proteinprophet == false && params.combine_peptideprophet == false )
        """
        cd ${params.workspace}

        # filter matches and estimate FDR
        # skip the --sequential parameter
        philosopher filter \
            --psm 0.05 \
            --ion 0.05 \
            --pep 0.05 \
            --prot 1 \
            --razor \
            --picked \
            --tag rev_ \
            --pepxml interact-0*.pep.xml \
            --protxml interact.prot.xml

        """

}

