nextflow.enable.dsl=2

include {fastp} from './modules/fastp.nf'
include {kraken_illumina} from './modules/kraken_illumina.nf'
// include {nanoplot} from './modules/nanoplot.nf'
include {chopper} from './modules/chopper.nf'
include {nanoplot2} from './modules/nanoplot2'
include {kraken_ont} from './modules/kraken_ont.nf'
include {multiqc} from './modules/multiqc.nf'
include {multiqc_ont} from './modules/multiqc_ont.nf'

workflow {

    if (params.reads == null || params.readsType == null) {
        error "Please provide both --reads and --readsType parameters."
    }

    if (params.readsType == 'illumina') {
        Channel
            .fromFilePairs("${params.reads}/*{,.trimmed}_{R1,R2,1,2}{,_001}.{fastq,fq}{,.gz}", flat:true)
            .ifEmpty {
                error "Cannot find any Illumina reads matching: ${params.reads}"
            }
            .set {ch_reads}
	
	main:
	
        fastp(ch_reads)
		kraken_illumina(fastp.out.trimmed, params.k2database)
        multiqc(fastp.out.html.collect(), kraken_illumina.out.taxon.collect())

    } else if (params.readsType == 'ont') {
        Channel
			.fromPath("${params.reads}/*.{fastq,fq}{,.gz}")
			.map {file -> tuple(file.simpleName, file)}	
			.set{ch_reads}

   //     nanoplot(ch_reads)
		chopper(ch_reads) 
		nanoplot2(chopper.out.trimmed)
		kraken_ont(chopper.out.trimmed, params.k2database)
		multiqc_ont(nanoplot2.out.report.collect(), kraken_ont.out.taxon.collect())
        


    } else {
        error "Invalid --readsType provided: ${params.readsType}"
    }
}

// nextflow run main.nf --reads </path/to/reads> --readsType <illumina/ont>
