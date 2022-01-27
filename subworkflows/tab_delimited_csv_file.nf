include { CREATE_TAB_DELIMITED_CDS_FILE } from '../modules/create_tab_delimited_cds_file.nf'

workflow TAB_DELIMITED_CDS_FILE {

    take:
    gtf
    transcripts
	python_script

    main:
    CREATE_TAB_DELIMITED_CDS_FILE( gtf, transcripts, python_scripts )

    emit:
	cds_tsv = CREATE_TAB_DELIMITED_CDS_FILE.out.cds_tsv

}
