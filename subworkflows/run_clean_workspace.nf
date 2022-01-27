include { CLEAN_UP_WORKSPACE } from '../modules/clean_up_workspace.nf'

workflow RUN_CLEAN_WORKSPACE {

    take:
    report

    main:
    CLEAN_UP_WORKSPACE( report )


}
