SELECT * FROM schedules;

SELECT * FROM process;

SELECT s.*, p.* FROM Schedules As s
JOIN Process AS p
ON (s.SchIdx = p.SchIdx); 

-- Process : 실제 공정

-- PrcResult 성공/실패 횟수
SELECT p.SchIdx, p.PrcDate, 
	CASE p.PrcResult WHEN 1 THEN 1 ELSE 0 END AS PrcOK,
	CASE p.PrcResult WHEN 0 THEN 1 ELSE 0 END AS PrcFail
FROM Process AS p;

-- 합계 집계
SELECT smr.SchIdx, smr.PrcDate, sum(smr.PrcOK) as PrcOKAmount, sum(smr.PrcFail) as PrcFailAmount
FROM (
		SELECT p.SchIdx, p.PrcDate, 
			CASE p.PrcResult WHEN 1 THEN 1 ELSE 0 END AS PrcOK,
			CASE p.PrcResult WHEN 0 THEN 1 ELSE 0 END AS PrcFail
		FROM Process AS p
	 ) AS smr
GROUP BY smr.SchIdx, smr.PrcDate

-- 성공/실패 횟수와 합계 집계 를 조인해서 원하는 결과 도출
SELECT sch.SchIdx, sch.PlantCode, sch.SchAmount, prc.PrcDate
	   , prc.PrcOKAmount, prc.PrcFailAmount
FROM Schedules AS sch
INNER JOIN (
				SELECT smr.SchIdx, smr.PrcDate, sum(smr.PrcOK) as PrcOKAmount, sum(smr.PrcFail) as PrcFailAmount
				FROM (
						SELECT p.SchIdx, p.PrcDate, 
							CASE p.PrcResult WHEN 1 THEN 1 ELSE 0 END AS PrcOK,
							CASE p.PrcResult WHEN 0 THEN 1 ELSE 0 END AS PrcFail
						FROM Process AS p
					 ) AS smr
			    GROUP BY smr.SchIdx, smr.PrcDate
			) AS prc
ON sch.SchIdx = prc.SchIdx