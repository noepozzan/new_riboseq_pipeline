include { COUNT_OLIGOS } from '../modules/count_oligos.nf'

workflow OLIGO_COUNTER {

	take:
	reads
	oligos
	python_script

    main:
    COUNT_OLIGOS( reads, oligos, python_script )

    emit:
	oligo_counts = COUNT_OLIGOS.out.oligo_counts

}
