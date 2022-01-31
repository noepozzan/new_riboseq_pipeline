include { RIBOTISH_QUALITY } from '../modules/ribotish_quality.nf'
include { RIBOTISH_PREDICT } from '../modules/ribotish_predict.nf'

workflow RIBOTISH {

	take:
	bam_folder
	gtf
	genome

	main:

	RIBOTISH_QUALITY( bam_folder, gtf )

	RIBOTISH_PREDICT( bam_folder, gtf, genome )
	ribo_pred = RIBOTISH_PREDICT.out.ribo_pred

	emit:
	ribo_pred

}
