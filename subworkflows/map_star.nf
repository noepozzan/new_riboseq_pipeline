include { STAR_MAP } from '../modules/star_map.nf'

workflow MAP_STAR {

	take:
	reads
	index
	gtf

    main:
    STAR_MAP( reads, index, gtf )

    emit:
	mapped_reads_sam = STAR_MAP.out.mapped_reads_sam
	unmapped_reads_fastx = STAR_MAP.out.unmapped_reads_fastx


}
