# 🧬 Snakemake Training

> A minimal and reproducible training environment for learning **Snakemake** workflow management with **Conda** and **Docker Compose**.

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
workflow/
├── Snakefile
├── rules/
│   ├── fastp.smk
│   ├── fastqc.smk
│   └── multiqc.smk
├── envs/
│   └── main.yaml
└── config/
    └── sample.csv
```

---

## 🧪 Useful Commands

Re-run only specific rules:

```bash
snakemake -R fastp --use-conda -j 4
```

Clean up intermediate files:

```bash
snakemake --delete-temp-output
```

Force rebuild of all conda environments:

```bash
rm -rf .snakemake/conda/*
snakemake --use-conda -j 8
```

---

## 🧾 License

MIT License — feel free to use, modify, and share.
