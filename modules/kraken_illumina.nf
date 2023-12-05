process kraken_illumina {
	container 'staphb/kraken2:2.1.2-no-db'

	tag "KRAKEN2"

	publishDir (
	path: "${params.out_dir}/01-1_kraken/",
	mode: 'copy',
	overwrite: 'true'
	)
	
	errorStrategy 'ignore'
	
	input:
	tuple val(sample), path(fastq_1), path(fastq_2)
	path(k2database)

	output:
	tuple val(sample), path("*.txt"), emit: taxon

	script:

	"""
	kraken2 --threads 4 \
	--quick \
	--memory-mapping \
	--use-names \
	--db $k2database \
	--report ${sample}_k2report.txt \
	--paired $fastq_1 $fastq_2
	"""
}
