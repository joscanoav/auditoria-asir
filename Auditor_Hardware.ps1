# 1. Seguridad: Mover al escritorio
cd $HOME\Desktop

# 2. Técnica del Sándwich (Agrupar datos)
$(
    "===== INFORME DEL EQUIPO ====="
    ""

    # ---- CPU ----
    "---- CPU ----"
    Get-CimInstance Win32_Processor |
        Select-Object Name, NumberOfCores |
        Format-Table -AutoSize | Out-String

    # ---- RAM ----
    "---- RAM ----"
    $mem = Get-CimInstance Win32_PhysicalMemory

    $ramTotal = ($mem | Measure-Object -Property Capacity -Sum).Sum / 1GB
    $velocidad = ($mem | Select-Object -First 1).Speed

    "Memoria Total: {0:N0} GB" -f $ramTotal
    "Velocidad: $velocidad MHz"
    ""

    # ---- DISCO ----
    "---- DISCO ----"
    Get-PhysicalDisk |
        Select-Object FriendlyName,
            MediaType,
            @{Name="Size(GB)";Expression={[math]::Round($_.Size/1GB)}} |
        Format-Table -AutoSize | Out-String

) | Out-File "INFORME_JEFE.txt"

# 3. Resultado
notepad.exe INFORME_JEFE.txt