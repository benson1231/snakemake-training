fastp – Read Trimming
=====================

**Rule:** ``fastp``

This step performs adapter and quality trimming on paired-end FASTQ files
using `fastp <https://github.com/OpenGene/fastp>`_.

Outputs
-------

* ``results/fastp/{sample}_R1.trim.fastq.gz``
* ``results/fastp/{sample}_R2.trim.fastq.gz``
* ``results/fastp/{sample}_fastp.html``
* ``results/fastp/{sample}_fastp.json``

Description
-----------

This rule ensures high-quality reads by removing adapter contamination,
filtering low-quality bases, and generating per-sample quality reports.

Example Command
---------------

.. code-block:: bash

    fastp -i {input.r1} -I {input.r2} \
          -o {output.r1_trim} -O {output.r2_trim} \
          -h {output.html} -j {output.json} -w {threads}

Report Example
--------------

.. image:: ../results/fastp/a.chr21_fastp.html
   :alt: fastp quality report
   :width: 600
