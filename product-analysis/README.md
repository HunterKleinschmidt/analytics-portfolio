# Product Analysis at Klein Training

In this folder, I showcase my ability to assess product performance using Excel and SQL, with a Tableau visualization to tie it all together. The analysis evaluates whether the Klein Training app’s exercise options align with equipment preferences among 1,000+ users, bridging user demand with in-app supply, and includes a targeted view for users with limited equipment.

### Context
At Klein Training, our backend database hasn’t scaled to a point where SQL is practical—yet. With a user base currently below 10,000, Excel meets our needs for agility and simplicity. However, as we plan to grow beyond 10,000 users in the next year, we’re preparing for a robust SQL-based structure to handle increased data volume and complexity. This analysis reflects that transition: starting with my Excel workflow, anticipating a SQL future, and visualizing results in Tableau.

---

## Objective
Assess whether the Klein Training app’s exercise options match equipment popularity among 1,000+ users, comparing user-selected "My Gym" preferences to available exercises, with a sub-analysis for users selecting 2 or fewer equipment types (limited equipment users).

---

## Excel Workflow

### Step 1: Analyzing User Preferences (All Users)

#### Data Source
I used the `my_gym.csv` file exported from our Firebase data pipeline, available in the [data-processing folder](https://github.com/HunterKleinschmidt/analytics-portfolio/tree/main/data-processing). Here’s a sample:

| user_id                  | preferences | translated                          |
|--------------------------|-------------|-------------------------------------|
| 01GvPJsRoCQ8T1Km4WbxapdZc8J2 | DA,C,B,M,P  | Dumbbells, Cable Machines, Barbell & Plates, Med Ball, Weighted Plate |
| 01wfa46RTEchcVZKE9SrbcJDLz53 | N           | Bodyweight                          |
| 07jPEXw0ncfJILL5tQRU7pDqvc83 | R,J,C,DA,K  | Bands, Boxes, Cable Machines, Dumbbells, Kettlebells |

- **Columns**:
  - `user_id`: Unique identifier for each user.
  - `preferences`: Comma-separated codes for equipment selected.
  - `translated`: Human-readable equipment names.

#### Process
1. **Import Data**: Loaded `my_gym.csv` into Excel (1,159 unique rows—users who completed this onboarding step).
2. **Split Translated Column**: Used "Text to Columns" (delimiter: comma) to split `translated` into columns (C:P), isolating equipment names. Each user’s selections are unique per row.
3. **Count Equipment**: Used `COUNTIF` to tally users per equipment type across C:P. Example for Bands: =COUNTIF(C:P, "Bands")
4. **Calculate Percentage**: Divided counts by 1,159 and formatted as percentages. Example: =S8/1159

#### Output: All Users
Based on 1,159 users, exported as `equipment_select_by_all`:

| Equipment              | Quantity | Percentage of Total |
|------------------------|----------|---------------------|
| Dumbbells              | 717      | 61.86%             |
| Bodyweight             | 361      | 31.15%             |
| Barbell & Plates       | 396      | 34.17%             |
| Bands                  | 313      | 27.01%             |
| Boxes                  | 243      | 20.97%             |
| Med Ball               | 210      | 18.12%             |
| Hexbar                 | 133      | 11.48%             |
| Weighted Plate         | 241      | 20.79%             |
| Kettlebells            | 277      | 23.90%             |
| Assault Bike           | 153      | 13.20%             |
| Back Extension Machine | 86       | 7.42%              |
| Swiss Ball             | 106      | 9.15%              |
| Cable Machines         | 259      | 22.35%             |

### Step 2: Analyzing User Preferences (Limited Equipment Users)
Following feedback from Dr. Murphy (Strength and Conditioning stakeholder), I refined the analysis to focus on users with 2 or fewer equipment types selected in their settings.

#### Process
1. **Add Equipment Count**: Inserted a new column to count equipment per user with: =COUNTA(C3:P3). This counts the number of unique equipment types each user has selected
2. **Filter Data**: Filtered the count column for values ≤ 2, identifying 682 users with limited equipment.
3. **Copy to New Sheet**: Copied the filtered rows and pasted (Paste Special > Values Only) into a new sheet.
4. **Count Equipment**: Ran `COUNTIF` on the new sheet across columns C:P. Example for Barbell & Plates: =COUNTIF(C:P, "Barbell & Plates")
5. **Calculate Percentage**: Divided counts by 682 (total limited equipment users) and formatted as percentages. Example: =S5/682


#### Output: Limited Equipment Users
Based on 682 users with ≤ 2 equipment types, exported as `equipment_select_by_select`:

| Equipment              | Quantity | Percentage of Total |
|------------------------|----------|---------------------|
| Dumbbells              | 254      | 37.24%             |
| Bodyweight             | 361      | 52.93%             |
| Barbell & Plates       | 23       | 3.37%              |
| Bands                  | 63       | 9.24%              |
| Boxes                  | 22       | 3.23%              |
| Med Ball               | 6        | 0.88%              |
| Hexbar                 | 1        | 0.15%              |
| Weighted Plate         | 2        | 0.29%              |
| Kettlebells            | 31       | 4.55%              |
| Assault Bike           | 11       | 1.61%              |
| Back Extension Machine | 0        | 0.00%              |
| Swiss Ball             | 6        | 0.88%              |
| Cable Machines         | 17       | 2.49%              |

### Step 3: Analyzing Available Exercises

#### Data Source
Sourced from an internal Excel sheet acting as a holding database for all app exercises. Sample:

| Exercise Name   | Region | Joint # | Muscle | Side | Difficulty | Equipment | Position | Type | Exercise Number |
|-----------------|--------|---------|--------|------|------------|-----------|----------|------|-----------------|
| Bent Lateral Raises | S  | 1       | D      | B    | I          | DA        | S        | 053  | ...             |
| DB Front Raise  | S  | 1       | D      | B    | B          | DA        | S        | 012  | ...             |

- **Key Column**:
- `Equipment`: Codes (e.g., "DA" or "D" for Dumbbells).

#### Process
1. **Extract Equipment**: Copied the `Equipment` column into a new sheet (500 rows).
2. **Count Exercises**: Used `COUNTIF` with wildcards, adjusting for overlap (e.g., "DA" and "D" both count as Dumbbells). Example: =COUNTIF(A2:A500, "DA") + COUNTIF(A2:A500, "D") - COUNTIFS(A2:A500, "DA", A2:A500, "D"). Dragged down for each equipment type.
3. **Summarize Results**: Compiled counts into a table.

#### Available Exercises Output
Based on 500 exercises:

| Equipment              | Exercises per Equipment |
|------------------------|-------------------------|
| Dumbbells              | 78                      |
| Barbell & Plates       | 40                      |
| Bodyweight             | 123                     |
| Bands                  | 27                      |
| Kettlebells            | 25                      |
| Cable Machines         | 28                      |
| Boxes                  | 22                      |
| Weighted Plate         | 9                       |
| Med Ball               | 9                       |
| Assault Bike           | 1                       |
| Swiss Ball             | 3                       |
| Hexbar                 | 4                       |
| Back Extension Machine | 1                       |

---

## Insights
Comparing all users, limited equipment users, and exercise availability:
- **All Users**: Dumbbells (61.86%) and Barbell & Plates (34.17%) dominate, but Barbell & Plates has fewer exercises (40) relative to demand.
- **Limited Equipment Users**: Bodyweight (52.93%) and Dumbbells (37.24%) lead, reflecting simpler setups. Barbell & Plates drops to 3.37%, suggesting it’s less critical for this group.
- **Exercise Supply**: Bodyweight (123) and Dumbbells (78) are well-covered, but Bands (27) and Kettlebells (25) could expand to meet demand from all users (27.01% and 23.90%).

---

## Next Steps
- **SQL Solution**: Replicate this analysis in SQL, including the limited equipment filter.
- **Tableau Visualization**: Create and link a public dashboard to visualize equipment popularity vs. exercise availability, with a limited equipment view.
