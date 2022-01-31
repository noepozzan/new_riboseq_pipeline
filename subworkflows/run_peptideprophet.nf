include { PEPTIDEPROPHET } from '../modules/peptideprophet.nf'

workflow RUN_PEPTIDEPROPHET {

    take:
    db
	pepXML

    main:
    PEPTIDEPROPHET( db, pepXML )

    emit:
    interact.pep.xml = PEPTIDEPROPHET.out.interact.pep.xml

}
