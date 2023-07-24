# lemp_wordpress_docker-compose
Created a script that'll take domain name as user input and give out a wordpress website on a LEMP stack running on docker compose.

### This script has 3 main functions:
  1 - create new website for new domain.

  2 - enable/disable existing domain website if present in the directory
  
  3 - delete a website data

Steps to test it:
<details>

<summary>Create a new website</summary>

Step 1 - Run this command while you are inside this folder
```bash 
bash main_script.sh domain 
```

Step 2a - If you've docker installed on your system, then you'll get the option to enter domain name for your website.

</details>
