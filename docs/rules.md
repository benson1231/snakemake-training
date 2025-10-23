# 🧬 Snakemake 常見語法與 Rule 元件對照表

本文件整理 Snakemake 的常見語法結構與各元素功能，並附中文說明。

---

## 🧩 Snakemake 語法總覽

| 元件             | 語法範例                                                     | 說明                                      |
| -------------- | -------------------------------------------------------- | --------------------------------------- |
| **statement**  | 通常是一個可執行語句，例如 `shell`, `run`, `script`                   | Snakemake 執行單位，可用 Python 或 shell。       |
| **rule**       | `rule trim_reads:`                                       | 定義一個執行任務的規則（Rule）。每個 rule 通常對應一個分析步驟。   |
| **include**    | `include: "rules/fastqc.smk"`                            | 匯入外部 Snakefile，便於模組化管理流程。               |
| **workdir**    | `workdir: "/workspace/workflow"`                         | 指定工作目錄，所有相對路徑將以此為基準。                    |
| **module**     | `module qc:`                                             | 定義模組化的 Snakemake 子流程。可透過 `use rule` 調用。 |
| **configfile** | `configfile: "config/config.yaml"`                       | 載入設定檔，供全域變數與 rule 使用。                   |
| **container**  | `container: "docker://biocontainers/fastqc:v0.12.1_cv8"` | 指定 rule 執行時使用的容器環境。                     |

---

## 🧱 Rule 結構基本語法

### 📘 定義格式

```python
rule <rule_name>:
    input:
        <輸入檔路徑>
    output:
        <輸出檔路徑>
    params:
        <額外參數>
    threads: <數量>
    log: <log 檔路徑>
    conda: <conda 環境路徑>
    shell:
        """<執行命令>"""
```

---

### 🧩 Rule 區塊內容說明

| 區塊            | 語法                                                          | 說明                                        |
| ------------- | ----------------------------------------------------------- | ----------------------------------------- |
| **input**     | `input: "data/sample1_R1.fastq.gz"`                         | 指定輸入檔案，可使用 lambda 或 expand() 生成動態路徑。      |
| **output**    | `output: "results/sample1.trimmed.fastq.gz"`                | 定義執行後要產出的檔案；Snakemake 以此追蹤任務是否完成。         |
| **params**    | `params: quality=20, adapter="AGATCGGAAGAGC"`               | 傳遞額外參數至 shell 指令或 Python 腳本。              |
| **threads**   | `threads: 4`                                                | 指定任務使用的 CPU 執行緒數。                         |
| **resources** | `resources: mem_mb=4000, time="02:00:00"`                   | 指定資源使用量，用於 HPC 或 cluster 環境。              |
| **log**       | `log: "log/fastqc/{sample}.log"`                            | 指定輸出 log 位置。常與 `> {log} 2>&1` 搭配使用。       |
| **conda**     | `conda: "envs/fastqc.yaml"`                                 | 定義該 rule 專屬的 Conda 環境。Snakemake 會自動建立與快取。 |
| **container** | `container: "docker://biocontainers/fastp:v0.23.4_cv8"`     | 以容器形式執行 rule，確保跨系統可重現性。                   |
| **message**   | `message: "Running quality control for {wildcards.sample}"` | 在執行前印出提示訊息。                               |
| **benchmark** | `benchmark: "benchmarks/fastqc/{sample}.txt"`               | 紀錄執行時間與資源使用狀況。                            |
| **priority**  | `priority: 50`                                              | 設定執行優先順序。數值越大，越早執行。                       |
| **cache**     | `cache: True`                                               | 允許該 rule 的輸出被快取以重複使用。                     |
| **run**       | `run:` → Python 程式區塊                                        | 使用 Python 程式邏輯直接執行分析任務。                   |
| **shell**     | `shell: "fastqc {input} -o {output}"`                       | 以 shell 指令執行外部程式。最常見的形式。                  |
| **script**    | `script: "scripts/trim.py"`                                 | 執行 Python 腳本（自動傳入 snakemake 物件）。          |
| **notebook**  | `notebook: "notebooks/qc.ipynb"`                            | 執行 Jupyter Notebook 並可生成報告。               |

---

## 🧩 模組與重用語法

| 語法           | 範例                                        | 功能                   |
| ------------ | ----------------------------------------- | -------------------- |
| **use rule** | `use rule * from qc`                      | 從 module 中匯入多個 rule。 |
| **as**       | `use rule trim from qc as trim_reads`     | 匯入後重新命名 rule。        |
| **with**     | `use rule fastqc from qc with: threads=2` | 匯入後覆寫參數設定。           |

---

## 🧰 其他全域語法

| 指令             | 語法                                         | 說明                                 |
| -------------- | ------------------------------------------ | ---------------------------------- |
| **configfile** | `configfile: "config/config.yaml"`         | 匯入 YAML 設定檔。可用 `config["key"]` 取值。 |
| **workdir**    | `workdir: "/data/project"`                 | 改變全域執行目錄。所有路徑皆以此為基準。               |
| **module**     | `module qc:` + `snakefile: "rules/qc.smk"` | 定義一個可重用的 Snakemake 子流程模組。          |
| **include**    | `include: "rules/fastp.smk"`               | 直接引入另一份 Snakefile。                 |

---

## 🔁 常見結構對照

| 區塊          | 說明                        | 範例                                                            |
| ----------- | ------------------------- | ------------------------------------------------------------- |
| `rule all`  | 定義最終目標，Snakemake 會追蹤其所有依賴 | `input: expand("results/{sample}.txt", sample=SAMPLES)`       |
| `onsuccess` | 全部 rule 成功後執行             | `onsuccess: shell("snakemake --report report/pipeline.html")` |
| `onerror`   | pipeline 出錯時執行            | `onerror: shell("echo 'error' > failed.log")`                 |

---

## 🧠 小結

Snakemake 的核心設計是以 **Rule 為單位**，每個 rule 定義：

* 要用哪些輸入檔 (`input`)
* 產生哪些輸出 (`output`)
* 使用何種環境 (`conda` / `container`)
* 如何執行 (`shell` / `script` / `run`)

掌握這些語法組合後，就能建立模組化、可重現的生物資訊分析流程。
