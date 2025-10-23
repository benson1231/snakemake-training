finish – Pipeline Completion
============================

**Rule:** ``finish``

This final step records the successful completion of the workflow,
writing a timestamp and success message to ``results/finish.txt``.

Outputs
-------

* ``results/finish.txt``
* ``results/finish.log``

Description
-----------

This rule confirms that all previous steps have completed successfully.
It serves as the final checkpoint in the Snakemake pipeline.

Example Command
---------------

.. code-block:: bash

    python ./scripts/finish.py results

Example Output
--------------

.. code-block:: text

    [2025-10-23 22:40:00] Pipeline finished successfully!

