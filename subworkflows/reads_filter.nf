include { FILTER_READS } from '../modules/filter_reads.nf'

workflow READS_FILTER {

	take:
	reads

    main:
    FILTER_READS( reads )

    emit:
	filtered_reads = FILTER_READS.out.filtered_reads

}
