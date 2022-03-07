process CHECK_PERIODICITY {

    label "rcrunch_python"

    publishDir "${params.qc_dir}/check_periodicity", mode: 'copy'

    input:
    each(path(bam_folder_offsets))
    path transcript_id_gene_id_CDS
    path script_py

    output:
    path '*.periodicity_start.pdf' optional true
    path '*.periodicity_stop.pdf' optional true
    path '*.Periodicity_Analysis_Start_Ribo_Seq.txt' optional true

    script:
    """
    workd=\$(pwd)
    input=\$(basename ${bam_folder_offsets[0]})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    cp ${bam_folder_offsets[0]}/* .

    mkdir \${prefix1}.check_periodicity

    python ${script_py} \
        --bam *.bam \
        --tsv ${transcript_id_gene_id_CDS} \
        --json ${bam_folder_offsets[1]} \
        --outdir \${prefix}.check_periodicity \
        --codnum ${params.check_peridocitiy_codnum} \
        2> \${prefix}_check_periodicity.log

        cp \${prefix}.check_periodicity/* .
        mv periodicity_start.pdf \${prefix}.periodicity_start.pdf
        mv periodicity_stop.pdf \${prefix}.periodicity_stop.pdf
        mv Periodicity_Analysis_Start_Ribo_Seq.txt \${prefix}.Periodicity_Analysis_Start_Ribo_Seq.txt

    fi

    """

}

