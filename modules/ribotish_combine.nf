process COMBINE {

    label "sorf_to_speptide"

    publishDir "${params.ribotish_dir}/combine", mode: 'copy'

    input:
    path ribo_pred

    output:
    path 'combined_speptide.txt', emit: combined_prediction

    script:
    """
    WRITE_HEADER="true"
    for VAR in ${ribo_pred}
    do
        if [ "\$WRITE_HEADER" == "true" ]; then
            head -1 \$VAR > combined_speptide.txt
            WRITE_HEADER="false"
        fi
        tail -n +2 -q \$VAR >> combined_speptide.txt
    done

    """

}

