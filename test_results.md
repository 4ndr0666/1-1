## 🧠 1=1 Instruction → Execution Lifecycle

### 🔹 Phase 1: `run_input` (User Feedback Format to GPT)

This is the **expected format** a human should return to 1=1 when reporting execution results:

````markdown
# 🧪 Run Result

## 📄 Script
<name-of-script>

## 🕒 Timestamp
<auto or manual timestamp>

## **Terminal Output**
```sh
<actual shell output, unmodified>
````

## 📋 Feedback

\<your observation, notes, concerns, suggestions>

````

> ✅ Minimal required sections: `Script`, `Terminal Output`  
> Optional: `Timestamp`, `Feedback`

---

### 🔹 Phase 2: `run_report` (GPT Response Format)

This is the **standardized format GPT must return** upon receiving results in `run_input`:

```markdown
# 🧪 Run Report — <script_or_action_name>

| Field           | Value                                                       |
|----------------|-------------------------------------------------------------|
| 📄 Script       | `n8n_dataset_aggregator.sh`                                 |
| 💥 Exit Code    | `0` or `1`, etc.                                            |
| 🕒 Timestamp    | 2025-05-08 HH:MM CDT                                        |
| 📂 Target Path  | `/home/user/target/`                                        |
| 📋 Status       | ✅ Success / ❌ Failure — <explanation>                      |
| 🧾 Last Output  | <1–2 line final message or error>                           |
| 🧭 Root Cause   | <likely cause if failure>                                   |
| 🧹 Cleanup Ran? | ✅ Yes / ❌ No / — Not applicable                            |

---

### 🔍 Observations
- Bullet summary of pattern recognition, script behavior, or novel issues.

---

### 🛠️ Fix Plan
- Enumerated suggestions, if any
- Possible traps, log improvement, or robustness patch
````

---

## 🔁 Final Use Case

After every executable or command:

1. Human returns `run_input`
2. GPT responds with `run_report`
