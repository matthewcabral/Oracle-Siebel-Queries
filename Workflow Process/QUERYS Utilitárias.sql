SELECT
    WF.ROW_ID,
    WF.PROC_NAME,
    WF.NAME,
    WF.VERSION,
    WF.STATUS_CD,
    WF.INACTIVE_FLG,
    WF.WS_ID,
    WS.NAME
FROM SIEBEL.S_WFR_PROC WF
INNER JOIN SIEBEL.S_WORKSPACE WS ON WS.ROW_ID = WF.WS_ID
WHERE WF.PROC_NAME LIKE 'TCC WF SOA181 Saldo Online e Ultima Recarga%'
--WF.NAME LIKE '%OLD%: 0'
ORDER BY WF.VERSION DESC;
WHERE (
    WF.PROC_NAME = 'TIM SOA727 - Offline WF'
    AND WF.VERSION = '15'
    AND WF.INACTIVE_FLG = 'N'
)
--and WF.VERSION <> '0'
--WF.ROW_ID = '1-B2QN4TD'
ORDER BY WF.VERSION DESC;

SELECT
    COUNT(*)
FROM SIEBEL.S_WFR_PROC WF
INNER JOIN SIEBEL.S_WORKSPACE WS ON WS.ROW_ID = WF.WS_ID
WHERE (
    WF.PROC_NAME = 'TCC WF SOA149 Consulta Envio Relatorio Detalhado'
    AND WF.VERSION = '8'
    AND WF.INACTIVE_FLG = 'Y'
)
OR (
    (
        WF.PROC_NAME LIKE 'TCC WF SOA149 Consulta Envio Relatorio Detalhado' || '%OLD%'
        OR WF.PROC_NAME LIKE 'TCC WF SOA149 Consulta Envio Relatorio Detalhado' || '%old%'
        OR WF.PROC_NAME LIKE 'TCC WF SOA149 Consulta Envio Relatorio Detalhado' || '%Old%'
    )
    AND WF.VERSION = '8'
)
ORDER BY WF.VERSION DESC;

UPDATE SIEBEL.S_WFR_PROC WF
SET WF.PROC_NAME = 'TIM SOA727 - Offline Billing Profile WF',
    WF.INACTIVE_FLG = 'N',
    WF.STATUS_CD = 'COMPLETED',
    WF.NAME = 'TIM SOA727 - Offline Billing Profile WF' || ': ' || '1',
    WF.DESC_TEXT = NULL--'WF alterado para correção de problemas de versionamento'
    --WF.VERSION = '14'
WHERE WF.PROC_NAME LIKE 'TIM SOA727 - Offline Billing Profile WF OLDER';
WF.DESC_TEXT = '[MCABRAL] - WF alterado para correção de problemas de versionamento';
--WF.NAME = 'TIM Fechar Ordem - SOA003 - Loop2_OLD: 6';
and WF.VERSION <> '0';
WF.ROW_ID = '1-B2PU8UC';


SELECT
    WFN.ROW_ID,
    WFN.NAME,
    WFN.VERSION
FROM SIEBEL.S_WFR_PROC WFN
WHERE WFN.PROC_NAME = 'TIM Insere Produto WF OLDER';


DECLARE
    V_WF_PROC_NAME VARCHAR(200):='TIM SOA378 - Offline WF';
    V_WF_ROW_ID VARCHAR(15);
    V_WF_NAME VARCHAR(200);
    V_WF_VERSION VARCHAR(5);
    
    CURSOR C_WF_UPDATE IS
        SELECT
            WFN.ROW_ID,
            WFN.PROC_NAME,
            WFN.NAME,
            WFN.VERSION
        FROM SIEBEL.S_WFR_PROC WFN
        WHERE WFN.PROC_NAME = V_WF_PROC_NAME
        ORDER BY WFN.VERSION DESC;
        
    PROCEDURE P_UPDATE_WF_NAME (R_ID IN VARCHAR, WF_NAME IN VARCHAR, WF_VERSION IN VARCHAR) IS
        BEGIN
            UPDATE SIEBEL.S_WFR_PROC WF
                SET WF.NAME = WF_NAME || ': ' || WF_VERSION
            WHERE ROW_ID = R_ID;
        END;
BEGIN
    FOR I IN C_WF_UPDATE LOOP
        DBMS_OUTPUT.PUT_LINE('NOME ANTIGO: ' || I.NAME);
        P_UPDATE_WF_NAME(I.ROW_ID, I.PROC_NAME, I.VERSION);
        DBMS_OUTPUT.PUT_LINE('  NOME NOVO: ' || I.PROC_NAME || ': ' || I.VERSION);
    END LOOP;
    COMMIT;
END;