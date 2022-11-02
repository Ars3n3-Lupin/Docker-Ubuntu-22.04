FROM ubuntu
RUN apt-get update
RUN apt install net-tools -y
RUN apt install iputils-ping -y
RUN apt install iproute2 -y
RUN apt install sudo -y
RUN apt install nano -y
RUN apt install ssh -y
RUN apt install htop -y
RUN apt install unzip -y
RUN apt install locate
RUN apt-get install -y apache2
RUN apt-get update && apt full-upgrade -y && apt autoremove -y
RUN useradd -ms /bin/bash dotcom
RUN usermod -aG sudo dotcom
WORKDIR /home/dotcom
COPY --chown=dotcom:dotcom .bash_aliases /home/dotcom/
RUN sed -i '/^%sudo/a %sudo	ALL=(ALL:ALL) NOPASSWD:ALL' /etc/sudoers
RUN sudo sed -i 's/^#[P,p]ort.*/port 790/' /etc/ssh/sshd_config
RUN sudo sed -i '/^#PermitRootLogin.*/a PermitRootLogin no' /etc/ssh/sshd_config
RUN sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sudo sed -i 's/^#PermitEmptyPasswords.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config
RUN chsh -s /bin/bash
RUN apt install software-properties-common ca-certificates lsb-release apt-transport-https -y
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update -y
RUN apt install php8.1
RUN apt install php8.1-mysql php8.1-mbstring php8.1-xml php8.1-curl php8.1-zip php8.1-gd -y
#RUN sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
EXPOSE 8090
EXPOSE 790
COPY commands.sh /scripts/commands.sh
RUN ["chmod", "+x", "/scripts/commands.sh"]
CMD [ "sh", "-c", "echo $HOME" ]
ENTRYPOINT ["sh", "-c", "service ssh restart && sudo service apache2 restart && bash"]
#CMD [ "sh", "/scripts/commands.sh" ]
#ENTRYPOINT service ssh restart && bash
