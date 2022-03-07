nextflow.enable.dsl=2

include { RIBOTISH_QUALITY } from '../modules/ribotish_quality.nf'
include { RIBOTISH_PREDICT } from '../modules/ribotish_predict.nf'
include { GFFREAD } from '../modules/gffread.nf'
include { SORF_TO_PEPTIDE } from '../modules/sorf_to_peptide.nf'
include { COMBINE } from '../modules/ribotish_combine.nf'

workflow RIBOTISH {

	take:
	gtf_ch
	genome_bam_folder_ch
	genome_ch
	genome_fai_ch

	main:

	RIBOTISH_QUALITY(
		genome_bam_folder_ch,
		gtf_ch
	)
	ribo_offsets = RIBOTISH_QUALITY.out.offsets

	genome_bam_folder_ch
        .combine(ribo_offsets)
        .filter{ it[0].baseName.split("\\.")[0] == it[1].baseName.split("\\.")[0] }
        .set{ bam_folder_offsets }

	RIBOTISH_PREDICT(
		bam_folder_offsets,
		gtf_ch,
		genome_ch
	)
	ribo_pred = RIBOTISH_PREDICT.out.ribo_pred

	GFFREAD(
        genome_ch,
        genome_fai_ch,
        gtf_ch
    )
    transcripts_fa = GFFREAD.out.fasta

	SORF_TO_PEPTIDE(
        RIBOTISH_PREDICT.out.ribo_pred,
        transcripts_fa,
        params.sorf_peptide_script
    )
    speptide = SORF_TO_PEPTIDE.out.prediction

    COMBINE(
        speptide.collect()
    )
    speptide_combined = COMBINE.out.combined_prediction

    emit:
    speptide_combined

}
