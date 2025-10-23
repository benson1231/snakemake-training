rule multiqc:
    input:
        expand("results/fastqc/{sample}_R1_fastqc.html", sample=SAMPLES.keys()),
        expand("results/fastp/{sample}_fastp.html", sample=SAMPLES.keys())
    output:
        html = "results/multiqc/multiqc_report.html"
    conda:
        "../envs/main.yaml"
    threads: 4
    log:
        "results/multiqc/multiqc.log"
    shell:
        """
        mkdir -p results/multiqc
        multiqc results -o results/multiqc > {log} 2>&1
        """