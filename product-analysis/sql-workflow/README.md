# SQL Workflow for Product Analysis

This subfolder replicates the Excel-based product analysis in Google BigQuery, validating and refining user preferences data from the Klein Training app. It ensures scalability for future growth beyond 10,000 users and corrects discrepancies like duplicate "Hexbar" counts identified in the Excel process.

## Setup

The analysis begins with `my_gym.csv`, uploaded to BigQuery as `kleintrainingapp.mygymdata.my_gym` with 1,159 rows. Initial generic column names (`string_field_0`, etc.) were renamed to `user_id`, `preferences`, and `translated`, and the `translated` column was normalized into a `user_equipment` table. A reference list of distinct equipment types was also created.

The setup process uses: CREATE TABLE `kleintrainingapp.mygymdata.my_gym_cleaned` AS SELECT string_field_0 AS user_id, string_field_1 AS preferences, string_field_2 AS translated FROM `kleintrainingapp.mygymdata.my_gym`; followed by CREATE TABLE `kleintrainingapp.mygymdata.user_equipment` AS SELECT user_id, TRIM(equipment) AS equipment FROM `kleintrainingapp.mygymdata.my_gym_cleaned`, UNNEST(SPLIT(translated, ',')) AS equipment WHERE translated IS NOT NULL AND TRIM(equipment) != 'translated' AND equipment IS NOT NULL AND LENGTH(TRIM(equipment)) > 0; and finally CREATE TABLE `kleintrainingapp.mygymdata.equipment_list` AS SELECT DISTINCT equipment FROM `kleintrainingapp.mygymdata.user_equipment`;

## Queries

### Query 1: All Users Preferences

The "All Users" query calculates equipment popularity across all 1,159 users by counting distinct users per equipment type, matching the deduplicated Excel output. The query is: SELECT equipment, COUNT(DISTINCT user_id) AS quantity, ROUND(COUNT(DISTINCT user_id) * 100.0 / 1159, 2) AS percentage_of_total FROM `kleintrainingapp.mygymdata.user_equipment` GROUP BY equipment ORDER BY quantity DESC;

#### Output
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

**Note**: "Hexbar" was corrected from 133 mentions to 104 unique users, aligning with the analysis intent after identifying 29 duplicate entries in the original `translated` data.

### Query 2: Limited Equipment Users

The "Limited Equipment Users" query focuses on 682 users with ≤ 2 equipment types, ensuring all 13 equipment types appear (including zeros) to match Excel’s output. The query is: WITH equipment_counts AS ( SELECT user_id, COUNT(equipment) AS equip_count FROM `kleintrainingapp.mygymdata.user_equipment` GROUP BY user_id HAVING COUNT(equipment) <= 2 ), limited_users AS ( SELECT ue.equipment, COUNT(DISTINCT ue.user_id) AS quantity FROM `kleintrainingapp.mygymdata.user_equipment` ue JOIN equipment_counts ec ON ue.user_id = ec.user_id GROUP BY ue.equipment ) SELECT el.equipment, COALESCE(lu.quantity, 0) AS quantity, ROUND(COALESCE(lu.quantity, 0) * 100.0 / 682, 2) AS percentage_of_total FROM `kleintrainingapp.mygymdata.equipment_list` el LEFT JOIN limited_users lu ON el.equipment = lu.equipment ORDER BY quantity DESC;

#### Output
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

## Validation

SQL validation revealed "Hexbar" duplicates in 29 users’ `translated` strings (e.g., "Hexbar,Hexbar"), inflating Excel’s initial count to 133. BigQuery’s COUNT(DISTINCT user_id) corrected this to 104, reflecting unique users—the intended metric—which was then adopted in the Excel workflow for consistency.
