include { FILTERANDFDR } from '../modules/filterandfdr.nf'

workflow RUN_FILTER_FDR {

    take:
    pepxml
	protxml

    main:
	FILTERANDFDR( pepxml, protxml )

    emit:
	filter_fdr = FILTERANDFDR.out.filter_fdr

}
