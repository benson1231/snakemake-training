fastqc – Quality Control
=========================

**Rule:** ``fastqc``

Performs quality control on FASTQ files using
`FastQC <https://www.bioinformatics.babraham.ac.uk/projects/fastqc/>`_.

Outputs
-------

* ``results/fastqc/{sample}_R1_fastqc.html``
* ``results/fastqc/{sample}_R2_fastqc.html``
* ``results/fastqc/{sample}_R1_fastqc.zip``
* ``results/fastqc/{sample}_R2_fastqc.zip``

Description
-----------

FastQC provides detailed metrics on per-base sequence quality, GC content,
adapter contamination, and read duplication levels.

Example Command
---------------

.. code-block:: bash

    fastqc -t {threads} {input.r1} {input.r2} -o results/fastqc

Report Example
--------------

.. image:: ../results/fastqc/a.chr21_R1_fastqc.html
   :alt: FastQC report example
   :width: 600
