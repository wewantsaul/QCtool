process multiqc_ont {
	container 'ewels/multiqc'

	tag "MULTIQC"

	publishDir (
	path: "${params.out_dir}",
	mode: 'copy',
	overwrite: 'true'
	)
	
	input:
	file(report)
	
	output:
	file("trimmed_multiqc.html")	

	script:
	"""
	multiqc ${report}
	
	mv multiqc_report.html trimmed_multiqc.html
	"""
}
