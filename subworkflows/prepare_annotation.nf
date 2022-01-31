include { SELECT_LONGEST_CODING_TRANSCRIPT } from '../modules/select_longest_coding_transcript.nf'
include { EXTRACT_TRANSCRIPT_SEQUENCES } from '../modules/extract_transcript_sequences.nf'
include { CREATE_TAB_DELIMITED_CDS_FILE } from '../modules/create_tab_delimited_cds_file.nf'
include { CREATE_BED_CDS_FILE } from '../modules/create_bed_cds_file.nf'

workflow PREPARE_ANNOTATION {

    take:
    gtf
	lct_python_script // select_longest_coding_transcript.py
	genome
	tsv_cds_python_script // create_tab_delimited_CDS_file.py

    main:
    
	SELECT_LONGEST_CODING_TRANSCRIPT( gtf, lct_python_script )
	longest_ct_gtf = SELECT_LONGEST_CODING_TRANSCRIPT.out.longest_ct

	EXTRACT_TRANSCRIPT_SEQUENCES( longest_ct_gtf, genome )
	longest_ct_fa = EXTRACT_TRANSCRIPT_SEQUENCES.out.transcript_sequences

	CREATE_TAB_DELIMITED_CDS_FILE( longest_ct_gtf, longest_ct_fa, tsv_cds_python_script ) 
	cds_tsv = CREATE_TAB_DELIMITED_CDS_FILE.out.cds_tsv

	CREATE_BED_CDS_FILE( cds_tsv )
	cds_bed = CREATE_BED_CDS_FILE.out.cds_bed

    emit:
	longest_ct_gtf
	longest_ct_fa
	cds_tsv
	cds_bed

}




