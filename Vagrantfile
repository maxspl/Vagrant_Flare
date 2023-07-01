Vagrant.configure("2") do |config|
  config.vm.box = "StefanScherer/windows_10"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
  end
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.disksize.size = '85GB'

  config.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "true", inline: <<-SHELL
    # Just a dummy test
    #echo 'test' > "$Env:USERPROFILE\\Desktop\\testfile"

    # Create custom install dir
    new-item $Env:USERPROFILE\\Desktop\\install_custom -itemtype directory

    # Change exec policy
    Set-ExecutionPolicy bypass  -scope Process -Force 

    #Disable auto update
    sc.exe config wuauserv start=disabled
    sc.exe stop wuauserv

    # Add defender exclusion
    Set-MpPreference -ExclusionPath $Env:USERPROFILE\\Desktop

    # DL stop-defender.exe
    (New-Object net.webclient).DownloadFile('https://github.com/lab52io/StopDefender/releases/download/Version1.1.0/StopDefender_x64.exe',"$([Environment]::GetFolderPath("Desktop"))\\install_custom\\StopDefender_x64.exe") 

    # Run stop defender
    & $Env:USERPROFILE\\Desktop\\install_custom\\StopDefender_x64.exe  

    # Install langage pack
    # Install-Language fr-FR

    # Set officedeploymenttool.exe path
    $officedeploymenttoolFile = "/vagrant/dependencies/officedeploymenttool.exe"

    # Copy officedeploymenttool pro to the installation directory
    Copy-Item -Path $officedeploymenttoolFile -Destination "$Env:USERPROFILE\\Desktop\\install_custom\\officedeploymenttool.exe"

    # Run officedeploymenttool.exe  
    & $Env:USERPROFILE\\Desktop\\install_custom\\officedeploymenttool.exe /passive /extract:$Env:USERPROFILE\\Desktop\\

    # Set office_conf.xml path
    $officedeploymenttoolFile = "/vagrant/dependencies/office_conf.xml"
    
    # Copy office_conf.xml pro to the installation directory
    Copy-Item -Path $officedeploymenttoolFile -Destination "$Env:USERPROFILE\\Desktop\\office_conf.xml"
    
    #config.vm.provision 'shell', reboot: true

    # Run office installation
    echo "starting office installation"
    Start-Sleep 5
    & $Env:USERPROFILE\\Desktop\\setup.exe /configure "$Env:USERPROFILE\\Desktop\\office_conf.xml"

    # Set install_firefox.ps1 path
    $install_firefoxFile = "/vagrant/dependencies/install_firefox.ps1"

    # Copy install_firefox.ps1 pro to the installation directory
    Copy-Item -Path $install_firefoxFile -Destination "$Env:USERPROFILE\\Desktop\\install_firefox.ps1"

    # Run install_firefox.ps1 script
    echo "starting firefox installation"
    & $Env:USERPROFILE\\Desktop\\install_firefox.ps1

    # Set the config file path
    $configFile = "/vagrant/dependencies/config.xml"

    # Copy the FlareVM config file to the installation directory
    Copy-Item -Path $configFile -Destination "$Env:USERPROFILE\\Desktop\\install_custom\\config.xml"

    # Set idapro path
    $idaproFile = "/vagrant/dependencies/idapro_7.5.exe"

    # Copy IDA pro to the installation directory
    Copy-Item -Path $idaproFile -Destination "$Env:USERPROFILE\\Desktop\\idapro_7.5.exe"
    
    # Delete Desktop items
    Remove-Item -Path $Env:USERPROFILE\\Desktop\\install_firefox.ps1
    Remove-Item -Path $Env:USERPROFILE\\Desktop\\configuration-Office*
    Remove-Item -Path $Env:USERPROFILE\\Desktop\\office*
    Remove-Item -Path $Env:USERPROFILE\\Desktop\\setup.exe
   # Remove-Item -Path $Env:USERPROFILE\\Desktop\\office*

  
    #Remove-Item -Path $Env:USERPROFILE\\Desktop\\install*
 

    Start-Sleep 5 


    #Remove-Item -Path $Env:USERPROFILE\\Desktop\\install*

  SHELL

  config.vm.provision :reload

  config.vm.provision "shell", privileged: "true", powershell_elevated_interactive: "true", inline: <<-SHELL

    # Change exec policy
    Set-ExecutionPolicy bypass  -scope Process -Force 

    # Run stop defender
    & $Env:USERPROFILE\\Desktop\\install_custom\\StopDefender_x64.exe  

    # Download Flare
    (New-Object net.webclient).DownloadFile('https://raw.githubusercontent.com/mandiant/flare-vm/main/install.ps1',"$([Environment]::GetFolderPath("Desktop"))\\install_custom\\install.ps1")

    # Unblock flare
    Unblock-File "$([Environment]::GetFolderPath("Desktop"))\\install_custom\\install.ps1" 

    # Change exec policy
    Set-ExecutionPolicy unrestricted  -scope Process -Force   

    # Run flare script
    echo "starting flare installation"
    & $Env:USERPROFILE\\Desktop\\install_custom\\install.ps1 -customConfig $Env:USERPROFILE\\Desktop\\install_custom\\config.xml -noGui -noReboots -noWait -noChecks -password vagrant

  SHELL


end
