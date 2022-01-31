nextflow.enable.dsl=2

include { RIBOSEQ } from './workflows/riboseq.nf'


def helpMessage() {
  log.info """
        Usage:
        The typical command for running the pipeline is as follows:
        nextflow run main.nf -profile docker

        Mandatory arguments:
         --something                     something
         --something else                something else

        Optional arguments:
         --well                          still some else
        """
}

// Show help message
if (params.help) {
    helpMessage()
    exit 0
}



workflow {

/*
	if ( !params.skip_pull_containers) {
    	PULL_CONTAINERS(  config_file_ch, pull_file_ch  )
	}

    CHECK_FILES_PIPE(
		riboseq_reads_ch,
		proteomics_reads_ch,
		genome_ch,
		genome_fai_ch,
		gtf_ch,
		other_RNAs_sequence_ch,
		check_files_script_ch
	)
*/

	RIBOSEQ( )

}
