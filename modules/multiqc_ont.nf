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
//	file(html)
	file(taxon)
	
	output:
	file("*")	

	script:
	"""
	multiqc ${report} ${taxon}
	"""
}
