# Product Analysis at Klein Training

This analysis assesses product performance in the Klein Training app using Excel, with a SQL replication in Google BigQuery and a planned Tableau visualization. It compares user-selected "My Gym" equipment preferences to available exercises, refining insights through cross-tool validation.

## Context
At Klein Training, our user base is below 10,000, making Excel practical for now. As we plan to scale beyond 10,000 users in the next year, I’ve replicated the analysis in SQL—see [SQL Workflow Details](./sql-workflow/README.md) for the BigQuery implementation.

## Objective
Evaluate whether the app’s exercise options match equipment popularity among 1,159 users, with a sub-analysis for users selecting ≤ 2 equipment types. Improve stakeholder decision-making and resource allocation when users complain about variety.

---

## Excel Workflow

### Step 1: User Preferences (All Users)

#### Data Source
Used `my_gym.csv` from the [data-processing folder](https://github.com/HunterKleinschmidt/analytics-portfolio/tree/main/data-processing). Sample:

| user_id                  | preferences | translated                          |
|--------------------------|-------------|-------------------------------------|
| 01GvPJsRoCQ8T1Km4WbxapdZc8J2 | DA,C,B,M,P  | Dumbbells, Cable Machines, Barbell & Plates, Med Ball, Weighted Plate |
| 01wfa46RTEchcVZKE9SrbcJDLz53 | N           | Bodyweight                          |

#### Process
1. **Import Data**: Loaded `my_gym.csv` (1,159 rows).
2. **Split Translated**: Used "Text to Columns" (delimiter: comma) to split `translated` into C:P.
3. **Count Unique Users**: Flagged equipment presence per row with `=IF(COUNTIF(C2:P2, "Hexbar")>0, 1, 0)` in column Q, then summed (e.g., `=SUM(Q2:Q1160)`).
4. **Calculate Percentage**: Divided by 1,159 and formatted as percentages.

#### Output: All Users
Initially overcounted "Hexbar" as 133 due to duplicates (29 users listed it twice). Adjusted to 104 unique users after SQL validation:

| Equipment              | Quantity | Percentage of Total |
|------------------------|----------|---------------------|
| Dumbbells              | 717      | 61.86%             |
| Barbell & Plates       | 396      | 34.17%             |
| Bodyweight             | 361      | 31.15%             |
| Bands                  | 313      | 27.01%             |
| Kettlebells            | 277      | 23.90%             |
| Cable Machines         | 259      | 22.35%             |
| Boxes                  | 243      | 20.97%             |
| Weighted Plate         | 241      | 20.79%             |
| Med Ball               | 210      | 18.12%             |
| Assault Bike           | 153      | 13.20%             |
| Hexbar                 | 104      | 8.97%              |
| Swiss Ball             | 106      | 9.15%              |
| Back Extension Machine | 86       | 7.42%              |

### Step 2: User Preferences (Limited Equipment Users)
#### Process
1. **Count Equipment**: Added column R with `=COUNTA(C2:P2)`.
2. **Filter**: Filtered R for ≤ 2 (682 users).
3. **Copy**: Pasted filtered rows (values only) to a new sheet.
4. **Count and Calculate**: Used `COUNTIF` and divided by 682.

#### Output: Limited Equipment Users
| Equipment              | Quantity | Percentage of Total |
|------------------------|----------|---------------------|
| Bodyweight             | 361      | 52.93%             |
| Dumbbells              | 254      | 37.24%             |
| Bands                  | 63       | 9.24%              |
| Kettlebells            | 31       | 4.55%              |
| Barbell & Plates       | 23       | 3.37%              |
| Boxes                  | 22       | 3.23%              |
| Cable Machines         | 17       | 2.49%              |
| Assault Bike           | 11       | 1.61%              |
| Med Ball               | 6        | 0.88%              |
| Swiss Ball             | 6        | 0.88%              |
| Weighted Plate         | 2        | 0.29%              |
| Hexbar                 | 1        | 0.15%              |
| Back Extension Machine | 0        | 0.00%              |

### Step 3: Available Exercises
#### Data Source
Internal Excel sheet (500 exercises). Sample:

| Exercise Name       | Equipment |
|---------------------|-----------|
| Bent Lateral Raises | DA        |

#### Process
1. **Extract Equipment**: Copied `Equipment` column.
2. **Count**: Used `=COUNTIF(A2:A500, "*DA*") + COUNTIF(A2:A500, "*D*") - COUNTIFS(A2:A500, "*DA*", A2:A500, "*D*")` for Dumbbells, dragged down.

#### Output
| Equipment              | Exercises |
|------------------------|-----------|
| Dumbbells              | 78        |
| Barbell & Plates       | 40        |
| Bodyweight             | 123       |
| Bands                  | 27        |
| Kettlebells            | 25        |
| Cable Machines         | 28        |
| Boxes                  | 22        |
| Weighted Plate         | 9         |
| Med Ball               | 9         |
| Assault Bike           | 1         |
| Swiss Ball             | 3         |
| Hexbar                 | 4         |
| Back Extension Machine | 1         |

---

## Insights
- **All Users**: Dumbbells (61.86%) and Barbell & Plates (34.17%) lead, but Barbell & Plates (40 exercises) is undersupplied. Hexbar’s 104 users (8.97%) reflect unique counts, corrected from 133 mentions.
- **Limited Users**: Bodyweight (52.93%) and Dumbbells (37.24%) dominate, well-supported by 123 and 78 exercises.
- **Variety Complaints**:
  - **Limited Users**: Ample options suggest program fatigue—focus on curation.
  - **Standard Users**: Shortages (e.g., Barbell & Plates) indicate exercise development needs.
- **Resource Allocation**: Prioritize program tweaks for limited users, new exercises for standard users.

---

## Next Steps
- **SQL Workflow**: See [details](./sql-workflow/README.md) for BigQuery replication.
- **Tableau**: See [tableau]([./sql-workflow/README.md](https://public.tableau.com/views/EquipmentPreferencesandExerciseAvailabilityAnalysis/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)) for final dashboard shared with stakeholders.
