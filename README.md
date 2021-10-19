
- [Goals](#goals)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Risks](#risks)

# Goals

The goal of terraform code and scripts in this repository are:
- Create a Virtual Network and subnet in Azure.
- Create NSG and set rules to allow public ip.
- Associate NSG with subnet. 
- Create a linux virutal machine in the previously created subnet.
- Place and execute a script on the virtual machine to change firewall settings.
- Install Docker and run nginx container on the virtual machine.
- Log health status of the container to a log file.
 
# Prerequisites
- Terraform
- Git
- Powershell or Azure CLI

# Getting Started

1) Open VS Code > terminal, navigate to the folder where you wish to store the code and then clone the repository.
   
```
git clone https://github.com/jaydenk1/Demo && cd Demo/
``` 

2) Initialize terraform.
```
terraform init
``` 

![image](https://user-images.githubusercontent.com/84843818/137726080-c08b6860-3bce-4642-a2cf-22e51165b0e3.png)

3) To apply run.
```
terraform apply -auto-approve
``` 
![image](https://user-images.githubusercontent.com/84843818/137726655-72d60920-fe51-4c6d-86b4-2b5c70a34234.png)

4) Once completed, it will give you an public address like below

![image](https://user-images.githubusercontent.com/84843818/137737493-80250252-37f4-4e0f-acb1-408971e491ac.png)

5) Extract the private key using the following command
```
terraform output -raw tls_private_key
```
Save the private key to user folder C:/{user}/.ssh/

6) To connect to the server simply, run the following command in terminal.

```
ssh -i {.pkk file location} Qriousadmin@{IP add of the server}
```
![image](https://user-images.githubusercontent.com/84843818/137739042-87a2d4e4-0707-49ca-a2a9-7d6804e30982.png)

7) To check running containers
```
sudo docker ps
```
![image](https://user-images.githubusercontent.com/84843818/137739284-45b13aca-2e31-441c-a81a-23f247185f46.png)

# Risks
- Virtual machine is directly accessible over the internet on ports 80,443 and 22. It is however locked to users public ip address.
- Terraform State file is local
- No policies/protection for the webserver hosted in the VM except port level blocking.
- No high availabiltiy, BCDR or monitoring in place.
