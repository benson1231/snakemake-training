rule fastp:
    input:
        r1 = lambda wc: f"data/{SAMPLES[wc.sample]['r1']}",
        r2 = lambda wc: f"data/{SAMPLES[wc.sample]['r2']}"
    output:
        r1_trim = "results/fastp/{sample}_R1.trim.fastq.gz",
        r2_trim = "results/fastp/{sample}_R2.trim.fastq.gz",
        html = "results/fastp/{sample}_fastp.html",
        json = "results/fastp/{sample}_fastp.json"
    conda:
        "../envs/main.yaml"
    threads: 4
    log:
        "results/fastp/{sample}_fastp.log"
    shell:
        """
        mkdir -p results/fastp
        fastp \
            -i {input.r1} -I {input.r2} \
            -o {output.r1_trim} -O {output.r2_trim} \
            -h {output.html} -j {output.json} \
            -w {threads} > {log} 2>&1
        """