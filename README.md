# Dockerized WordPress Site Setup Script

This is a bash script that automates the process of setting up a WordPress site using Docker and Docker Compose. It provides functionalities to create, manage, and delete the WordPress site.

## Prerequisites

Before running this script, make sure you have the following prerequisites installed on your system:

1. Docker
2. Docker Compose

### Installation

1. Clone this repository or download the script wordpress_docker_setup.sh.

2. Give execute permissions to the script:
   
```bash
chmod +x wordpress_docker_setup.sh
```
### Usage

Run the script with the appropriate command and sub-command as follows:

```bash
./wordpress_docker_setup.sh <create|manage|delete>
```
### Commands

 1. Create WordPress Site
    
 To create a new WordPress site, run the following command:
 
```bash
./wordpress_docker_setup.sh create
```
The script will prompt you to enter the site name (e.g., example.com) and set up a LEMP stack using Docker Compose. It will use MariaDB as the database and the latest version of WordPress.

The site will be accessible at http://example.com:8000.

 2. Manage WordPress Site
    
 To start or stop the WordPress site, run the following command:

 ```bash
./wordpress_docker_setup.sh manage
```
The script will prompt you to enter the action (start/stop). Enter either `start` to start the containers or `stop` to stop them.

3. Delete WordPress Site
   
To delete the WordPress site, run the following command:

 
```bash
./wordpress_docker_setup.sh delete
```
The script will prompt you to confirm if you want to delete the site. Enter `y` for confirmation. It will then stop and remove the Docker containers and volumes associated with the site. Additionally, it will remove the entry for the site from `/etc/hosts`.


## Note

* The script assumes that you have administrative privileges (sudo) to install Docker and modify system configurations.
* The script uses default passwords for the database to keep it simple. In a production environment, it is recommended to use strong and unique passwords.
* Ensure that the port 8000 is available and not being used by any other service on your system.
* If you encounter any issues while running the script, please refer to the [Docker documentation](https://docs.docker.com/) for troubleshooting.

#### Feel free to modify and improve this script according to your specific needs. Enjoy your Dockerized WordPress site!




  

