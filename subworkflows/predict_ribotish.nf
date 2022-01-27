include { RIBOTISH_PREDICT } from '../modules/ribotish_predict.nf'

workflow PREDICT_RIBOTISH {

    take:
    bam_folder
	gtf
	genome

    main:
	RIBOTISH_PREDICT( bam_folder, gtf, genome )

    emit:
	ribo_pred = RIBOTISH_PREDICT.out.ribo_pred

}
