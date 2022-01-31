include { REMOVE_MULTIMAPPERS } from '../modules/remove_multimappers.nf'
include { READ_LENGTH_HISTOGRAM } from '../modules/read_length_histogram.nf'
include { DETERMINE_P_SITE_OFFSET } from '../modules/determine_p_site_offset.nf'
include { COUNT_READS } from '../modules/count_reads.nf'
include { CHECK_PERIODICITY } from '../modules/check_periodicity.nf'
include { FILTER_LENGTH_OFFSET } from '../modules/filter_length_offset.nf'


workflow QC {

	take:
	
	// remove reads that map to multiple loci
	unique_sam

	// histogram of riboseq read length
	histogram_python_script

	// determine p site offset
	bam_folder
	id_CDS
	offset_python_script

	// count reads
	count_reads_python_script
	
	// check periodicity of riboseq reads
	periodicity_python_script

	// filter reads based on read length and offsets
	filter_python_script

	main:
/*
	REMOVE_MULTIMAPPERS(
		sam
	)
	unique_sam = REMOVE_MULTIMAPPERS.out.unique_sam
*/
	
	READ_LENGTH_HISTOGRAM( unique_sam, histogram_python_script )
	
	DETERMINE_P_SITE_OFFSET(
		bam_folder,
		id_CDS,
		offset_python_script
	)
	offsets = DETERMINE_P_SITE_OFFSET.out.offset

	COUNT_READS(
		bam_folder,
		id_CDS,
		offsets,
		count_reads_python_script
	)
	
	CHECK_PERIODICITY(
		bam_folder,
		id_CDS,
		offsets,
		periodicity_python_script
	)

	FILTER_LENGTH_OFFSET(
		bam_folder,
		offsets,
		filter_python_script
	)
	unique_a_site = FILTER_LENGTH_OFFSET.out.unique	

	emit:
	unique_a_site	

}
