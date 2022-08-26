SELECT score, 
dense_rank()  OVER (
        ORDER BY score desc
    ) as 'rank'
FROM Scores
ORDER BY score Desc