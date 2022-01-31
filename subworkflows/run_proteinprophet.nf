include { PROTEINPROPHET } from '../modules/proteinprophet.nf'

workflow RUN_PROTEINPROPHET {

    take:
    interact_pep_xml

    main:
    PROTEINPROPHET( interact_pep_xml )

    emit:
    prot_xml = PROTEINPROPHET.out.prot_xml

}
