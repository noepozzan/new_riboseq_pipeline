include { TRIM_FIRST_BASES } from '../modules/trim_first_bases.nf'
include { CLIP_READS } from '../modules/clip_reads.nf'
include { TRIM_READS } from '../modules/trim_reads.nf'
include { FILTER_READS } from '../modules/filter_reads.nf'
include { FASTQ_TO_FASTA } from '../modules/fastq_to_fasta.nf'

workflow PREPARE_READS {

    take:
    reads

    main:
    TRIM_FIRST_BASES( reads )

	trimmed_first_bases = TRIM_FIRST_BASES.out.trimmed_first_bases
	
	CLIP_READS( trimmed_first_bases )

	clipped_reads = CLIP_READS.out.clipped_reads

	TRIM_READS( clipped_reads )

	trimmed_reads = TRIM_READS.out.trimmed_reads

	FILTER_READS( trimmed_reads )

	filtered_reads = FILTER_READS.out.filtered_reads

	FASTQ_TO_FASTA( filtered_reads )

	fasta_reads = FASTQ_TO_FASTA.out.fasta_reads	

    emit:
    trimmed_first_bases
	clipped_reads
	trimmed_reads
	filtered_reads
	fasta_reads

}




