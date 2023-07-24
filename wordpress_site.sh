#!/bin/bash

# Function to check if a command is available on the system
check_command() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install Docker and Docker Compose
install_docker() {
  echo "Installing Docker..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker "$USER"
  rm get-docker.sh

  echo "Installing Docker Compose..."
  sudo curl -fsSL https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

# Function to create a WordPress site using Docker and Docker Compose
create_wordpress_site() {
  echo "Enter the site name (e.g., example.com):"
  read -r site_name

  # Check if docker and docker-compose are installed
  if ! check_command docker || ! check_command docker-compose; then
    install_docker
  fi

  # Create a LEMP stack using Docker Compose
  cat >docker-compose.yml <<EOF
version: '3'
services:
  db:
    image: mariadb:latest
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: example_root_password
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: example_db_password

  wordpress:
    image: wordpress:latest
    volumes:
      - wp_data:/var/www/html
    ports:
      - "8000:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: example_db_password
volumes:
  db_data:
  wp_data:
EOF

  # Add an /etc/hosts entry for the site
  echo "127.0.0.1 $site_name" | sudo tee -a /etc/hosts >/dev/null

  # Start the containers
  docker-compose up -d

  echo "The site is up and running at http://$site_name"
}

# Function to stop and start the WordPress site
manage_wordpress_site() {
  echo "Enter the action (start/stop):"
  read -r action

  if [[ "$action" == "start" ]]; then
    docker-compose start
  elif [[ "$action" == "stop" ]]; then
    docker-compose stop
  else
    echo "Invalid action. Use 'start' or 'stop'."
  fi
}

# Function to delete the WordPress site
delete_wordpress_site() {
  echo "Are you sure you want to delete the site? (y/n)"
  read -r confirmation

  if [[ "$confirmation" == "y" ]]; then
    docker-compose down -v
    sudo sed -i "/example.com/d" /etc/hosts
    echo "The site has been deleted."
  fi
}

# Main script starts here
if [[ "$1" == "create" ]]; then
  create_wordpress_site
elif [[ "$1" == "manage" ]]; then
  manage_wordpress_site
elif [[ "$1" == "delete" ]]; then
  delete_wordpress_site
else
  echo "Usage: $0 <create|manage|delete>"
  exit 1
fi
