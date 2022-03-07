nextflow.enable.dsl=2

include { READ_LENGTH_HISTOGRAM } from '../modules/read_length_histogram.nf'
include { DETERMINE_P_SITE_OFFSET } from '../modules/determine_p_site_offset.nf'
include { COUNT_READS } from '../modules/count_reads.nf'
include { CHECK_PERIODICITY } from '../modules/check_periodicity.nf'
include { FILTER_LENGTHS_OFFSETS } from '../modules/filter_length_offset.nf'


workflow QC {

	take:
	unique_sam
	bam_folder
	id_CDS

	main:
	
	READ_LENGTH_HISTOGRAM(
		unique_sam,
		params.histogram_script
	)
	
	DETERMINE_P_SITE_OFFSET(
		bam_folder,
		id_CDS,
		params.offsets_script
	)
	offsets = DETERMINE_P_SITE_OFFSET.out.offset

	// pair outputs to feed matching files into downstream processes
	bam_folder
        .combine(offsets)
        .filter{ it[0].baseName.split("\\.")[0] == it[1].baseName.split("\\.")[0] }
        .set{ bam_folder_offsets }

	COUNT_READS(
		bam_folder_offsets,
		id_CDS,
		params.count_reads_script
	)
	
	CHECK_PERIODICITY(
		bam_folder_offsets,
		id_CDS,
		params.check_periodicity_script
	)

	FILTER_LENGTHS_OFFSETS(
		bam_folder_offsets,
		params.filter_lengths_reads_script
	)
	unique_a_site = FILTER_LENGTHS_OFFSETS.out	

	emit:
	unique_a_site	

}
