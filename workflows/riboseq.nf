include { PREPARE_GTF } from '../modules/prepare_gtf.nf'
include { PREPARE_READS } from '../modules/prepare_reads.nf'





workflow riboseq {

	take:
	// PREPARE_GTF files
	gtf
	lct_python_script // select_longest_coding_transcript.py
	genome
	tsv_cds_python_script // create_tab_delimited_CDS_file.py

	// PREPARE_GTF files
	reads

	main:

	PREPARE_GTF( gtf, lct_python_script, genome, tsv_cds_python_script )

	PREPARE_READS( reads )

	fasta_reads = PREPARE_READS.out.fasta_reads



}
