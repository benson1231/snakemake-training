rule finish:
    input:
        html = "results/multiqc/multiqc_report.html"
    output:
        txt = "results/finish.txt"
    conda:
        "../envs/main.yaml"
    threads: 4
    log:
        "results/finish.log"
    shell:
        """
        mkdir -p $(dirname {output.txt})
        python ./scripts/finish.py $(dirname {output.txt}) > {log} 2>&1
        """