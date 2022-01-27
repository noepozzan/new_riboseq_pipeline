include { READ_LENGTH_HISTOGRAM } from '../modules/read_length_histogram.nf'

workflow HISTOGRAM_READ_LENGTH {

	take:
	sam
	python_script

    main:
    HISTOGRAM_READ_LENGTH( sam, python_script )

    emit:
	histogram = HISTOGRAM_READ_LENGTH.out.histogram





}
