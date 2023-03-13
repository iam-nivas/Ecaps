FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive
ENV MYSQL_ROOT_PASSWORD=pass
ENV MYSQL_DATABASE=database
ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=pass
ENV DB_NAME=mysql
ENV DB_USER=root
ENV DB_PASSWORD=pass
RUN apt update
RUN apt-get update
RUN apt install nano sudo -y
RUN adduser frappe
USER root
RUN usermod -aG sudo frappe
RUN sudo su
RUN sudo apt-get install git wget curl nano sudo -y
RUN sudo apt install python3-minimal build-essential python3-setuptools python3-pymysql redis libffi-dev libssl-dev libmariadb-dev-compat libmariadb-dev -y
RUN sudo curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
RUN apt-get install python3.10-venv -y
RUN echo 'root:root' | chpasswd
RUN echo 'frappe:root' | chpasswd
RUN apt-get install software-properties-common -y
#RUN export DB_ROOT_PASSWORD=root
RUN apt install mariadb-server mariadb-client -y
RUN apt-get install redis-server -y
RUN apt-get install xvfb libfontconfig wkhtmltopdf -y
RUN apt-get install libmysqlclient-dev -y
#RUN echo [mysqld] \
#character-set-client-handshake = FALSE \
#character-set-server = utf8mb4 \
#collation-server = utf8mb4_unicode_ci \
#[mysql] \
#default-character-set = utf8mb4 \ > /etc/mysql/my.cnf
RUN apt install curl -y
ENV PATH="/root/.nvm/versions/node/v16.15.0/bin/:${PATH}"
RUN apt install cron -y
RUN apt install pip -y
RUN echo 'frappe ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN pip3 install frappe-bench
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update
RUN apt install yarn -y
USER frappe
RUN cd /home/frappe && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/home/frappe/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install 16.15.0
RUN . "$NVM_DIR/nvm.sh" && nvm use v16.15.0
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v16.15.0
RUN cd /home/frappe && bench init --frappe-branch version-14 frappe-bench
RUN cd /home/frappe/frappe-bench && bench get-app erpnext https://github.com/frappe/erpnext.git --branch version-14
WORKDIR /home/frappe/frappe-bench
USER root
COPY start_services.sh /home
RUN chmod 777 /home/start_services.sh
RUN apt-get update && apt-get install -y expect
COPY mysql_secure_installation.sh /home
RUN chmod 777 /home/mysql_secure_installation.sh
CMD /home/start_services.sh
EXPOSE 3306 8000