include { WORKSPACE } from '../modules/workspace.nf'
include { DATABASE } from '../modules/database.nf'
include { GENERATE_CHANGE_PARAMS } from '../modules/generate_change_params.nf'


workflow PHILOSOPHER {

	take:
	
	// initialize workspace
	ribo_pred

	// create database
	ribo_db

	// generate and change the params file for msfragger
	change_file_python_script

	main:
	
	WORKSPACE( ribo_pred )
	workspace_init = WORKSPACE.out.workspace_init

	DATABASE( workspace_init, ribo_db )
	philosopher_db = DATABASE.out.database

	GENERATE_CHANGE_PARAMS( philosopher_db, change_file_python_script )
	params = GENERATE_CHANGE_PARAMS.out.params




	emit:
	



}
