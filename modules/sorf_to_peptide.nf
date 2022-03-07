process SORF_TO_PEPTIDE {

    label "sorf_to_speptide"

    publishDir "${params.ribotish_dir}/sorf_to_peptide", mode: 'copy'

    input:
    each(path(ribo_pred))
    path fasta
    path python_script

    output:
    path '*.speptide', emit: prediction

    script:
    """
    input=\$(basename ${ribo_pred})
    prefix=\$(echo \$input | cut -d '.' -f 1)

    python3 ${python_script} \
        --ribo_pred ${ribo_pred} \
        --fasta ${fasta} \
        --out \${prefix}.speptide


    """

}
