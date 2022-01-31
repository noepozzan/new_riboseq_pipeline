process FILTER_LENGTH_OFFSET {

    label "pysam"

    publishDir "results/filter_length_offset", mode: 'copy'

    input:
    each(path(bam_folder))
    each(path(p_site_offsets))
    path script_py

    output:
    path '*.transcripts.mapped.unique.a_site_profile.bam', emit: unique, optional: true

    script:
    """
    input1=\$(basename ${bam_folder})
    prefix1=\$(echo \$input1 | cut -d '.' -f 1)
    input2=\$(basename ${p_site_offsets})
    prefix2=\$(echo \$input2 | cut -d '.' -f 1)

    if [ "\$prefix1" == "\$prefix2" ]; then

        cp ${bam_folder}/* .

        python ${script_py} \
			--bam \${prefix1}.transcripts_mapped_unique_sorted_bam \
       	    --p_site_offsets ${p_site_offsets} \
        	--bam_out \${prefix1}.transcripts.mapped.unique.a_site_profile.bam \
            2> \${prefix1}_filter_length_offset.log

    fi

    """

}
