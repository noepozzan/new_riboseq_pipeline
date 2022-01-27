include { RIBOTISH_QUALITY } from '../modules/ribotish_quality.nf'

workflow QUALITY_RIBOTISH {

    take:
    bam_folder
	gtf

    main:
	RIBOTISH_QUALITY( bam_folder, gtf )

    emit:
	offset = RIBOTISH_QUALITY.out.offset
	quality_pdf = RIBOTISH_QUALITY.out.ribo_pdf
	quality_txt = RIBOTISH_QUALITY.out.ribo_txt

}
