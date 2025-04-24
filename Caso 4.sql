SELECT c.numrun ||'-'|| c.dvrun AS "RUT_CLIENTE"
    ,LOWER(c.pnombre || ' ' || c.snombre || ' ' || c.appaterno|| ' ' || c.apmaterno) AS "NOMBRE_CLIENTE"
    ,(SELECT nombre_prof_ofic
        FROM profesion_oficio 
        WHERE cod_prof_ofic = c.cod_prof_ofic) AS "PROFESIÓN"
    ,TRUNC((MONTHS_BETWEEN(sysdate,c.fecha_nacimiento)/12))  AS "EDAD"
    ,(SELECT nombre_tipo_cliente
        FROM TIPO_CLIENTE
        WHERE cod_tipo_cliente = c.cod_tipo_cliente) AS "TIPO DE CLIENTE"
    ,tc.cupo_compra AS "CUPO DE COMPRA"
    ,tc.cupo_disp_compra AS "CUPO DISPONIBLE"
    ,TRUNC(tc.cupo_disp_compra/tc.cupo_compra*100) AS "% CUPO DISPONIBLE"
    ,CASE
    WHEN tc.cupo_disp_compra/tc.cupo_compra*100 BETWEEN 30 AND 40 THEN('CAMPAÑA DE REPACTACIÓN')
    ELSE ('NO APLICA') END AS "ACCESO A CAMPAÑA DE REPACTACIÓN"
    ,CASE
        WHEN (SELECT SUM(a.cupo_compra)/COUNT(a.cupo_compra)
        FROM tarjeta_cliente a
        INNER JOIN cliente k
        ON k.numrun = a.numrun) > tc.cupo_compra THEN 'CUPO BAJO EL PROMEDIO'
        ELSE 'CUPO SOBRE EL PROMEDIO' END AS "CUPO SOBRE EL PROMEDIO??"
FROM cliente c
INNER JOIN tarjeta_cliente tc
ON tc.numrun = c.numrun
WHERE(MONTHS_BETWEEN(sysdate,c.fecha_nacimiento)/12) >= 25
AND (MONTHS_BETWEEN(sysdate,c.fecha_nacimiento)/12) <= 34
AND cod_tipo_cliente = 10;

