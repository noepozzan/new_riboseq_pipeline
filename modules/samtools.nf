process SAMTOOLS {

    label "samtools"

    publishDir "${params.riboseq_process_data_outDir}/samtools", mode: 'copy'

    input:
    path sam

    output:
    path '*.bam', emit: bam
	path '*.bam.bai', emit: bai
    path '*.folder*', emit: bam_folder

    script:
    if ( params.sort_bam == false )
	"""
    input=\$(basename ${sam})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    samtools view -b ${sam} -o \${prefix}.bam
   	
	samtools index \${prefix}.bam
	mkdir \${prefix}.folder_bam
    cp \${prefix}.bam* \${prefix}.folder_bam

    """
	elif ( params.sort_bam == true )
	"""
	input=\$(basename ${sam})
    prefix=\$(echo \$input | cut -d '.' -f 1)

	samtools view -b ${sam} -o \${prefix}.bam 

	samtools sort -o \${prefix}.sorted.bam \${prefix}.bam

	samtools index \${prefix}.sorted.bam
    mkdir \${prefix}.folder_sorted_bam
    cp \${prefix}.sorted.bam* \${prefix}.folder_sorted_bam
	"""

}
