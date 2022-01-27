process STAR_MAP {

    label "star"
    label "heavy_computation"

    publishDir "${params.riboseq_process_data_outDir}/star_map", mode: 'copy'

    input:
    each(path(reads))
    path index
    path gtf

    output:
    path '*.Aligned.out.sam', emit: mapped_reads_sam
    path '*.Unmapped*', emit: unmapped_reads_fastx

    script:
    """
    for VAR in ${reads}
    do

        input=\$(basename \$VAR)
        prefix=\$(echo \$input | cut -d '.' -f 1)

    STAR --runThreadN ${params.star_map_threads} \
        --genomeDir ${index} \
        --sjdbGTFfile ${gtf} \
        --outSAMattributes All \
        --quantMode GeneCounts \
        --readFilesIn \$VAR \
        --outReadsUnmapped Fastx \
        --outFileNamePrefix \${prefix}.

    : '
        # other possible params
		--outFilterMismatchNmax 2 \
        --alignEndsType EndToEnd \
        --outFilterIntronMotifs RemoveNoncanonicalUnannotated \
        --alignIntronMax 20000 \
        --outMultimapperOrder Random \
        --outSAMmultNmax 1

    '

    done

    """

}

