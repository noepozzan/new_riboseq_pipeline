include { TRIM_FIRST_BASES } from '../modules/trim_first_bases.nf'

workflow FIRST_BASES_TRIMMER {

	take:
	reads

    main:
    TRIM_FIRST_BASES( reads )

    emit:
	trimmed_first_bases = TRIM_FIRST_BASES.out.trimmed_first_bases

}
