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
RUN apt-get update && apt full-upgrade -y && apt autoremove -y
RUN useradd -ms /bin/bash dotcom
RUN usermod -aG sudo dotcom
COPY --chown=dotcom:dotcom .bash_aliases /home/dotcom/
RUN sed -i '/^%sudo/a %sudo	ALL=(ALL:ALL) NOPASSWD:ALL' /etc/sudoers
RUN sudo sed -i 's/^#[P,p]ort.*/port 790/' /etc/ssh/sshd_config
RUN sudo sed -i '/^#PermitRootLogin.*/a PermitRootLogin no' /etc/ssh/sshd_config
RUN sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sudo sed -i 's/^#PermitEmptyPasswords.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config
RUN chsh -s /bin/bash
CMD [ "sh", "-c", "echo $HOME" ]
ENTRYPOINT service ssh restart && bash
