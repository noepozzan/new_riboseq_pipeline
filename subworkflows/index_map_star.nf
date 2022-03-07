nextflow.enable.dsl=2

include { STAR_INDEX } from '../modules/star_index.nf'
include { STAR_MAP } from '../modules/star_map.nf'
include { SAMTOOLS } from '../modules/samtools.nf'

workflow INDEX_MAP_STAR {

    take:
    sequence
	reads
	gtf

    main:
    
	STAR_INDEX(
		sequence
	)
	star_index = STAR_INDEX.out.star_index	
	
	STAR_MAP(
		reads,
		star_index,
		gtf
	)
	mapped_reads_sam = STAR_MAP.out.mapped_reads_sam
    unmapped_reads_fastx = STAR_MAP.out.unmapped_reads_fastx

	SAMTOOLS(
		mapped_reads_sam
	)
	bam = SAMTOOLS.out.bam
    bai = SAMTOOLS.out.bai
    bam_folder = SAMTOOLS.out.bam_folder

    emit:
	star_index
	mapped_reads_sam
    unmapped_reads_fastx
	bam_folder

}



