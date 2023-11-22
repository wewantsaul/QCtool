process nanoplot {
	container 'staphb/nanoplot:latest'

	tag "NANOPLOT"

	publishDir (
	path: "${params.out_dir}",
	mode: 'copy',
	overwrite: 'true'
	)
	
	input:
	tuple val(sample), path(fastq)

	output:
	tuple val(sample), file("01_nanoplot/*NanoPlot-report.html")
	tuple val(sample), file("01_nanoplot/*NanoStats.txt"), emit: html

	script:
	"""
	mkdir -p 01_nanoplot
	
	NanoPlot -t 4 --fastq ${sample}.fastq.gz -p ${sample}_ --plots dot --legacy hex --maxlength 40000 -o 01_nanoplot
	"""
}
