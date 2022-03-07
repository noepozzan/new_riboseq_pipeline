process GENERATE_CHANGE_PARAMS {

    label 'msfragger'
    
    publishDir "${params.philosopher_dir}/generate_change_params", mode: 'copy'
    
    input:
    path db
    path change_file_script
    
    output:
    path 'msfragger.params'
    
    script:
    """
    # generate MSFRAGGER parameter file
    java -jar /MSFragger.jar --config closed
    
    # python script to change some parameters
    python ${change_file_script} \
        --database ${db} \
        --param closed_fragger.params \
        --out msfragger.params \
        &> generate_change_params.log
        
    # copy params file to the working directory
    # since this process took place in some subdirectory
    cp msfragger.params ${params.workspace}
    
    """
    
}
