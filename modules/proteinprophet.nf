process PROTEINPROPHET {
    
    label "philosopher"
    
    publishDir "results/proteinprophet", mode: 'copy'
       
    input:
    path pepxml
    
    output:
    path "*.prot.xml", emit: prot_xml
     
    script:
    if( params.skip_proteinprophet == true )
        """
        touch interact.prot.xml
        
        """
        
    else if( params.skip_proteinprophet == false )
        """
        workd=\$(pwd)
        
        cd ${params.workspace}
        philosopher proteinprophet ${pepxml} 2> proteinprophet.out
        
        cp ${params.workspace}/interact.prot.xml \$workd
        
        """
        
}
