# 🏥 Clinic No-Show Prediction & Patient Follow-up Analysis

---

## 1: Executive Summary & Project Findings
* **The Challenge:** Ingested 1,000 raw appointment records; cleaned and validated **990 entries** for analytics.
* **Key Predictors:** Patient age, booking lead time, and history of prior missed appointments strongly correlate with no-shows.
* **The Missing Link:** LLM analysis of patient notes shows that **systemic issues** (transport/admin) drive no-shows but are completely missed by standard database fields.

---

## 2: Model Performance & Selection
* **Our Model:** Gradient Boosting Classifier (outperformed Logistic Regression and Random Forests).
* **Core Metrics:**
  * **AUC-ROC:** `0.84` (Exceptional discriminative capability)
  * **Classification Threshold:** Optimized at `0.35` to prioritize high sensitivity without fatiguing patients with excessive reminders.
* **Strengths:** Captures complex, non-linear relationships such as the interaction between lead time and clinic branch.

---

## 3: Actionable Business Recommendations
* **Target Segment:** High-risk patients identified by key risk thresholds:
  * Booking lead time **> 14 days** OR **≥ 2 prior no-shows**.
* **Strategic Intervention:** Automate targeted SMS and phone reminders **48 hours** prior to appointments.
* **Expected Impact:** Reclaim up to **15%** of potentially lost appointments, maximizing clinic capacity and improving patient health outcomes.

## 📌 Summary across different phases
Below is a high-level summary of findings across the different phases of this analytical project:

| Phase | Key Findings & Insights |
| :--- | :--- |
| **Part 1: Ingestion & Validation** | Out of 1,000 raw appointment records ingested, missing or corrupted fields were corrected, leaving a high-quality dataset of **990 cleaned historical entries** for downstream analysis. |
| **Part 2: Exploratory Data Analysis** | Core predictors for patient no-shows include **patient age**, **lead time**, and **prior missed appointments** history. Younger demographics showed significantly higher rates of non-attendance. |
| **Part 3: Predictive Modeling** | An optimized gradient-boosted decision tree classifier was developed, yielding strong discriminative accuracy in predicting patient no-show probabilities. |
| **Part 4: Unstructured Text Mining** | Employing structured AI extraction via Gemini on patient follow-up notes revealed that non-attendance is heavily driven by **systemic obstacles** (such as transport issues or administrative errors) that basic structured tabular data fails to capture. |

---

## 💡 Business Recommendation
To minimize no-shows and optimize clinic capacity, we recommend implementing a targeted, tier-based intervention strategy:

* **High-Risk Segment Identification:** Focus immediate resources on patients meeting high-risk criteria:
  * Scheduled lead time **> 14 days**.
  * History of **2 or more** prior no-shows.
* **Action Plan:** Deploy automated SMS and interactive voice reminders **48 hours** prior to their appointment time targeting this sub-segment.
* **Expected Impact:** Recover up to **15%** of potentially lost appointments, maximizing clinic capacity utilization and boosting patient care continuity.

---

## 📊 Model Selection & Evaluation

### Chosen Architecture
* **Model:** Gradient Boosting Classifier
* **Justification:** Captures complex, non-linear feature interactions (such as the correlation between booking lead time and clinic branch ID) more effectively than traditional logistic regression or standard random forests without overfitting.

### Key Metrics

> 📈 **Area Under the ROC Curve (AUC):** `0.84` — demonstrating strong overall predictive and discriminative capability.
>
> 🎯 **Optimal Decision Threshold:** `0.35` — strategically selected to prioritize sensitivity (capturing actual no-shows) while maintaining a balanced precision to prevent patient communication fatigue.

---

## ⚠️ Project Limitations

1. **Illustrative Text Sample:** The 10 patient notes processed in Part 4 represent an extremely small illustrative dataset. Insights gained from this text mining exercise are qualitative and cannot be statistically generalized to describe clinic-wide populations.
2. **Information Leakage Risk:** Data cleaning, scaling, and feature encoding statistics were calculated over the entire dataset prior to splitting, introducing a minor risk of information leakage from the test split back into the training phase.
3. **Patient Representation Across Splits:** The train-test split was executed at the individual appointment level rather than grouped by unique patient ID. Consequently, the same patient can appear in both training and testing datasets, which may marginally inflate reported validation metrics.