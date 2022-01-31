process CREATE_BED_CDS_FILE {

    label "htseq_biopython"

    publishDir "results/create_bed_cds_file", mode: 'copy'

    input:
    path tsv

    output:
    path 'CDS.bed', emit: cds_bed

    script:
    """
    tail -n+2 ${tsv} \
        | awk '{print \$1 "\t" \$3-1 "\t" \$4 "\t" \$2 }' > CDS.bed \
        2> create_bed_cds_file.log

    """

}
