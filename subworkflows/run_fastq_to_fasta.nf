include { FASTQ_TO_FASTA } from '../modules/fastq_to_fasta.nf'

workflow RUN_FASTQ_TO_FASTA {

	take:
	reads

    main:
    FASTQ_TO_FASTA( reads )

    emit:
	fasta_reads = FASTQ_TO_FASTA.out.fasta_reads

}
