process nanoplot2 {
	container 'staphb/nanoplot:latest'

	tag "NANOPLOT"

	publishDir (
	path: "${params.out_dir}",
	mode: 'copy',
	overwrite: 'true'
	)
	
	input:
	tuple val(sample), path(trimmed)

	output:
	tuple val(sample), file("01_nanoplot/*NanoPlot-report.html")
	tuple val(sample), file("01_nanoplot/*NanoStats.txt"), emit: report

	script:
	"""
	NanoPlot -t 4 --fastq ${trimmed} -p ${sample}_trimmed_ --plots dot --legacy hex --maxlength 40000 -o 01_nanoplot
	"""
}
