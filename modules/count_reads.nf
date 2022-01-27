process COUNT_READS {

    label "pysam"

    publishDir "${params.riboseq_process_data_outDir}/count_reads", mode: 'copy'

    input:
    each(path(bam_folder))
    path transcript_id_gene_id_CDS
    each(path(p_site_offsets))
    path script_py

    output:
    path '*.counts.tsv', emit: counts, optional: true

    script:
    """
    workd=\$(pwd)
    input1=\$(basename ${bam_folder})
    prefix1=\$(echo \$input1 | cut -d '.' -f 1)
    input2=\$(basename ${p_site_offsets})
    prefix2=\$(echo \$input2 | cut -d '.' -f 1)

    if [ "\$prefix1" == "\$prefix2" ]; then

    cp ${bam_folder}/* .

        mkdir \${prefix1}.count_reads

    python ${script_py} \
                --bam \${prefix1}.transcripts_mapped_unique_sorted_bam \
                --tsv ${transcript_id_gene_id_CDS} \
                --json ${p_site_offsets} \
                --outdir \${prefix1}.count_reads

        cp \${prefix1}.count_reads/* .
        mv counts.tsv \${prefix1}.counts.tsv

    fi

    """

}


