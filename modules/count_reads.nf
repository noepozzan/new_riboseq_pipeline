process COUNT_READS {

    label "pysam"

    publishDir "${params.qc_dir}/count_reads", mode: 'copy'

    input:
    each(path(bam_folder_offsets))
    path transcript_id_gene_id_CDS
    path script_py

    output:
    path '*.counts.tsv' optional true

    script:
    """
    workd=\$(pwd)
    input=\$(basename ${bam_folder_offsets[0]})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    cp ${bam_folder_offsets[0]}/* .

    mkdir \${prefix}.count_reads

    python ${script_py} \
        --bam *.bam \
        --tsv ${transcript_id_gene_id_CDS} \
        --json ${bam_folder_offsets[1]} \
        --outdir \${prefix}.count_reads

    cp \${prefix}.count_reads/* .
    mv counts.tsv \${prefix}.counts.tsv

    """

}

