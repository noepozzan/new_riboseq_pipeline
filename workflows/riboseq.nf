nextflow.enable.dsl=2

// import subworkflows
include { PREPARE_ANNOTATION } from '../subworkflows/prepare_annotation.nf'
include { PREPARE_READS } from '../subworkflows/prepare_reads.nf'
include { INDEX_MAP_SEGEMEHL as INDEX_MAP_SEGEMEHL_rRNA } from '../subworkflows/index_map_segemehl.nf'
include { INDEX_MAP_SEGEMEHL as INDEX_MAP_SEGEMEHL_TRANSCRIPTOME } from '../subworkflows/index_map_segemehl.nf'
include { INDEX_MAP_STAR as INDEX_MAP_STAR_GENOME } from '../subworkflows/index_map_star.nf'
include { REMOVE_MULTIMAPPERS } from '../modules/remove_multimappers.nf'
include { COUNT_OVERREPRESENTED_SEQUENCES } from '../modules/count_overrepresented_sequences.nf'
include { QC } from '../subworkflows/qc.nf'
include { SAMTOOLS as SAMTOOLS_QC } from '../subworkflows/samtools.nf'
include { RIBOTISH } from '../subworkflows/ribotish.nf'
include { PHILOSOPHER } from '../subworkflows/philosopher.nf'


gtf_ch = channel.fromPath('./data/Mus_musculus.GRCm38.99.chr.gtf')
other_RNAs_sequence_ch = channel.fromPath('./data/mm10_rrnas.fa')
genome_ch = channel.fromPath('./data/Mus_musculus.GRCm38.dna_sm.primary_assembly.fa')
genome_fai_ch = channel.fromPath('./data/Mus_musculus.GRCm38.dna_sm.primary_assembly.fa.fai')
riboseq_reads_ch = channel.fromPath('./data/muscle_samples/*.gz')
oligos_ch = channel.fromPath('./data/oligos.txt')
proteomics_reads_ch = channel.fromPath('./data/proteomics_reads/*.mzML')
//only temporary, to be deleted as soon as ribotish outputs fasta file of predicted sORFs
philosopher_db_ch = channel.fromPath('./data/small_peptides_all_quad_samples.fasta')

/*
fasta_reads = Channel.empty()
longest_ct_fa = Channel.empty()
cds_tsv = Channel.empty()
unmapped_reads_rRNA = Channel.empty()
segemehl_index_transcriptome = Channel.empty()
transcriptome_mapped_bam = Channel.empty()
transcriptome_bam_folder = Channel.empty()
unique_mapped_sam = Channel.empty()
star_mapped_sam = Channel.empty()
ribo_pred = Channel.empty()
genome_bam_folder = Channel.empty()
unique_mapped_sam = Channel.empty()
transcriptome_bam_folder = Channel.empty()
*/

workflow RIBOSEQ {

	PREPARE_READS(
        riboseq_reads_ch
    )
    fasta_reads = PREPARE_READS.out.fasta_reads

	PREPARE_ANNOTATION(
        gtf_ch,
        genome_ch,
    )
    longest_ct_fa = PREPARE_ANNOTATION.out.longest_ct_fa
    cds_tsv = PREPARE_ANNOTATION.out.cds_tsv

	// map reads to rRNA, continue with unmapped reads
    INDEX_MAP_SEGEMEHL_rRNA(
		other_RNAs_sequence_ch,
		fasta_reads
	)
	unmapped_reads_rRNA = INDEX_MAP_SEGEMEHL_rRNA.out.unmapped_reads_fasta

	if ( params.run_qc == true ){
	// map reads to transcripts
	INDEX_MAP_SEGEMEHL_TRANSCRIPTOME(
		longest_ct_fa,
		unmapped_reads_rRNA
	)
	transcriptome_mapped_sam = INDEX_MAP_SEGEMEHL_TRANSCRIPTOME.out.mapped_reads_sam
	transcriptome_bam_folder = INDEX_MAP_SEGEMEHL_TRANSCRIPTOME.out.bam_folder

	REMOVE_MULTIMAPPERS(
		transcriptome_mapped_sam
	)
	unique_mapped_sam = REMOVE_MULTIMAPPERS.out.unique_sam

	QC(
		unique_mapped_sam,
		transcriptome_bam_folder,
		cds_tsv,
	)
	unique_a_site_bam = QC.out.unique_a_site

	SAMTOOLS_QC(
		unique_a_site_bam
	)
	bam = SAMTOOLS_QC.out.bam
	bai = SAMTOOLS_QC.out.bai
	unique_bam_folder = SAMTOOLS_QC.out.bam_folder

	}
	// map filtered reads to genome
	INDEX_MAP_STAR_GENOME(
		genome_ch,
		unmapped_reads_rRNA,
		gtf_ch
	)
	genome_bam_folder = INDEX_MAP_STAR_GENOME.out.bam_folder

	RIBOTISH(
		gtf_ch,
		genome_bam_folder,
		genome_ch,
		genome_fai_ch
	)
	pred_peptides_fasta = RIBOTISH.out.speptide_combined

	PHILOSOPHER(
		pred_peptides_fasta,
		proteomics_reads_ch,
	)

}
