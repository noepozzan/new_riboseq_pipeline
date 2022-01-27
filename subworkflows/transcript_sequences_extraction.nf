include { EXTRACT_TRANSCRIPT_SEQUENCES } from '../modules/extract_transcript_sequences.nf'

workflow TRANSCRIPT_SEQUENCES_EXTRACTION {

    take:
    gtf
	genome

    main:
    EXTRACT_TRANSCRIPT_SEQUENCES( gtf, genome )

    emit:
    transcript_sequences = EXTRACT_TRANSCRIPT_SEQUENCES.out.transcript_sequences


}
