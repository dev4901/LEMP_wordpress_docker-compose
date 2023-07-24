# lemp_wordpress_docker-compose
Created a script that'll take domain name as user input and give out a wordpress website on a LEMP stack running on docker compose.
*Currently I've tested it only on Ubuntu machines
### This script has 3 main functions:
  - create new website for new domain.

  - enable/disable existing website i.e. present in the directory
  
  - delete a website

### Instructions to use them:
<details>

<summary>Create a new website</summary>

1. Run this command while you are inside this folder
```bash 
bash main_script.sh domain 
```
![Alt Running the script](https://github.com/dev4901/lemp_wordpress_docker-compose/blob/main/readme_pictures/f1-s1-1.png)

2a. If you've docker installed on your system, then you'll get the option to enter domain name for your website. Like this

![Alt entering domain name](https://github.com/dev4901/lemp_wordpress_docker-compose/blob/main/readme_pictures/f1-s1-2.png)

2b. If you dont have docker installed on the system, it'll install it for you.

![Alt installing docker 1](https://github.com/dev4901/lemp_wordpress_docker-compose/blob/main/readme_pictures/f1-s2-1.png)
![Alt installed docker 2](https://github.com/dev4901/lemp_wordpress_docker-compose/blob/main/readme_pictures/f1-s2-2.png)

3. It will create a new directory named after your domain. This directory will contain all your website data viz-a-viz database, nginx-conf file and wordpress code.

![Alt website directory created](https://github.com/dev4901/lemp_wordpress_docker-compose/blob/main/readme_pictures/f1-s3-1.jpg)

![Alt contents of the website directory](https://github.com/dev4901/lemp_wordpress_docker-compose/blob/main/readme_pictures/f1-s3-2.png)

</details>

<details> 
<summary>Enable/Disable existing websites</summary>

1. To start a website, write the following command
```bash
bash main_script.bash enable <domain_name>
```   
![Alt enabling a website](https://github.com/dev4901/lemp_wordpress_docker-compose/blob/main/readme_pictures/f2-s1.png)

2. To stop a running website without deleting its data, write
```bash
bash main_script.bash disable <domain_name>
```
![Alt enabling a website](https://github.com/dev4901/lemp_wordpress_docker-compose/blob/main/readme_pictures/f2-s2.png)

</details>

<details> 
<summary>Delete existing website</summary>

With this we can delete a website irrelevant to whether it is enabled/disabled. It'll stop it's containers (if running) and then delete the directory of that website
```bash
bash main_script.bash delete <domain_name>
```
![Alt enabling a website](https://github.com/dev4901/lemp_wordpress_docker-compose/blob/main/readme_pictures/f3.png)

</details>
