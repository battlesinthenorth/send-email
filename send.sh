#!/usr/bin/env bash
BOUNDARY=$(date +%s|md5sum)
BOUNDARY=${BOUNDARY:0:32}
DATE=`date +%d%m%Y`
filepath="/home/interfaz/ReporteInvSidra/REPORTE_INVENTARIO_SIDRA.csv"
filename=$(basename ${filepath})


CONTENT=$(cat <<-END
From: reportes-sidra@millicom.com
To: ivan.alvarado@tigo.com.pa, rosmeryuleima.rojasluna.mail@tigo.com.pa, ben.solis@tigo.com.pa, recargas@telefonica.com, mauricio.arias@telefonica.com, eduardo.francoserrano.ext@telefonica.com, brandon.andre.barrera.ramirez@ericsson.com
Reply-To: produccion.comercial.sidra.ca@telefonica.com
Subject: Reporte Inventario SIDRA ${DATE}
Content-Type: multipart/mixed; boundary="${BOUNDARY}"

This is a MIME formatted message. If you see this text it means that your
email software does not support MIME formatted messages, but as plain text
encoded you should be ok, with a plain text file.

--${BOUNDARY}
Content-Type: text/html; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Buenos dias, se adjunta reporte diario de inventarios SIDRA automatizado. Para la correcta visualizacion del archivo, exportar de filas a columnas en Excel la columna A seleccionando el caracter | . Saludos.

--${BOUNDARY}
Content-Type: text/csv; name="${filename}"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="${filename}"

$(cat ${filename})

--${BOUNDARY}--
END
)


echo "$CONTENT" | /usr/sbin/sendmail -t 2>/dev/null
