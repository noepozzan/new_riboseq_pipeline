include { SEGEMEHL_MAP } from '../modules/segemehl_map.nf'

workflow MAP_SEGEMEHL {

	take:
	reads
	index
	sequence

    main:
    SEGEMEHL_MAP( reads, index, sequence )

    emit:
	mapped_reads_sam = SEGEMEHL_MAP.out.mapped_reads_sam
	unmapped_reads_fasta = SEGEMEHL_MAP.out.unmapped_reads_fasta


}
