process RIBOTISH_PREDICT {

    echo true

    label "ribotish"
    label "heavy_computation"

    publishDir "${params.ribotish_dir}/ribotish_predict", mode: 'copy'

    input:
    each(path(bam_folder_offsets))
    path gtf
    path genome

    output:
    path '*.ribotish_pred_all.txt', emit: ribo_pred, optional: true

    script:
    if( params.riboseq_mode == "regular" )
    """
    input=\$(basename ${bam_folder_offsets[0]})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    cp ${bam_folder_offsets[0]}/* .

    ribotish predict \
        -b *.bam \
        -g ${gtf} \
        -f ${genome} \
        --ribopara ${bam_folder_offsets[1]} \
        ${params.ribotish_predict_mode} \
        -o \${prefix}.ribotish_pred.txt \
        &> \${prefix}_ribotish_predict.log

    """
    else if( params.riboseq_mode == "TI" )
    """
    input=\$(basename ${bam_folder_offsets[0]})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    cp ${bam_folder_offsets[0]}/* .

    ribotish predict \
        -t *.bam \
        -g ${gtf} \
        -f ${genome} \
        --ribopara ${bam_folder_offsets[1]} \
        ${params.ribotish_predict_mode} \
        -o \${prefix}.ribotish_pred.txt \
        &> \${prefix}_ribotish_predict.log

    """

}

