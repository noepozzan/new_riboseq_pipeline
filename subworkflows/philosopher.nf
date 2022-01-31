include { WORKSPACE } from '../modules/workspace.nf'
include { DATABASE } from '../modules/database.nf'
include { GENERATE_CHANGE_PARAMS } from '../modules/generate_change_params.nf'
include { MSFRAGGER } from '../modules/msfragger.nf'
include { PEPTIDEPROPHET } from '../modules/peptideprophet.nf'
include { PROTEINPROPHET } from '../modules/proteinprophet.nf'
include { FILTER_FDR } from '../modules/filter_fdr.nf'
include { QUANTIFY } from '../modules/quantify.nf'
include { REPORT } from '../modules/report.nf'
include { CLEAN_UP_WORKSPACE } from '../modules/clean_up_workspace.nf'


workflow PHILOSOPHER {

	take:
	
	// initialize workspace
	ribo_pred

	// create database
	ribo_db

	// generate and change the params file for msfragger
	change_file_python_script

	// msfragger (search mzML files against database to find hits (peptides identified in peptidomics data))
	peptidomics_reads

	main:
	
	WORKSPACE( ribo_pred )
	workspace_init = WORKSPACE.out.workspace_init

	DATABASE( workspace_init, ribo_db )
	philosopher_db = DATABASE.out.database

	GENERATE_CHANGE_PARAMS( philosopher_db, change_file_python_script )
	params = GENERATE_CHANGE_PARAMS.out.params

	MSFRAGGER( peptidomics_reads, params, philosopher_db )
	pepXML = MSFRAGGER.out.pepXML

	PEPTIDEPROPHET( ribo_db, pepXML )
	interact_pep_xml = PEPTIDEPROPHET.out.interact_pep_xml

	PROTEINPROPHET( interact_pep_xml )
	prot_xml = PROTEINPROPHET.out.prot_xml

	FILTER_FDR( interact_pep_xml, prot_xml )	

	QUANTIFY( FILTER_FDR.out.filter_fdr)

	REPORT( QUANTIFY.out.quant )
	msstats = REPORT.out.msstats

	CLEAN_UP_WORKSPACE( REPORT.out.msstats )

	emit:
	msstats



}
