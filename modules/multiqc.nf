process multiqc {
	container 'ewels/multiqc'

	tag "MULTIQC"

	publishDir (
	path: "${params.out_dir}",
	mode: 'copy',
	overwrite: 'true'
	)
	
	input:
	file(html)
	file(reports)
	
	output:
	file("*")	

	script:
	"""
	multiqc ${html} ${reports}
	"""
}
