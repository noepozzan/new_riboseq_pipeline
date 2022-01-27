include { STAR_INDEX } from '../modules/star_index.nf'

workflow INDEX_STAR {

    take:
    sequence

    main:
	STAR_INDEX( sequence )

    emit:
	star_index = STAR_INDEX.out.star_index

}
