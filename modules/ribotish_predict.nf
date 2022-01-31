process RIBOTISH_PREDICT {

    label "ribotish"
    //label "heavy_computation"

    publishDir "results/ribotish_predict", mode: 'copy'

    input:
    each(path(bam_sort_index_folder))
    path gtf_file
    path genome

    output:
    path '*.ribotish.pred_all.txt', emit: ribo_pred

    script:
    """
    input=\$(basename ${bam_sort_index_folder})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    cp ${bam_sort_index_folder}/* .

    ribotish quality \
        -b \${prefix}.*.bam \
        -g ${gtf_file} \
        --th ${params.ribotish_quality_th}

    ribotish predict \
        -b \${prefix}.*.bam \
        -g ${gtf_file} \
        -f ${genome} \
        ${params.ribotish_predict_mode} \
        -o \${prefix}.ribotish.pred.txt \
        &> \${prefix}_ribotish_predict.log

    fi

    """

}
