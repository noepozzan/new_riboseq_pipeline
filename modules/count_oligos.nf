process COUNT_OLIGOS {

    label "htseq_biopython"

    publishDir "results/count_oligos", mode: 'copy'

    input:
    each(path(reads))
    path oligos
    path py_script

    output:
    path '*_oligos_counts', emit: oligo_counts

    script:
    """
    input=\$(basename ${reads})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    python ${py_script} \
		--fastq <(gunzip -c ${reads}) \
        --oligos ${oligos} \
        --out \${prefix}_oligos_counts \
		2> \${prefix}_count_oligos.log

    """

}
