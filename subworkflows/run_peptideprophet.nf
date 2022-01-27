include { PEPTIDEPROPHET } from '../modules/peptideprophet.nf'

workflow RUN_PEPTIDEPROPHET {

    take:
    db
	pepXML

    main:
    PEPTIDEPROPHET( db, pepXML )

    emit:
    pep_xml = PEPTIDEPROPHET.out.pep_xml

}
