process IONQUANT {

    label "ionquant"

    publishDir "${params.philosopher_dir}/ionquant", mode: 'copy'

    input:
    val filter_fdr
    path pepXML

    output:
    path "*_quant.csv"

    script:
    """
    workd=\$(pwd)
    cd ${params.workspace}

    # extract parent dir
    dir=${params.proteomics_reads}
    parentdir="\$(dirname "\$dir")"
    # Perform label-free quantification via 
    # precursor (MS1) abundances and spectral counting
    java -Xmx${params.ionquant_ram}G -jar /IonQuant.jar \
        --specdir \${parentdir} \
        --multidir . \
        *.pepXML \
        &> ionquant.log

    cp *_quant.csv \$workd

    """

}

