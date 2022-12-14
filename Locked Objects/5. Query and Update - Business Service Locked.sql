SELECT
    BS.ROW_ID,
    BS.NAME,
    BS.OBJ_LOCKED_FLG,
    BS.OBJ_LOCKED_BY,
    SUS.ROW_ID AS "ID_USUARIO",
    SUS.LOGIN AS "LOGIN",
    SCO.FST_NAME AS "NOME",
    SCO.LAST_NAME AS "SOBRENOME"
FROM SIEBEL.S_SERVICE BS
INNER JOIN SIEBEL.S_USER SUS ON SUS.ROW_ID = BS.OBJ_LOCKED_BY
INNER JOIN SIEBEL.S_CONTACT SCO ON SCO.ROW_ID = SUS.PAR_ROW_ID
WHERE BS.NAME = 'CEG Report File Generator';

UPDATE SIEBEL.S_SERVICE BS
SET OBJ_LOCKED_FLG = 'N'
WHERE ROW_ID = '2-T5G9-1IRA2';