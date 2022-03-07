process FILTER_LENGTHS_OFFSETS {

    label "pysam"

    publishDir "${params.qc_dir}/filter_lengths_offsets", mode: 'copy'

    input:
    each(path(bam_folder_offsets))
    path script_py

    output:
    path '*.unique_a_site.bam'

    script:
    """
    workd=\$(pwd)
    input=\$(basename ${bam_folder_offsets[0]})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    cp ${bam_folder_offsets[0]}/* .

    python ${script_py} \
        --bam *.bam \
        --p_site_offsets ${bam_folder_offsets[1]} \
        --bam_out \${prefix}.unique_a_site.bam \
        2> \${prefix}_filter_lengths_offsets.log

    """

}

