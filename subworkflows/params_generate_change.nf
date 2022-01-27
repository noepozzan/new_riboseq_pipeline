include { GENERATE_CHANGE_PARAMS } from '../modules/generate_change_params.nf'

workflow PARAMS_GENERATE_CHANGE {

    take:
    db
	python_script

    main:
    GENERATE_CHANGE_PARAMS( db, python_script )

    emit:
    params = GENERATE_CHANGE_PARAMS.out.params

}
