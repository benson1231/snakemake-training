# 🧬 Snakemake Training

A fully reproducible, containerized environment for learning and testing Snakemake workflows — built with Conda (libmamba) and Docker Compose. Designed for both beginners and workflow developers who want to explore reproducible bioinformatics pipelines in an isolated, consistent setup.

---

## 🚀 Quick Start

### 1️⃣ Clone the repository

```bash
git clone https://github.com/yourname/snakemake-training.git
cd snakemake-training
```

### 2️⃣ Launch Snakemake container

Run Snakemake inside a clean Docker environment:

```bash
docker compose run --rm snakemake
```

This starts an interactive shell at `/workspace/workflow/`, ready for running Snakemake commands.

---

## 🧩 Example Workflow

Run the included workflow that demonstrates typical bioinformatics preprocessing:

* **fastp** for read trimming
* **fastqc** for quality control
* **multiqc** for aggregated reporting

Execute inside the container:

```bash
snakemake --use-conda -j 8

# run with report
snakemake --use-conda -j 8 --report results/pipeline_report.html --report-after-run
```

Snakemake will automatically:

1. Build Conda environments (via libmamba)
2. Execute all rules (`fastp → fastqc → multiqc`)
3. Store outputs in the `results/` directory

---

## 🧰 Environment Management

All dependencies are managed through **Conda (libmamba)** within the container.

### Environment file: `workflow/envs/main.yaml`

```yaml
name: main_env
channels:
  - conda-forge
  - bioconda
  - defaults
channel_priority: strict
dependencies:
  - python=3.10
  - fastp=0.23.4
  - fastqc=0.12.1
  - multiqc=1.21
```

This ensures reproducibility and compatibility across machines.

---

## 📁 Project Structure

```
docker-compose.yaml
docs/
workflow/
├── Snakefile
├── rules/
│   ├── fastp.smk
│   ├── fastqc.smk
│   └── multiqc.smk
├── envs/
│   └── main.yaml
├── data/
├── report/
├── results/
└── config/
    └── sample.csv
```
