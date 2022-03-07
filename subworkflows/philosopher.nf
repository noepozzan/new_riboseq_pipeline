nextflow.enable.dsl=2

include { WORKSPACE } from '../modules/workspace.nf'
include { DATABASE } from '../modules/database.nf'
include { GENERATE_CHANGE_PARAMS } from '../modules/generate_change_params.nf'
include { MSFRAGGER } from '../modules/msfragger.nf'
include { PEPTIDEPROPHET } from '../modules/peptideprophet.nf'
include { PROTEINPROPHET } from '../modules/proteinprophet.nf'
include { FILTER_FDR } from '../modules/filter_fdr.nf'
include { FREEQUANT } from '../modules/freequant.nf'
include { IONQUANT } from '../modules/ionquant.nf'
include { REPORT } from '../modules/report.nf'
include { CLEAN_UP_WORKSPACE } from '../modules/clean_up_workspace.nf'


workflow PHILOSOPHER {

    take:
    ribotish_predict_ch
    proteomics_reads

    main:
    WORKSPACE(ribotish_predict_ch)

    DATABASE(WORKSPACE.out, ribotish_predict_ch)

    GENERATE_CHANGE_PARAMS(DATABASE.out, params.change_file_script)

    MSFRAGGER(
        proteomics_reads.collect(),
        GENERATE_CHANGE_PARAMS.out,
        DATABASE.out
    )

    PEPTIDEPROPHET(DATABASE.out, MSFRAGGER.out)

    PROTEINPROPHET(PEPTIDEPROPHET.out)

    FILTER_FDR(
        PEPTIDEPROPHET.out,
        PROTEINPROPHET.out
    )

    FREEQUANT(FILTER_FDR.out)

    REPORT(FREEQUANT.out)
    report = REPORT.out

    IONQUANT(
        FILTER_FDR.out,
        MSFRAGGER.out
    )

    //CLEAN_UP_WORKSPACE(REPORT.out)

    emit:
    report

}
