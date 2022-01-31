include { FILTER_FDR } from '../modules/filter_fdr.nf'

workflow RUN_FILTER_FDR {

    take:
    pepxml
	protxml

    main:
	FILTER_FDR( pepxml, protxml )

    emit:
	filter_fdr = FILTER_FDR.out.filter_fdr

}
