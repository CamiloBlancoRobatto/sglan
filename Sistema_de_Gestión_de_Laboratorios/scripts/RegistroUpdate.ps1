# =================================================================
# SCRIPT DE GENERACIÓN Y ENVÍO DE REPORTE
# Objetivo: Crear un reporte del sistema y enviarlo a un servidor.
# =================================================================

function Get-SystemInfo {
    # 1. Informacion basica
    $computerInfo = Get-ComputerInfo
    $fecha = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $nombrePC = $env:COMPUTERNAME
    $usuario = $env:USERNAME

    # 2. Sistema Operativo y Hardware
    $osInfo = Get-WmiObject Win32_OperatingSystem
    $cpuInfo = Get-WmiObject Win32_Processor | Select-Object -First 1
    $ramTotal = [math]::Round($osInfo.TotalVisibleMemorySize / 1MB, 2)
    $ramLibre = [math]::Round($osInfo.FreePhysicalMemory / 1MB, 2)
    $disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"

    # --- Obtener el tipo de disco (SSD o HDD) ---
    $diskType = "No disponible" # Valor por defecto
    try {
        $physicalDisk = Get-PhysicalDisk -DeviceNumber (Get-Partition -DriveLetter C).DiskNumber
        $diskType = $physicalDisk.MediaType
    } catch {
        # Si falla, se queda con "No disponible". No se muestra advertencia.
    }
    
    # Calculo de porcentajes
    $ramUsoPorcentaje = [math]::Round(($ramTotal - $ramLibre) / $ramTotal * 100, 2)
    $discoUsoPorcentaje = [math]::Round(($disk.Size - $disk.FreeSpace) / $disk.Size * 100, 2)

    # 3. Informacion de Red Detallada
    $networkInfo = Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway } | Select-Object -First 1
    $ipAddress = $networkInfo.IPv4Address.IPAddress
    $gateway = $networkInfo.IPv4DefaultGateway.NextHop
    $dnsServers = ($networkInfo.DNSServer.ServerAddresses | Where-Object { $_ -ne "::" }) -join ", "
    
    # Pruebas de conectividad
    $conexionWAN = Test-Connection "8.8.8.8" -Count 1 -Quiet
    $conexionLAN = if ($gateway) { Test-Connection $gateway -Count 1 -Quiet } else { $false }
    $conexionDNS = Test-Connection "www.google.com" -Count 1 -Quiet

    # 4. Perifericos (Lista completa)
    $perifericos = @()
    $perifericos += Get-WmiObject Win32_Keyboard | ForEach-Object { "Teclado: $($_.Name) - Conectado" }
    $perifericos += Get-WmiObject Win32_PointingDevice | ForEach-Object { "Raton: $($_.Name) - Conectado" }
    $perifericos += Get-WmiObject Win32_DesktopMonitor | ForEach-Object { "Monitor: $($_.Name) - Conectado" }
    $perifericos += Get-WmiObject Win32_Printer | ForEach-Object {
        $estado = if ($_.WorkOffline) { "Desconectada" } else { "Conectada" }
        "Impresora: $($_.Name) - $estado"
    }

    # 5. Crear el objeto final con todos los datos
    return [PSCustomObject]@{
        Fecha = $fecha
        NombrePC = $nombrePC
        Usuario = $usuario
        SistemaOperativo = $osInfo.Caption
        VersionOS = $osInfo.Version
        Arquitectura = $osInfo.OSArchitecture
        Fabricante = $computerInfo.CsManufacturer
        Modelo = $computerInfo.CsModel
        NumeroSerie = ($computerInfo.BiosSeralNumber).Trim()
        Procesador = $cpuInfo.Name
        Nucleos = $cpuInfo.NumberOfCores
        Hilos = $cpuInfo.NumberOfLogicalProcessors
        RAMTotalGB = $ramTotal
        RAMLibreGB = $ramLibre
        RAMUsoPorcentaje = $ramUsoPorcentaje
        DiscoTotalGB = [math]::Round($disk.Size / 1GB, 2)
        DiscoLibreGB = [math]::Round($disk.FreeSpace / 1GB, 2)
        DiscoUsoPorcentaje = $discoUsoPorcentaje
        TipoDiscoC = $diskType
        IPAddress = $ipAddress
        Gateway = $gateway
        DNSServers = $dnsServers
        ConexionLAN = $conexionLAN
        ConexionWAN = $conexionWAN
        ConexionDNS = $conexionDNS
        Perifericos = $perifericos
    }
}

# --- EJECUCIÓN PRINCIPAL ---
try {
    Write-Host "Paso 1: Recolectando información completa del sistema..." -ForegroundColor Cyan
    $systemInfo = Get-SystemInfo

    # Crear carpeta "Reportes_Generados" en el Escritorio si no existe
    $reportsFolderPath = "$env:USERPROFILE\Desktop\Reportes_Generados"
    if (-not (Test-Path $reportsFolderPath)) {
        New-Item -ItemType Directory -Path $reportsFolderPath | Out-Null
    }

    # Nombre del archivo: Fecha-Serial-Estado.toml
    $reportName = "$(Get-Date -Format 'yyyyMMdd')-$($systemInfo.NumeroSerie)-$($systemInfo.ConexionWAN).toml"
    $reportPath = Join-Path -Path $reportsFolderPath -ChildPath $reportName

    # --- PLANTILLA DE REPORTE COMPLETA ---
    $reportContent = @"
=== INFORMACION DEL SISTEMA ===
Fecha: $($systemInfo.Fecha)
Nombre del PC: $($systemInfo.NombrePC)
Usuario: $($systemInfo.Usuario)

=== SISTEMA OPERATIVO ===
SO: $($systemInfo.SistemaOperativo)
Version: $($systemInfo.VersionOS)
Arquitectura: $($systemInfo.Arquitectura)

=== HARDWARE ===
Fabricante: $($systemInfo.Fabricante)
Modelo: $($systemInfo.Modelo)
Numero de Serie: $($systemInfo.NumeroSerie)
Procesador: $($systemInfo.Procesador)
Nucleos: $($systemInfo.Nucleos)
Hilos: $($systemInfo.Hilos)
RAM Total: $($systemInfo.RAMTotalGB) GB
RAM Libre: $($systemInfo.RAMLibreGB) GB
Uso de RAM: $($systemInfo.RAMUsoPorcentaje)%
Disco Total (C:): $($systemInfo.DiscoTotalGB) GB
Disco Libre (C:): $($systemInfo.DiscoLibreGB) GB
Uso de Disco: $($systemInfo.DiscoUsoPorcentaje)%
Tipo de Disco (C:): $($systemInfo.TipoDiscoC)

=== RED ===
Direccion IP: $($systemInfo.IPAddress)
Gateway: $($systemInfo.Gateway)
DNS Servers: $($systemInfo.DNSServers)
Conexion LAN: $($systemInfo.ConexionLAN)
Conexion WAN: $($systemInfo.ConexionWAN)
Conexion DNS: $($systemInfo.ConexionDNS)

=== PERIFERICOS CONECTADOS ===
$($systemInfo.Perifericos -join "`n")
"@
    
    $reportContent | Out-File -FilePath $reportPath -Encoding UTF8
    
    Write-Host "Paso 2: Reporte completo generado con éxito en:" -ForegroundColor Green
    Write-Host $reportPath
    
    # --- ENVÍO DEL REPORTE POR SCP ---
    # Define los detalles de la conexión
    $remoteUser = "Camilo"
    $remoteHost = "192.168.1.11"
    $keyPath = "$env:USERPROFILE\.ssh\id_rsa" # Ruta a tu clave privada (ajusta si usas un nombre diferente)
    $remotePath = "/home/Camilo/" # Ruta de destino en el servidor

    Write-Host "Paso 3: Enviando reporte al servidor $remoteHost..." -ForegroundColor Cyan

    # Construye y ejecuta el comando scp
    # El comando scp debe estar disponible en el PATH del sistema
    scp -i $keyPath $reportPath "$($remoteUser)@$($remoteHost):$($remotePath)"
    
    # Comprueba si el comando anterior tuvo éxito
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Reporte enviado con éxito." -ForegroundColor Green
    } else {
        Write-Host "ERROR: No se pudo enviar el reporte. Verifica la conexión, la ruta de la clave SSH y los permisos." -ForegroundColor Red
    }
    
    # Opcional: Abre la carpeta de reportes al finalizar
    Invoke-Item $reportsFolderPath

    exit 0
}
catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}