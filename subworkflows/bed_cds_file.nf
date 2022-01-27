include { CREATE_BED_CDS_FILE } from '../modules/create_bed_cds_file.nf'

workflow BED_CDS_FILE {

    take:
	tsv

    main:
	CREATE_BED_CDS_FILE( tsv )

    emit:
    cds_bed = CREATE_BED_CDS_FILE.out.cds_bed

}
