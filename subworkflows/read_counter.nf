include { COUNT_READS } from '../modules/count_reads.nf'

workflow READ_COUNTER {

	take:
	bam_folder
	id_CDS
	offsets
	python_script

    main:
    COUNT_READS( bam_folder, id_CDS, offsets, python_script )

    emit:
	counts = COUNT_READS.out.counts

}
