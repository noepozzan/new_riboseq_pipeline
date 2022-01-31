process RIBOTISH_QUALITY {

    label "ribotish"

    publishDir "results/ribotish_quality", mode: 'copy'

    input:
    each(path(bam_sort_index_folder))
    path gtf_file

    output:
    path '*.para.py', emit: offset
    path '*.pdf', emit: ribo_pdf
    path '*.txt', emit: ribo_txt

    script:
    """
    input=\$(basename ${bam_sort_index_folder})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    cp ${bam_sort_index_folder}/* .

    ribotish quality \
        -b \${prefix}.*.bam \
        -g ${gtf_file} \
        --th ${params.ribotish_quality_th}
    """

}
