include { PREPARE_ANNOTATION } from '../subworkflows/prepare_annotation.nf'
include { PREPARE_READS } from '../subworkflows/prepare_reads.nf'
include { INDEX_MAP_SEGEMEHL as INDEX_MAP_SEGEMEHL_rRNA } from '../subworkflows/index_map_segemehl.nf'
include { INDEX_MAP_SEGEMEHL as INDEX_MAP_SEGEMEHL_TRANSCRIPTOME } from '../subworkflows/index_map_segemehl.nf'
include { INDEX_MAP_STAR } from '../subworkflows/index_map_star.nf'
include { REMOVE_MULTIMAPPERS } from '../modules/remove_multimappers.nf'
include { QC } from '../subworkflows/qc.nf'
include { RIBOTISH } from '../subworkflows/ribotish.nf'
include { PHILOSOPHER } from '../subworkflows/philosopher.nf'
include { SAMTOOLS as SAMTOOLS_TRANSCRIPTOME } from '../subworkflows/samtools.nf'
include { SAMTOOLS as SAMTOOLS_GENOME } from '../subworkflows/samtools.nf'
include { SAMTOOLS as SAMTOOLS_QC } from '../subworkflows/samtools.nf'


gtf_ch = channel.fromPath('./data/Mus_musculus.GRCm38.99.chr.gtf')
other_RNAs_sequence_ch = channel.fromPath('./data/mm10_rrnas.fa')
genome_ch = channel.fromPath('./data/Mus_musculus.GRCm38.dna_sm.primary_assembly.fa')
riboseq_reads_ch = channel.fromPath('./data/riboseq_reads/*.gz')
oligos_ch = channel.fromPath('./data/oligos.txt')
proteomics_reads_ch = channel.fromPath('./data/proteomics_reads/*.mzML')
//only temporary, to be deleted as soon as ribotish outputs fasta file of predicted sORFs
philosopher_db_ch = channel.fromPath('./data/small_peptides_all_quad_samples.fasta')


workflow RIBOSEQ {

	PREPARE_READS(
        riboseq_reads_ch
    )
    fasta_reads = PREPARE_READS.out.fasta_reads

	PREPARE_ANNOTATION(
        gtf_ch,
        params.lct_script,
        genome_ch,
        params.ctdCDS_script
        )
    longest_ct_fa = PREPARE_ANNOTATION.out.longest_ct_fa
    cds_tsv = PREPARE_ANNOTATION.out.cds_tsv

	// map reads to rRNA, continue with unmapped reads
	if ( params.aligner_rrnas == "segemehl" ) {
        
		INDEX_MAP_SEGEMEHL_rRNA(
            other_RNAs_sequence_ch,
            fasta_reads
        )
        unmapped_reads_fasta = INDEX_MAP_SEGEMEHL_rRNA.out.unmapped_reads_fasta
    }



	unique_mapped_sam = Channel.empty()
	transcriptome_bam_folder = Channel.empty()

	// map reads to transcripts for further
	if ( params.aligner_transcripts == "segemehl" ) {
        
		INDEX_MAP_SEGEMEHL_TRANSCRIPTOME(
            longest_ct_fa,
            unmapped_reads_fasta
        )
        transcriptome_mapped_sam = INDEX_MAP_SEGEMEHL_TRANSCRIPTOME.out.mapped_reads_sam
    
		SAMTOOLS_TRANSCRIPTOME( transcriptome_mapped_sam )

        bam = SAMTOOLS_TRANSCRIPTOME.out.bam
        bai = SAMTOOLS_TRANSCRIPTOME.out.bai
        transcriptome_bam_folder = SAMTOOLS_TRANSCRIPTOME.out.bam_folder
	
		REMOVE_MULTIMAPPERS( transcriptome_mapped_sam )
		unique_mapped_sam = REMOVE_MULTIMAPPERS.out.unique_sam
	}
	
	genome_bam_folder = Channel.empty()

	if ( params.aligner_genome == "star" ) {

        INDEX_MAP_STAR(
			genome_ch,
			unmapped_reads_fasta,
			gtf_ch
        )
		mapped_reads_sam = INDEX_MAP_STAR.out.mapped_reads_sam
    
		//params.sort_bam = true

        SAMTOOLS_GENOME( mapped_reads_sam )

        bam = SAMTOOLS_GENOME.out.bam
        bai = SAMTOOLS_GENOME.out.bai
        genome_bam_folder = SAMTOOLS_GENOME.out.bam_folder

	}

	if ( !params.skip_qc ) {

        QC(
            unique_mapped_sam,
            params.plot_read_lengths_script,
            transcriptome_bam_folder,
            cds_tsv,
            params.determine_p_site_offsets_script,
            params.count_reads_script,
            params.check_periodicity_script,
            params.filter_reads_based_on_read_lengths_and_offsets_script
        )
		unique_a_site_bam = QC.out.unique_a_site

		//params.sort_bam = true

        SAMTOOLS_QC( unique_a_site_bam )

        bam = SAMTOOLS_QC.out.bam
        bai = SAMTOOLS_QC.out.bai
        unique_bam_folder = SAMTOOLS_QC.out.bam_folder

	}


	ribo_pred = Channel.empty()

	if ( !params.skip_ribotish ) {

        RIBOTISH(
            gtf_ch,
            genome_bam_folder,
            genome_ch
        )
		ribo_pred = RIBOTISH.out.ribo_pred
    }


	if ( !params.skip_philosopher ) {

        PHILOSOPHER(
            ribo_pred.collect(),
            proteomics_reads_ch,
            philosopher_db_ch,
            params.change_file_script
        )

    }



}
