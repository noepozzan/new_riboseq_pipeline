process READ_LENGTH_HISTOGRAM {

    label "rcrunch_python"

    publishDir "results/read_length_histogram", mode: 'copy'

    input:
    each(path(sam))
    path script_py

    output:
    path '*E14', emit: histogram

    script:
    """
    input=\$(basename ${sam})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    python ${script_py} \
    	--sam ${sam} \
    	--outdir \${prefix} \
    	2> \${prefix}_read_length_histogram.log

    """

}
