# vagrant_FlareVM

This Vagrant configuration allows to install a Windows 10 VM.
I use a custom FlareVM config file with almost all the tools.

I also added :

  - FireFox

  - Office

  - Defender killing tool (https://github.com/lab52io/StopDefender)



## Prerequisites

Only tested on a Linux machine.
You need to install Virtual Box and Vagrant.

Install the required Vagrant modules :
```
vagrant plugin install vagrant-disksize
vagrant plugin install vagrant-reload
```


## Usage

Clone the repo 
```
git clone https://github.com/maxspl/Vagrant_Flare.git
```

Move into the cloned repo
```
cd 05_vagrant_flarevm
```

Run the Vagrant build
```
vagrant up
```

It may be long (more than 30 minutes).

After the building process, you should see the VM in Virtual Box.

## Connection to the VM
Currently, there is an issue with the VBox addition Guest Additions, so the best way to reach the VM is rdp.

Run xfreerdp :
```
xfreerdp /u:vagrant /p:vagrant /v:127.0.0.1:3389 /dynamic-resolution
```

## Share
A network share is already configured but not mounted. You can mount it from Virtual Box : right click on the VM > settings > share folder > edit shared folder > auto mount.

## Others commands
Stop the VM from Vagrant
```
vagrant halt
```
Start the VM from Vagrant
```
vagrant up
```
Destroy the VM
```
vagrant Destroy
```


