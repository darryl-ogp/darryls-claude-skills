---
name: data-classification
description: Classify a data point (e.g. a document, field, or piece of information handled in a government/agency context) according to the Singapore Public Sector Data Security Classification and Info Sensitivity framework. Use this skill whenever the user asks "what classification should X be", "how should I classify this data", "is this Restricted/Confidential/Secret", "is this Sensitive Normal/High", or gives you a data point and wants its Security Classification and/or Sensitivity Classification determined. Also use when the user wants to bulk-classify a list of data points, or wants a justification for why a data point is or isn't classified at a given level.
---

# Data Classification (Security & Sensitivity)

This skill applies the Public Sector Data Security Classification and Info Sensitivity framework to a given data point (a document, dataset, field, or piece of information), and outputs its classification with justification.

There are **two independent classification axes**. A data point should normally be assessed against both unless the user asks for only one.

## Axis 1: Security Classification
Measures damage to **national security, national interests, or an Agency** if disclosed without authorisation.

Walk the decision tree top-down, stopping at the first "yes":

1. Would unauthorised disclosure cause **serious damage to national security or interests**? → **Secret** (or **Top Secret** if it causes *exceptionally grave* damage to national security)
2. Would it cause **some damage to national interests, or serious damage to an Agency**? → **Confidential**
   - Sub-check: if the CONFIDENTIAL data *only* causes serious damage to an Agency, and **no** damage to national interests → relabel as **Confidential (Cloud-Eligible)**
3. Would it cause **some damage to an Agency**? → **Restricted**
4. Is the information disclosed to the public in the normal course of duty? → **Official (Open)**
5. Otherwise → **Official (Closed)**

Reference table:

| Level | Meaning |
|---|---|
| Official (Open) | Usually disclosed on a public domain. Cannot contain Sensitive Normal or Sensitive High data. |
| Official (Closed) | Usually not disclosed to the public in the normal course of duty. |
| Restricted | Causes some damage to an Agency. |
| Confidential | Causes some damage to national interests, or serious damage to an Agency. |
| Confidential (Cloud-Eligible) | Confidential data that ONLY causes serious damage to an Agency, with NO damage to national interests. |
| Secret | Causes serious damage to national security or interests. |
| Top Secret | Causes exceptionally grave damage to national security. |

(Official Open/Closed were previously termed "Unclassified".)

## Axis 2: Sensitivity Classification
Measures damage to an **individual or business** if disclosed without authorisation.

Walk the decision tree top-down, stopping at the first "yes":

1. Would unauthorised disclosure cause **serious damage** to individuals or businesses (e.g. loss of life/physical harm, loss of employability/reputation/insurability for individuals; inability to conduct normal business operations, significant/irreversible loss of competitive advantage, major reputational damage for businesses)? → **Sensitive High**
2. Would it cause **some damage** (e.g. temporary/minor emotional distress for individuals; loss of potential business opportunities or minor reputational damage for businesses)? → **Sensitive Normal**
3. Otherwise (negligible or no damage, e.g. publicly disclosed contact info) → **Non-Sensitive**

## How to respond

Default output format (unless the user specifies a different format or asks for only one axis):

```
**<Security Classification> / <Sensitivity Classification>**
<1 sentence justification for why this level, on both axes as relevant>
<1 sentence reasoning for why not one level lower or higher>
```

Guidelines:
- Always reason through *both* decision trees explicitly (even if only reporting one), starting from the top/most severe condition and working down — don't skip straight to a guess.
- Be concrete about *who* is harmed (an individual, a business, an Agency, or national security) since that's what distinguishes the two axes.
- If the user gives a **list** of data points, produce one classification block per item, in the same format, without extra preamble.
- If the data point plausibly spans multiple classifications depending on context (e.g. "salary" could be Sensitive Normal in aggregate/anonymised form but Sensitive High when tied to a named candidate), briefly note the assumption you're making about the context (e.g. "assuming this is tied to a specific named individual").
- If a Confidential-level item's harm is purely to an Agency and not to national interests, remember to apply the Cloud-Eligible sub-label.
- Don't add extra commentary, disclaimers, or restate the whole framework back to the user — just the classification and reasoning.

## Worked example

Input: "A candidate's salary offer gathered during a hiring process"

Output:
```
**Official (Closed) / Sensitive High**
Salary offer data is not routinely disclosed to the public, and its unauthorised release could cause serious damage to the individual (e.g. loss of employability, reputational harm, or disadvantage in future negotiations).
A lower Sensitivity level would understate the harm since this goes beyond minor distress; a higher Security level is unwarranted since this is routine agency HR data with no bearing on national security or interests.
```