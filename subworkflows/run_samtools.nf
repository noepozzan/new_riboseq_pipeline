include { SAMTOOLS } from '../modules/samtools.nf'

workflow RUN_SAMTOOLS {

	take:
	sam

    main:
    SAMTOOLS( sam )

    emit:
	bam = SAMTOOLS.out.bam
	bai = SAMTOOLS.out.bai
	bam_folder = SAMTOOLS.out.bam_folder



}
