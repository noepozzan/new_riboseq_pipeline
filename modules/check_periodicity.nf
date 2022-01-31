process CHECK_PERIODICITY {

    label "rcrunch_python"

    publishDir "results/check_periodicity", mode: 'copy'

    input:
    each(path(bam_folder))
    path transcript_id_gene_id_CDS
    each(path(p_site_offsets))
    path script_py

    output:
    path '*.periodicity_start.pdf', emit: start, optional: true
    path '*.periodicity_stop.pdf', emit: stop, optional: true
    path '*.Periodicity_Analysis_Start_Ribo_Seq.txt', emit: txt, optional: true

    script:
    """
    workd=\$(pwd)
    input1=\$(basename ${bam_folder})
    prefix1=\$(echo \$input1 | cut -d '.' -f 1)
    input2=\$(basename ${p_site_offsets})
    prefix2=\$(echo \$input2 | cut -d '.' -f 1)

    if [ "\$prefix1" == "\$prefix2" ]; then

        cp ${bam_folder}/* .

        mkdir \${prefix1}.check_periodicity

    python ${script_py} \
		--bam \${prefix1}.transcripts_mapped_unique_sorted_bam \
        --tsv ${transcript_id_gene_id_CDS} \
        --json ${p_site_offsets} \
        --outdir \${prefix1}.check_periodicity \
        --codnum ${params.check_peridocitiy_codnum} \
        2> \${prefix1}_check_periodicity.log

        cp \${prefix1}.check_periodicity/* .
        mv periodicity_start.pdf \${prefix1}.periodicity_start.pdf
    mv periodicity_stop.pdf \${prefix1}.periodicity_stop.pdf
    mv Periodicity_Analysis_Start_Ribo_Seq.txt \${prefix1}.Periodicity_Analysis_Start_Ribo_Seq.txt

    fi

    """

}
