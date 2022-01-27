include { SEGEMEHL_INDEX } from '../modules/segemehl_index.nf'

workflow INDEX_SEGEMEHL {

    take:
    sequence

    main:
    SEGEMEHL_INDEX( sequence )

    emit:
	segemehl_index = SEGEMEHL_INDEX.out.segemehl_index

}
