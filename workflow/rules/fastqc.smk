rule fastqc:
    input:
        r1 = lambda wc: f"data/{SAMPLES[wc.sample]['r1']}",
        r2 = lambda wc: f"data/{SAMPLES[wc.sample]['r2']}"
    output:
        html_r1 = "results/fastqc/{sample}_R1_fastqc.html",
        html_r2 = "results/fastqc/{sample}_R2_fastqc.html",
        zip_r1 = "results/fastqc/{sample}_R1_fastqc.zip",
        zip_r2 = "results/fastqc/{sample}_R2_fastqc.zip"
    conda:
        "../envs/main.yaml"
    threads: 4
    log:
        "results/fastqc/{sample}_fastqc.log"
    shell:
        """
        mkdir -p results/fastqc
        fastqc -t {threads} {input.r1} {input.r2} -o results/fastqc > {log} 2>&1
        """