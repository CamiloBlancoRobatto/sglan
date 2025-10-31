# 🛠️ Configuración Inicial del Servidor

Este documento explica cómo configurar un servidor desde cero para ejecutar correctamente el proyecto.


//Actualizacion y upgrade
sudo apt update && sudo apt upgrade -y



//Instalacion de apache2
sudo apt install -y apache2



// Habilitar y verificar que Apache esté corriendo
sudo systemctl enable apache2
sudo systemctl start apache2
sudo systemctl status apache2


//Instalacion PHP8.3
sudo apt install -y php8.3 php8.3-cli php8.3-common php8.3-mysql php8.3-pdo libapache2-mod-php8.3


//Instalacion mysql-server
sudo apt install -y mysql-server
sudo mysql_secure_installation


//Instalacion Git
sudo apt install -y git
git --version


//Instalacion Openssh-server
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh


//Clonar repo
git clone https://github.com/UTU-ITI/Los-Cosmicos.git

//Dar permiso de ejecucion
chmod +x setup.sh



