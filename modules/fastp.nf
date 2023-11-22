process fastp {
	container 'nanozoo/fastp:latest'

	tag "FASTP"

	publishDir (
	path: "${params.out_dir}/01_fastp",
	mode: 'copy',
	overwrite: 'true'
	)
	
	input:
	tuple val(sample), path(fastq_1), path(fastq_2)

	output:
	tuple val(sample), path("*1.fastq.gz"), path("*2.fastq.gz"), emit: trimmed
	tuple val(sample), path("*.json"), emit: html
	tuple val(sample), path("*.html") 

	script:
	"""
	fastp -i $fastq_1 \
	-I $fastq_2 \
	-o ${sample}.trimmed_R1.fastq.gz \
	-O ${sample}.trimmed_R2.fastq.gz \
	-j ${sample}.fastp.json \
	-h ${sample}.fastp.html
	"""
}
