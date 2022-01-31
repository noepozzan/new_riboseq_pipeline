process PEPTIDEPROPHET {

    label "philosopher"

    publishDir "results/peptideprophet", mode: 'copy'

    input:
    path db
    path pepXML
    
    output:
    path "*interact.pep.xml", emit: interact_pep_xml
    
    script:
    """
    workd=\$(pwd)
    
    cd ${params.workspace}
    
    philosopher peptideprophet \
    --combine --database ${db} \
    --decoy rev_ --ppm --accmass \
    --expectscore --decoyprobs \ 
    --nonparam ${pepXML} \
    2> peptideprophet.out
    
    cp ${params.workspace}/interact.pep.xml \$workd
    
    """
    
}
