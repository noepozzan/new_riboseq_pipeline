process SEGEMEHL_MAP {

    label "segemehl"
    label "heavy_computation"

    publishDir "results/segemehl_map", mode: 'copy'

    input:
    each(path(reads))
    path index
    path sequence

    output:
    path '*.mapped_sam', emit: mapped_reads_sam
    path '*.unmapped_fa', emit: unmapped_reads_fasta

    script:
    """
    input=\$(basename ${reads})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    segemehl.x \
    	-i ${index} \
    	-d ${sequence} \
    	-q ${reads} \
    	${params.segemehl_args} \
		-o \${prefix}.mapped_sam \
    	-u \${prefix}.unmapped_fa \
		2> \${prefix}_segemehl_map.log
    
	"""

}
