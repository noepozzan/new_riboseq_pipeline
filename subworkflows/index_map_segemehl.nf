nextflow.enable.dsl=2

include { SEGEMEHL_INDEX } from '../modules/segemehl_index.nf'
include { SEGEMEHL_MAP } from '../modules/segemehl_map.nf'
include { SAMTOOLS } from '../modules/samtools.nf'

workflow INDEX_MAP_SEGEMEHL {

    take:
    sequence
	reads

    main:

    SEGEMEHL_INDEX( sequence )
	segemehl_index = SEGEMEHL_INDEX.out.segemehl_index

	SEGEMEHL_MAP(
		reads,
		segemehl_index,
		sequence
	)
	mapped_reads_sam = SEGEMEHL_MAP.out.mapped_reads_sam
    unmapped_reads_fasta = SEGEMEHL_MAP.out.unmapped_reads_fasta

	SAMTOOLS(
		mapped_reads_sam
	)
	bam = SAMTOOLS.out.bam
    bai = SAMTOOLS.out.bai
    bam_folder = SAMTOOLS.out.bam_folder

    emit:
    segemehl_index
	mapped_reads_sam
	unmapped_reads_fasta
	bam_folder

}


