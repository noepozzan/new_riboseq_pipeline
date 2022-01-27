include { REPORT } from '../modules/report.nf'

workflow RUN_REPORT {

    take:
    quant

    main:
    REPORT(	quant )

    emit:
    msstats = REPORT.out.msstats

}
