
include { SELECT_LONGEST_CODING_TRANSCRIPT } from '../modules/select_longest_coding_transcript.nf'

workflow LONGEST_CODING_TRANSCRIPT {

	take:
	gtf
	python_script

	main:
	SELECT_LONGEST_CODING_TRANSCRIPT( gtf, python_script )

	emit:
	longest_ct = SELECT_LONGEST_CODING_TRANSCRIPT.out.longest_ct


}


