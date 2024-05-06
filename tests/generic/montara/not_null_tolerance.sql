{% test not_null_tolerance(model, column_name, tolerance) %}
    
    WITH NullValueCounts AS (
        SELECT *
        FROM {{ model }}
        where {{ column_name }} is null
    ),
    AllValuesCounts AS (
        SELECT count(*)
        FROM {{ model }}
    )
    SELECT * 
    FROM NullValueCounts
    WHERE ((select COUNT(*) from NullValueCounts) * 100.0) / (select * from AllValuesCounts) >= {{ tolerance }}

{% endtest %}