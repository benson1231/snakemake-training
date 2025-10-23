# 🧭 Snakemake 常見 CLI 指令總覽

以下整理 Snakemake 在實務中最常使用的指令與參數，搭配範例與用途說明。

---

## 🚀 基本執行指令

| 指令                 | 說明                              | 範例                         |
| ------------------ | ------------------------------- | -------------------------- |
| `snakemake`        | 執行整個流程（依據 `rule all` 追蹤依賴）      | `snakemake -j 4`           |
| `snakemake -n`     | 模擬執行（不實際執行命令，只預覽 DAG 與任務）       | `snakemake -n -p`          |
| `snakemake -p`     | 顯示每條 shell 指令內容（printshellcmds） | `snakemake -p --use-conda` |
| `snakemake -j <N>` | 指定同時執行的執行緒數                     | `snakemake -j 8`           |
| `snakemake -F`     | 強制重新執行所有 rule（即使輸出已存在）          | `snakemake -F -j 4`        |

---

## ⚙️ Conda 與環境管理

| 指令                         | 說明                    | 範例                                                        |
| -------------------------- | --------------------- | --------------------------------------------------------- |
| `--use-conda`              | 啟用 rule 中定義的 Conda 環境 | `snakemake --use-conda -j 8`                              |
| `--conda-prefix`           | 指定 Conda 環境快取位置       | `snakemake --use-conda --conda-prefix ~/.snakemake/conda` |
| `--conda-cleanup-pkgs all` | 清除暫存環境（節省空間）          | `snakemake --conda-cleanup-pkgs all`                      |

---

## 🧩 輸出與報告

| 指令                | 說明                           | 範例                                        |                      |
| ----------------- | ---------------------------- | ----------------------------------------- | -------------------- |
| `--report <path>` | 生成 HTML 報告，整合 rule、log 與環境資訊 | `snakemake --report report/pipeline.html` |                      |
| `--summary`       | 顯示輸入、輸出、狀態與上次執行時間            | `snakemake --summary`                     |                      |
| `--list`          | 列出所有可執行的 rules               | `snakemake --list`                        |                      |
| `--rulegraph`     | 匯出工作流程關係圖（dot 格式）            | `snakemake --rulegraph                    | dot -Tpng > dag.png` |
| `--dag`           | 顯示 DAG（資料流程圖）                | `snakemake --dag                          | dot -Tpdf > dag.pdf` |
| `--d3dag`         | 以互動式 HTML 形式產生 DAG 圖         | `snakemake --d3dag > dag.html`            |                      |

---

## 🔁 執行控制與除錯

| 指令                   | 說明                    | 範例                             |
| -------------------- | --------------------- | ------------------------------ |
| `-R <rule>`          | 只重新執行特定 rule（不重跑全部）   | `snakemake -R fastqc`          |
| `--until <rule>`     | 只執行到指定 rule 為止        | `snakemake --until multiqc`    |
| `--omit-from <rule>` | 跳過指定 rule（不執行該步驟）     | `snakemake --omit-from finish` |
| `--forcerun <rule>`  | 強制重新執行指定 rule         | `snakemake --forcerun multiqc` |
| `--touch`            | 建立空輸出檔模擬完成狀態          | `snakemake --touch`            |
| `--dry-run`          | 同 `-n`，只顯示計畫執行內容不實際執行 | `snakemake --dry-run -p`       |
| `--rerun-incomplete` | 重新執行先前中斷或不完整的任務       | `snakemake --rerun-incomplete` |
| `--latency-wait`     | 等待輸入檔可用（常用於 HPC）      | `snakemake --latency-wait 60`  |

---

## 🧠 訊息與除錯模式

| 指令                 | 說明                     | 範例                           |
| ------------------ | ---------------------- | ---------------------------- |
| `-r`               | 顯示執行 rule 的理由（為何要重跑）   | `snakemake -r`               |
| `-p`               | 顯示所有 shell 指令內容        | `snakemake -p`               |
| `-q`               | 安靜模式，不輸出 log           | `snakemake -q`               |
| `--printshellcmds` | 同 `-p`，顯示命令行內容         | `snakemake --printshellcmds` |
| `--reason`         | 顯示 Snakemake 判定需要重跑的原因 | `snakemake --reason`         |

---

## 🧾 工作流程資訊

| 指令          | 說明                     | 範例                    |
| ----------- | ---------------------- | --------------------- |
| `--lint`    | 檢查 Snakefile 語法錯誤與風格問題 | `snakemake --lint`    |
| `--version` | 顯示版本                   | `snakemake --version` |
| `--help`    | 顯示完整幫助頁面               | `snakemake --help`    |

---

## ⚡ 實用組合範例

### 一次完整跑流程（含 Conda）

```bash
snakemake --use-conda -j 8 --printshellcmds
```

### 模擬檢查 DAG

```bash
snakemake -n --dag | dot -Tpng > dag.png
```

### 自動生成報告

```bash
snakemake --use-conda -j 8 --report report/pipeline_report.html
```

### 僅重跑 multiqc

```bash
snakemake -R multiqc --use-conda -j 4
```

### 清除暫存環境與中斷任務

```bash
snakemake --conda-cleanup-pkgs all --rerun-incomplete
```

---

## 🧩 小結

* `-n` / `--dry-run`：模擬執行。
* `--use-conda`：啟用 Conda 環境。
* `--report`：生成 HTML 報告。
* `-R` / `--forcerun`：指定重跑 rule。
* `--dag` / `--rulegraph`：視覺化工作流程。
* `--summary` / `--lint`：流程資訊檢查。

熟練這些 CLI 指令後，你就能靈活地控制整個 Snakemake pipeline 的除錯、重跑與報告生成流程。
