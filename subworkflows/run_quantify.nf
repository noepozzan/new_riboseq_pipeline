include { QUANTIFY } from '../modules/quantify.nf'

workflow RUN_QUANTIFY {

	take:
	filter_fdr

    main:
    QUANTIFY( filter_fdr )

    emit:
	quant = QUANTIFY.out.quant

}
