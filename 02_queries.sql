--INSERT INTO appointments VALUES ('A0001','P509','C05','2025-01-24','2025-01-25',60,'F',18.0,850,'Phone','Consultation','Yes',1,'No-Show',1,1)	
--Error Code 1062. Duplicate entry 'A0001' for key 'appointments.PRIMARY'

/*===================================================
Task 2.2 — No-show rate by clinic
=====================================================*/

SELECT
    c.clinic_name,
    c.city,
    COUNT(*) AS appointments,
    SUM(a.no_show) AS no_shows,
    ROUND(100 * AVG(a.no_show), 1) AS no_show_pct
FROM clinics c
JOIN appointments a
    ON c.clinic_id = a.clinic_id
GROUP BY
    c.clinic_id,
    c.clinic_name,
    c.city
HAVING COUNT(*) >= 95
ORDER BY no_show_pct DESC;

/*=====================================================*/
SELECT
    c.clinic_name,
    c.city,
    COUNT(*) AS appointments,
    SUM(a.no_show) AS no_shows,
    ROUND(100 * AVG(a.no_show), 1) AS no_show_pct
FROM clinics c
JOIN appointments a
    ON c.clinic_id = a.clinic_id
GROUP BY
    c.clinic_id,
    c.clinic_name,
    c.city
ORDER BY no_show_pct DESC;

/*===================================================
Task 2.3 — Does booking far ahead matter?
=====================================================*/

SELECT
    CASE
        WHEN lead_days BETWEEN 1 AND 7  THEN '1-7'
        WHEN lead_days BETWEEN 8 AND 14 THEN '8-14'
        WHEN lead_days BETWEEN 15 AND 30 THEN '15-30'
        ELSE '31+'
    END AS lead_band,
    COUNT(*) AS appointments,
    SUM(no_show) AS no_shows,
    ROUND(100.0 * SUM(no_show) / COUNT(*), 1) AS no_show_pct
FROM appointments
GROUP BY
    CASE
        WHEN lead_days BETWEEN 1 AND 7  THEN '1-7'
        WHEN lead_days BETWEEN 8 AND 14 THEN '8-14'
        WHEN lead_days BETWEEN 15 AND 30 THEN '15-30'
        ELSE '31+'
    END
ORDER BY MIN(lead_days);

/*===================================================
Task 2.4 — Month-by-month trend
=====================================================*/

WITH monthly AS (
    SELECT
        SUBSTR(appt_date, 1, 7) AS month,
        COUNT(*) AS appointments,
        ROUND(100.0 * SUM(no_show) / COUNT(*), 1) AS no_show_pct
    FROM appointments
    GROUP BY SUBSTR(appt_date, 1, 7)
)
SELECT
    month,
    appointments,
    no_show_pct,
    ROUND(
        no_show_pct
        - LAG(no_show_pct) OVER (ORDER BY month),
        1
    ) AS pct_point_change
FROM monthly
ORDER BY month;

/*===================================================
Task 2.5 — Rank clinics inside each city
=====================================================*/

WITH clinic_rates AS (
    SELECT
        c.clinic_name,
        c.city,
        ROUND(100.0 * SUM(a.no_show) / COUNT(*), 1) AS no_show_pct
    FROM appointments a
    JOIN clinics c
        ON a.clinic_id = c.clinic_id
    GROUP BY c.clinic_name, c.city
)
SELECT
    cr.clinic_name,
    cr.city,
    cr.no_show_pct,
    RANK() OVER (
        PARTITION BY cr.city
        ORDER BY cr.no_show_pct DESC
    ) AS rank_in_city,
    CASE
        WHEN cr.no_show_pct > overall.overall_pct THEN 'above'
        WHEN cr.no_show_pct < overall.overall_pct THEN 'below'
        ELSE 'equal'
    END AS vs_overall
FROM clinic_rates cr
CROSS JOIN (
    SELECT ROUND(100.0 * SUM(no_show) / COUNT(*), 1) AS overall_pct
    FROM appointments
) overall
ORDER BY cr.city, rank_in_city;