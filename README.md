
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
Important: Create a 'scripts' folder on the choosen location. Move the following scripts (7 scripts highlight in red) into the 'scripts' folder.
![image](https://user-images.githubusercontent.com/84843818/138667863-1d399b45-209a-4b02-9f78-285634cadbbc.png)

![image](https://user-images.githubusercontent.com/84843818/138668553-92710c83-a4e3-4ef0-9f41-68448ab244a6.png)



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
ssh -i {.pkk file location} qriousadmin@{IP add of the server}
```
![image](https://user-images.githubusercontent.com/84843818/137739042-87a2d4e4-0707-49ca-a2a9-7d6804e30982.png)

7) To check running containers or docker restart 
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

API server is up and running, however REST API client is incomplete.

![image](https://user-images.githubusercontent.com/84843818/138663256-18b85cc2-7274-4860-a95d-3f167ed27773.png)

The finaly plan is to have Rest Api to pass input such as 'healthy' or 'unhealthy' to the healthstatus for result like below.
![image](https://user-images.githubusercontent.com/84843818/138663727-4ccd9b6a-6ba9-4093-82fd-acf1aae2d48c.png)



# Risks
- Virtual machine is directly accessible over the internet on ports 8080, 80,443 and 22. It is however locked to users public ip address.
- Terraform State file is local
- No policies/protection for the webserver hosted in the VM except port level blocking.
- No high availabiltiy, BCDR or monitoring in place.
