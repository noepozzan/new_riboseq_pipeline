include { CHECK_PERIODICITY } from '../modules/check_periodicity.nf'

workflow PERIODICITY_CHECKER {

	take:
	bam_folder
	id_CDS
	offsets
	python_script

    main:
    CHECK_PERIODICITY( bam_folder, id_CDS, offsets, python_script )

    emit:
	start = CHECK_PERIODICITY.out.start
	stop = CHECK_PERIODICITY.out.stop
	txt = CHECK_PERIODICITY.out.txt

}
