SELECT
    w1.Id
FROM weather w1, weather w2
WHERE DATE_SUB(w1.RecordDate, interval 1 Day) = w2.RecordDate 
AND w1.Temperature > w2.Temperature;