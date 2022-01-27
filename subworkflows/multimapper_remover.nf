include { REMOVE_MULTIMAPPERS } from '../modules/remove_multimappers.nf'

workflow MULTIMAPPER_REMOVER {

	take:
	mapped_sam

    main:
    REMOVE_MULTIMAPPERS( mapped_sam )

    emit:
	unique_sam = REMOVE_MULTIMAPPERS.out.unique_sam


}
