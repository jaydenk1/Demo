
- [Goals](#goals)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Risks](#risks)

# Goals

The goal of terraform code and scripts in this repository are:
- Create a Virtual Network and subnet in Azure.
- Create NSG and set rules to allow public ip.
- Associate NSG with subnet. 
- Create a linux virtual machine in the previously created subnet.
- Place and execute a script on the virtual machine to change firewall settings.
- Install Docker and run nginx container on the virtual machine.
- Log health status and usage of the container to a log file.
 
# Prerequisites
- Terraform
- Git
- Powershell or Azure CLI

# Getting Started

1) Open VS Code > terminal, navigate to the folder where you wish to store the code and then clone the repository.   
```
git clone https://github.com/jaydenk1/Demo && cd Demo/
``` 

Unzip both of the zip files
```
expand-Archive -Path C:\PATH\scripts.zip -DestinationPath C:\DIRECTORY_CHOICE
```
```
expand-Archive -Path C:\PATH\tf.zip -DestinationPath C:\DIRECTORY_CHOICE
```


scripts folder should only containing scripting files

![image](https://user-images.githubusercontent.com/84843818/138814093-972370f6-90a2-4901-8363-c2633d4e1ca2.png)


tf folder should only containing terraform files

![image](https://user-images.githubusercontent.com/84843818/138814077-908bbfff-2883-48ee-9bd9-fc69171e3991.png)

Once you have download the codes and unzip both of the zip and place on the same directory.

Change the directory to 'tf', this is where you can run the terraform command.
```
cd tf
``` 


2) Initialize terraform and then terraform plan
```
terraform init
``` 

```
terraform plan
``` 

![image](https://user-images.githubusercontent.com/84843818/137726080-c08b6860-3bce-4642-a2cf-22e51165b0e3.png)

3) To apply run.
```
terraform apply -auto-approve
``` 
![image](https://user-images.githubusercontent.com/84843818/137726655-72d60920-fe51-4c6d-86b4-2b5c70a34234.png)

4) Once completed, it will give you an public address like below

![image](https://user-images.githubusercontent.com/84843818/137737493-80250252-37f4-4e0f-acb1-408971e491ac.png)

5) Extract the private key using the following command.
```
terraform output -raw tls_private_key
```
Copy the key and save the private key to user folder C:/{user}/.ssh/xxx.ppk


6) To connect to the server simply, run the following command in terminal.

```
ssh -i c:/{users/.ssh/xxx.pkk} qriousadmin@{IP add of the server}
```
![image](https://user-images.githubusercontent.com/84843818/138695230-6d9840b3-961f-4631-9197-39930c28a9dc.png)


7) If you want to check status of running containers or restart docker container 
```
sudo docker ps
```
![image](https://user-images.githubusercontent.com/84843818/138661254-2cf5a821-a956-4db6-8305-e09e81454cba.png)


To restart the docker container
```
sudo docker restart webserver
```


8) Log health status health check every 10 seconds + delete & backup on Sunday at 1.05am.
  The log can be access from externally using the following link http://qrious.australiaeast.cloudapp.azure.com/containerlogs.html 

![image](https://user-images.githubusercontent.com/84843818/138662677-7a337c06-c2c0-4b7e-bc71-ce89db9f566f.png)

![image](https://user-images.githubusercontent.com/84843818/138661765-aa015dc0-4259-4c57-a34d-a78ae3d81dc1.png)

![image](https://user-images.githubusercontent.com/84843818/138661843-7d1e1f88-04be-4941-8410-b60b0dac8252.png)


9) API server is up and running on port 8080.

![image](https://user-images.githubusercontent.com/84843818/138663256-18b85cc2-7274-4860-a95d-3f167ed27773.png)

Simple REST API which will only pull data result 'healthy' or 'unhealthy'. 
Anything else will get the following message "Please try again..."

![image](https://user-images.githubusercontent.com/84843818/139580898-5cf0640d-b351-421e-8c2e-19d818fccf2b.png)

Result 
![image](https://user-images.githubusercontent.com/84843818/139581003-ae3ce703-8754-49b5-aa19-bac8db9f2b98.png)



# Risks
- Virtual machine is directly accessible over the internet on ports 8080, 80,443 and 22. It is however locked to users public ip address.
- Terraform State file is local
- No policies/protection for the webserver hosted in the VM except port level blocking.
- No high availabiltiy, BCDR or monitoring in place.
