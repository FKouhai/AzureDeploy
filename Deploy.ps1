function menu{

    Write-Host "1 Para crear un recurso"
    Write-host  "2 para crear una MV"
    Write-host "3 para conectarse a la MV"
    Write-host "4 para salir"
    }
    
    function recurso{
        #Conexion con la cuenta de azure
        Connect-AzAccount
        #Obtencion de datos para la creacion del recurso
        $nombre=Read-Host "Introduce el nombre del recurso"
        $locat= Read-host "Introduce la localizacion"
        #Creacion del recurso
        New-AzResourceGroup -Name $nombre -Location $locat
    }
    
    
    function deploy{
    #Nombre del recurso
    $recuro="NombreRecurso"
    #Seleccion del nombre de la VM
    $Virtual = Read-Host "Introduce el nombre de la VM"
    #Tamaño del disco
    $size = Read-Host "Introduce el VMSize"
    #Obtener las credenciales de admin
    
    $cred = Get-Credential
    #Localizacion
    $localizacion=Read-Host "Introduce la localizacion"
    #Crea rconfig de VM
    
    $vm = New-AzVmConfig -VMName $Virtual -VMSize $size
    
    #Añadir Informacion del OS
    $cnName = Read-Host "Introduce el nombre del PC"
    
    $vm=  Set-AzVMOperatingSystem -VM $vm -Windows  -ComputerName $cName -Credential $cred -provisionVMAgent -EnableAutoUpdate
    
    #Añadir informacion a la imagen
    $skus = Read-Host "Introduce el skus"
    $offer = Read-Host "Introduce el offer"
    $vm = Set-AzVMSourceImage -VM $vm -OublisherName MicrosoftWindowsServer -Offer $offer -Skus $skus -Version "latest"
    
    #Creacion de VM
    
    New-AzVM -ResourceGroupName $recuro -Name $Virtual -Location $localizacion -VirtualNetworkName "myVnet" -SubnetName "mysubnet" -SecurityGroupName "mynetworkSecGroup" -PublicIPAddressName "myPublicIP" -openPorts 80,3389
    }
    
    function conexion{
    #Obtencion de IP publica
    
    $ip= Get-AzPublicIPAddress -ResourceGroupName "nombreRecurso"|select "IpAddress"
    
    #Conexion por RDP
    
    mstsc /v $ip
    }
    
    
    
    do{
    menu
    $opc = Read-host "Selecciona una opcion"
    
    switch($opc){
    '1'{recurso}
    '2'{deploy}
    '3'{conexion}
    '4' {exit}
     Default {Write-Host "Opcion incorrecta"}
    
    }
    $intro = Read-Host "Pulse intro para continuar"
    }while($true)