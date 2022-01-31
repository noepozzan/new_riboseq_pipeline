process FILTER_FDR {
    
    label "philosopher"
    
    publishDir "results/filterandfdr", mode: 'copy'
    
    input:
    path pepxml
    path protXML
    
    output:
    val 'filterandfdr', emit: filter_fdr
    
    script:
    if( params.skip_proteinprophet == true )
        """
        cd ${params.workspace}
        
        philosopher filter --picked --tag rev_ --pepxml ${pepxml}
        
        """
        
    else if( params.skip_proteinprophet == false )
        """
        cd ${params.workspace}
        
        philosopher filter --psm 0.05 --ion 0.05 --pep 0.05 --prot 1 --sequential --razor --picked --tag rev_ --pepxml interact.pep.xml --protxml interact.prot.xml

        """
        
}

