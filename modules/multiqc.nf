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
	
	output:
	file("multiqc_report.html")	

	script:
	"""
	multiqc ${html}
	"""
}
