process DATABASE {

    label 'philosopher'

    publishDir "${params.philosopher_dir}/database", mode: 'copy'

    input:
    val workspace
    path db
    
    output:
    path '*.fas'
    
    script:
    """
    workd=\$(pwd)
    
    # same pattern always:
    # change into working directory, execute command,
    # then copy the generated output files back to
    # nextflow directory to allow nextflow to track files
    cd ${params.workspace}
    
    philosopher database \
        --custom ${db} \ 
        --contam 
        
    cp ${params.workspace}/*.fas \$workd
    
    """
    
}

