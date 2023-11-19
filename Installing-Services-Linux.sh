#!/bin/bash

echo "Installing App Services for LiveCom App :"
echo "1. JDK 11"
echo "2. Tomcat 9"
echo "3. Elastic Search"
echo "4. Kibana"
echo "5. Dotnet Core"
echo "6. Keycloak"
echo "====================================="
echo -n "Choose the option that you need : "
read options
case $options in

    1)
      echo "Installing JDK 11...."
      sudo apt-get update && sudo apt-get upgrade \
      sudo apt-get install openjdk-11-jdk \
      java -version
      echo "Installed JDK 11."
    ;;

    2)
      echo "Downloading Tomcat 9....."
      sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz --directory-prefix=/opt/tomcat
      echo "Downloaded resource for Tomcat 9, the rest need to installed manually."
    ;;

    3)
      echo "Installing Elastic Search...."
      curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - \
      echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list \
      sudo apt-get update && sudo apt-get install elasticsearch \
      echo "Installed Elastic Search."
    ;;

    4)
      echo "Installing Kibana...."
      curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - \
      echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list \
      sudo apt-get update && sudo apt-get install kibana
        echo "Installed Elastic Search."
    ;;

    5)
        echo "Installing .Net Core...."
        sudo wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
        sudo dpkg -i packages-microsoft-prod.deb \
        rm packages-microsoft-prod.deb \
        sudo apt-get update && sudo apt-get install 
    ;;

    6)
        echo "Downloading Keycloak v18.0.2...."
        sudo wget https://github.com/keycloak/keycloak/releases/download/18.0.2/keycloak-legacy-18.0.2.zip --directory-prefix=/opt/keycloak
        echo "Downloaded the resources of Keycloak, please google on how to installed manually."
    ;;

    *)
        echo "The options that you input is wrong, please try again."
    ;;
esac
    
