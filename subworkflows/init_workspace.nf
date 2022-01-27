include { WORKSPACE } from '../modules/workspace.nf'

workflow INIT_WORKSPACE {

    take:
    riboseq

    main:
    WORKSPACE( riboseq )

    emit:
    workspace_init = WORKSPACE.out.workspace_init

}
~  
