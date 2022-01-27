include { FILTER_LENGTH_OFFSET } from '../modules/filter_length_offset.nf'

workflow LENGTH_OFFSET_FILTER {

	take:
	bam_folder
	offsets
	python_script

    main:
    FILTER_LENGTH_OFFSET( bam_folder, offsets, python_script )

    emit:
	unique = FILTER_LENGTH_OFFSET.out.unique

}
