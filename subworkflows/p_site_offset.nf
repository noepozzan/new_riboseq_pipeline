include { DETERMINE_P_SITE_OFFSET } from '../modules/determine_p_site_offset.nf'

workflow P_SITE_OFFSET {

	take:
	bam_folder
	id_CDS
	python_script

    main:
    DETERMINE_P_SITE_OFFSET( sam, id_CDS, python_script )

    emit:
	offset = DETERMINE_P_SITE_OFFSET.out.offset

}
