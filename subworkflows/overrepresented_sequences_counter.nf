include { COUNT_OVERREPRESENTED_SEQUENCES } from '../modules/count_overrepresented_sequences.nf'

workflow OVERREPRESENTED_SEQUENCES_COUNTER {

	take:
	sam
	python_script

    main:
	COUNT_OVERREPRESENTED_SEQUENCES( sam, python_script )

    emit:
	counts = COUNT_OVERREPRESENTED_SEQUENCES.out.counts


}
