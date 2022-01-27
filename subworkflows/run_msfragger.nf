include { MSFRAGGER} from '../modules/msfragger.nf'

workflow RUN_MSFRAGGER {

    take:
    mzML
    params
	db

    main:
	MSFRAGGER( mzML, params, db )

    emit:
    pepXML = MSFRAGGER.out.pepXML

}
