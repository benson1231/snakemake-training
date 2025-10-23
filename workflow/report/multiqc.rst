multiqc – Aggregated Report
===========================

**Rule:** ``multiqc``

Combines results from FastQC and Fastp into a single, interactive HTML report
using `MultiQC <https://multiqc.info/>`_.

Outputs
-------

* ``results/multiqc/multiqc_report.html``

Description
-----------

MultiQC parses all logs and QC reports in the ``results`` directory,
producing a consolidated summary for easy interpretation of data quality.

Example Command
---------------

.. code-block:: bash

    multiqc results -o results/multiqc

Report Example
--------------

.. image:: ../results/multiqc/multiqc_report.html
   :alt: MultiQC summary report
   :width: 700
