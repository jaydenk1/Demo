# Demo
 This is a demo assignment based on the following outline requirement but will be based on Azure.  
 
> 1)The deployment should take AWS credentials and AWS region as input parameters.
 
> 2)A VPC with the required networking, don't use the default VPC.
 
> 3)Provision a “t2.micro” EC2 instance, with an OS of your choice. 
 
> 4)Change the security group of the instance to ensure its security level. 
 
> 5)Change the OS/Firewall settings of the started instance to further enhance its security level. 
 
> 6)Install Docker CE. 
 
> 7)Deploy and start a NGINX docker container in the EC2 instance. 
 
> 8)Deploy a script (or multiple scripts) on the EC2 instance to complete the following subtasks: 
 
>   a. Log the health status and resource usage of the NGINX container every 10 seconds into a log file. 
 
>   b. Write a REST API using any choice of programming language which is you are familiar with and read from the above log file able to a basic search. 
    (Provide us and example use of your API using curl or any REST client) 
 
> 9)A README.md describing what you've done as well as steps explaining how to run the infrastructure automation and execute the script(s). 
 
> 10)Describe any risks associated with your application/deployment.




##
***This is currently working _in progress and incomplete_.***
***I have managed to complete up to step 7, however I am having challenge on step 8 with the deployment of the health check and API through scripting.***
***The attached code will create:***
***>Ubuntu 18.04 on Azure 1bs instance***
***>Regional choice: Australia East***
***>Network security Group restricted to inbound port 80/443/22, and the inbound public IP address of the tester.***
***>UFW firewall on Ubuntu restricting inbound access only for port 80/443/22***
***>Installation of Docker CE and Nginx-server container on port 80***
##



##Prerequisites
>Require latest Terraform
>Powershell & Powershell CLI 



##To run the code for the deployment 

1)First create a local folder and save the all the attached files on the same folder.
Example I place the code on the "C:\terraform\Qrious2>" folder

2)Run a terminal on terraform application change the terminal directory to the folder location. 

3)Use terraform command "terraform init", this should load the require terraform library for azure 

![image](https://user-images.githubusercontent.com/84843818/137726080-c08b6860-3bce-4642-a2cf-22e51165b0e3.png)

4)Next user terraform command "terraform plan"

![image](https://user-images.githubusercontent.com/84843818/137726398-1dc987ef-ad5b-4830-ab46-de3c9454a19e.png)

5)Final step to deploy the environment, using command "terraform apply -auto-approve"
![image](https://user-images.githubusercontent.com/84843818/137726655-72d60920-fe51-4c6d-86b4-2b5c70a34234.png)

6)Once completed, it will give you an public address like below
![image](https://user-images.githubusercontent.com/84843818/137737493-80250252-37f4-4e0f-acb1-408971e491ac.png)

7)You will need to grab the private key use the following command
```
terraform output -raw tls_private_key
````
copy the entire string from "-----BEGIN RSA PRIVATE KEY-----" to "-----END RSA PRIVATE KEY-----" and save it as a .ppk file on a .ssh folder.
Such as C:/{user}/.ssh/

8)To securely connecting to the server simply, run powershell

'''
ssh -i {.pkk file location} Qriousadmin@{IP add of the server}
'''
![image](https://user-images.githubusercontent.com/84843818/137739042-87a2d4e4-0707-49ca-a2a9-7d6804e30982.png)











