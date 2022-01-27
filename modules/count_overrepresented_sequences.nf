process COUNT_OVERREPRESENTED_SEQUENCES {

    label "pysam"

    publishDir "${params.riboseq_process_data_outDir}/count_overrepresented_sequences", mode: 'copy'

    input:
    each(path(sam))
    path script_py

    output:
    path '*.overrepresented_sequences_counts', emit: counts

    script:
    """
    input=\$(basename ${sam})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    python ${script_py} \
    	--sam ${sam} \
    	--out \${prefix}.overrepresented_sequences_counts \
		2> \${prefix}_count_overrepresented_sequences_other.log

    : '
    grep -P -v \"^@\" ${sam} \
    | cut -f 10 | sort | uniq -c \
    | sort -n -r > \
    \${prefix}.overrepresented_sequences_counts \
    2> \${prefix}_count_overrepresented_sequences.log
    '

	"""

}

