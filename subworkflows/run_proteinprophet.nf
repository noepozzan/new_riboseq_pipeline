include { PROTEINPROPHET } from '../modules/proteinprophet.nf'

workflow RUN_PROTEINPROPHET {

    take:
    pep_XML

    main:
    PROTEINPROPHET( pep_xml )

    emit:
    prot_xml = PROTEINPROPHET.out.prot_xml

}
