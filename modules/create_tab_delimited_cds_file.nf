process CREATE_TAB_DELIMITED_CDS_FILE {

    label "htseq_biopython"

    publishDir "${params.riboseq_annotate_outDir}/create_tab_delimited_CDS_file", mode: 'copy'

    input:
    path gtf
    path transcripts
    path td_CDS_script_py

    output:
    path 'CDS.tsv', emit: cds_tsv

    script:
    """
    python ${td_CDS_script_py} \
        --gtf ${gtf} \
        --fasta ${transcripts} \
        --out CDS.tsv \
        2> create_tab_delimited_CDS_file.log

    """

}
