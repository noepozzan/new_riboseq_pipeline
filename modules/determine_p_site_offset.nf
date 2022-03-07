process DETERMINE_P_SITE_OFFSET {

    label "pysam"

    publishDir "results/determine_p_site_offset", mode: 'copy'

    input:
    each(path(bam_folder))
    path transcript_id_gene_id_CDS
    path script_py

    output:
    path '*.alignment_offset.json', emit: offset

    script:
    """
    workd=\$(pwd)
    input=\$(basename ${bam_folder})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    cp ${bam_folder}/* .

    python ${script_py} \
    	--bam \${prefix}*.bam \
    	--cds_coordinates ${transcript_id_gene_id_CDS} \
    	--outdir \${prefix}_p_site_offset \
    	2> \${prefix}_p_site_offset.log

    cp \${prefix}_p_site_offset/* .
    mv alignment_offset.json \${prefix}.alignment_offset.json

    """

}



