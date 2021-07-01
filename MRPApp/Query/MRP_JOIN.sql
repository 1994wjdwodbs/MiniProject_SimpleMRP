SELECT * FROM schedules;

SELECT * FROM process;

SELECT s.*, p.* FROM Schedules As s
JOIN Process AS p
ON (s.SchIdx = p.SchIdx); 

-- Process : ���� ����

-- PrcResult ����/���� Ƚ��
SELECT p.SchIdx, p.PrcDate, 
	CASE p.PrcResult WHEN 1 THEN 1 ELSE 0 END AS PrcOK,
	CASE p.PrcResult WHEN 0 THEN 1 ELSE 0 END AS PrcFail
FROM Process AS p;

-- �հ� ����
SELECT smr.SchIdx, smr.PrcDate, sum(smr.PrcOK) as PrcOKAmount, sum(smr.PrcFail) as PrcFailAmount
FROM (
		SELECT p.SchIdx, p.PrcDate, 
			CASE p.PrcResult WHEN 1 THEN 1 ELSE 0 END AS PrcOK,
			CASE p.PrcResult WHEN 0 THEN 1 ELSE 0 END AS PrcFail
		FROM Process AS p
	 ) AS smr
GROUP BY smr.SchIdx, smr.PrcDate

-- ����/���� Ƚ���� �հ� ���� �� �����ؼ� ���ϴ� ��� ����
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