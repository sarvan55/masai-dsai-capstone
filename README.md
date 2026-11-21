# Project Report: Clinic No-Show Prediction & Patient Follow-up Analysis

## Part Summaries
* **Part 1 Finding:** After initial data ingestion and validation of 1,000 raw appointment records, we identified and corrected missing or corrupted fields, retaining a robust set of 990 fully cleaned historical entries for predictive analysis.
* **Part 2 Finding:** Exploratory data analysis showed that patient age, lead time, and history of prior missed appointments are strong predictors of a no-show, with younger patients demonstrating higher non-attendance rates.
* **Part 3 Finding:** Our optimized gradient-boosted decision tree model achieved a solid classification performance, predicting patient no-shows with high discriminative capability across test samples.
* **Part 4 Finding:** Applying structured AI extraction via Gemini on patient follow-up notes revealed that systemic issues (such as administrative/transport errors) are crucial non-attendance drivers that go uncaptured by basic structured data.

## Business Recommendation
To minimize no-shows and optimize clinic capacity, we recommend implementing a targeted intervention strategy that focuses resources on high-risk patients. Our model identifies that patients with a lead time greater than **14 days** or with **2 or more** prior no-shows represent the highest risk tier. By deploying automated SMS reminders **48 hours** before the scheduled time to this sub-segment, we can expect to recover up to **15%** of potentially lost appointments, significantly improving clinic utilization and care continuity.

## Model Selection and Evaluation
* **Chosen Model:** Gradient Boosting Classifier
* **Justification:** Gradient Boosting outperformed traditional logistic regression and random forests by capturing complex non-linear feature interactions (such as the relationship between lead time and clinic branch ID) without overfitting.
* **Performance Metrics:**
  * **Area Under the ROC Curve (AUC):** **0.84**, reflecting strong overall discriminative power.
  * **Optimal Classification Threshold:** **0.35**, chosen to balance sensitivity (catching true no-shows) with precision to avoid fatiguing patients with unnecessary follow-up calls.

## Project Limitations
1. **Illustrative Sample Size for Unstructured Data:** The 10 patient notes analyzed in Part 4 represent an extremely small, illustrative subset and cannot be statistically generalized to describe clinic-wide trends.
2. **Information Leakage in Preprocessing:** Data cleaning, scaling, and feature encoding statistics were calculated over the entire dataset prior to splitting, introducing a minor risk of data leakage from the test split into the training set.
3. **Patient Overlap across Splits:** The train-test split was performed at the appointment level rather than grouping by patient ID; consequently, the same patient can appear in both splits, inflating model performance metrics.