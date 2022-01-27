include { CLIP_READS } from '../modules/clip_reads.nf'

workflow READS_CLIPPER {

	take:
	reads

    main:
    CLIP_READS( reads )

    emit:
	clipped_reads = CLIP_READS.out.clipped_reads

}
