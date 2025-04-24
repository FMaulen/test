SELECT ttc.nro_tarjeta
    ,ttc.nro_transaccion
    ,ttc.monto_transaccion
    ,(((ttc.monto_total_transaccion/ttc.monto_transaccion)*100)-100)||'%' AS "PORCENTAJE DE IMPUESTO"
    ,ttc.monto_total_transaccion-ttc.monto_transaccion AS "MONTO_TOTAL_TRANSACCION"
    ,ttc.monto_total_transaccion
    ,ttc.total_cuotas_transaccion
FROM transaccion_tarjeta_cliente ttc
WHERE TO_NUMBER(TO_CHAR(fecha_transaccion,'YYYY')) = TO_NUMBER(TO_CHAR(sysdate,'YYYY')-1)
ORDER BY nro_tarjeta ASC;