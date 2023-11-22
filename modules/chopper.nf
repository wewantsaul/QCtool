process chopper {
	container 'ufuomababatunde/chopper:v0.7.0'

	tag "CHOPPER"

	publishDir (
	path: "${params.out_dir}/02_trimmed/",
	mode: 'copy',
	overwrite: 'true'
	)
	
	input:
	tuple val(sample), path(fastq)

	output:
	tuple val(sample), path("*.fastq.gz"), emit: trimmed

	script:
	"""
	gunzip -c ${sample}.fastq.gz | chopper -q 10 -l 500 | gzip > ${sample}_trimmed.fastq.gz
	"""
}
