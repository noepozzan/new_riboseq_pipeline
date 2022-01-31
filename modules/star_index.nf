process STAR_INDEX {

    label 'star'

    publishDir "results/star_index", mode: 'copy'

    input:
    path sequence

    output:
    path 'starIndex', emit: star_index

    script:
    """
    mkdir starIndex

    STAR --runThreadN ${params.index_threads} \
        --runMode genomeGenerate \
        --genomeDir starIndex \
        --genomeFastaFiles ${sequence}

    """

}
