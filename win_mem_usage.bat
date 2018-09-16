@ECHO OFF

:: Created by Abhishek Gharat <abhishek@balasai.com>
:: Script version 1.0 last modified date 16/09/2018


FOR /f %%a IN ('wmic os get TotalVisibleMemorySize /format:Table') DO (
    CALL SET "ip2=%%ip1%%"
    SET "ip1=%%a"
)
SET  totalmem=%ip2%

FOR /f %%a IN ('wmic os get FreePhysicalMemory /format:Table') DO (
    CALL SET "ip2=%%ip1%%"
    SET "ip1=%%a"
)
SET  freemem=%ip2%

SET /a usedMem=totalMem-freemem

SET /a mem=((100*usedMem)/totalMem)


if %mem% LSS 79 goto OK
if %mem% EQU 80 if %mem% LSS 89 goto WARN
if %mem% GEQ 90 goto CRITICAL
:OK
Echo Memory OK, %mem%%% Used ^|'Memory'=%mem%
exit 0
:WARN
Echo Memory Warning, %mem%%% Used ^|'Memory'=%mem%
exit 1
:CRITICAL
Echo Memory CRITICAL, %mem%%% Used ^|'Memory'=%mem%
exit 2
