include { TRIM_READS } from '../modules/trim_reads.nf'

workflow READS_TRIMMER {

	take:
	reads

    main:
    TRIM_READS( reads )

    emit:
	trimmed_reads = TRIM_READS.out.trimmed_reads

}
