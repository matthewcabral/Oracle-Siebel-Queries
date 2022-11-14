SELECT
	SCO.FST_NAME || ' ' || SCO.LAST_NAME AS "DEV",
	WPP.NAME AS "WS_MAIN",
	WP1.NAME AS "WS_1",
    VER.VERSION_NUM AS "VER",
	WP2.NAME AS "WS_2",
	WP2.STATUS_CD  AS "STATUS",
	VER2.VERSION_NUM AS "VER_1",
	VER.CREATED   AS "DATA",
	OBJ.OBJ_NAME  AS "NOME_OBJETO",
	OBJ.OBJ_TYPE  AS "TIPO",
	OBJ.OPERATION_CD  AS "OPERACAO",
    VER2.COMMENTS AS "DESCRICAO"--,
    --MLOG.FROM_WS_VER_ID,
    --MLOG.TO_WS_VER_ID,
    --MLOG.RESULT_WS_VER_ID
FROM SIEBEL.S_WORKSPACE WPP
LEFT JOIN SIEBEL.S_WORKSPACE WP1 ON WP1.PAR_WS_ID = WPP.ROW_ID
LEFT JOIN SIEBEL.S_WORKSPACE WP2 ON WP2.PAR_WS_ID = WP1.ROW_ID
LEFT JOIN SIEBEL.S_WS_VERSION VER ON VER.WS_ID = WP1.ROW_ID
LEFT JOIN SIEBEL.S_WS_VERSION VER2 ON VER2.WS_ID = WP2.ROW_ID
INNER JOIN SIEBEL.S_WS_MERGE_LOG MLOG ON MLOG.TO_WS_VER_ID = VER.ROW_ID AND MLOG.FROM_WS_VER_ID = VER2.ROW_ID
--LEFT JOIN SIEBEL.S_WS_MERGE_LOG MLOG2 ON MLOG2.FROM_WS_VER_ID = VER2.ROW_ID
LEFT JOIN SIEBEL.S_RTC_MOD_OBJ OBJ ON OBJ.WS_VER_ID = VER.ROW_ID
LEFT JOIN SIEBEL.S_USER SUS ON SUS.ROW_ID = WP2.CREATED_BY
LEFT JOIN SIEBEL.S_CONTACT SCO ON SCO.ROW_ID = SUS.PAR_ROW_ID
WHERE WPP.NAME = 'MAIN'
--AND WP1.NAME LIKE '%2022%' -- Nome da WS de 2 nivel
--AND WP2.NAME LIKE 'dev_mrosa%58%' -- Nome da WS de 3 nivel
--AND OBJ.ROW_ID IS NOT NULL
AND OBJ.OBJ_NAME IN ( -- NOME DO OBJETO
    'GOL Club Smiles - Renew Signature Annual'
)
AND OBJ.OBJ_TYPE = 'Workflow Process' -- TIPO DO OBJETO (BC, BO, APPLET, ETC)
--AND WP1.ROW_ID <> '1@981'
--AND WP2.ROW_ID = '1@981'
--AND VERP.ROW_ID = '1-B2C34M0'
ORDER BY VER.VERSION_NUM DESC, VER2.VERSION_NUM DESC, WPP.NAME, WP1.NAME DESC, WP2.NAME ASC, VER.CREATED DESC;