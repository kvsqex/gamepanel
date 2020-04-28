#!/bin/sh
LOG_PIPE=log.pipe
mkfifo ${LOG_PIPE}
LOG_FILE=log.file
rm -f LOG_FILE
tee < ${LOG_PIPE} ${LOG_FILE} &
exec  > ${LOG_PIPE}
exec  2> ${LOG_PIPE}
Infon() {
	printf "\033[1;32m$@\033[0m"
}
Info()
{
	Infon "\031$@\n"
}
Error()
{
	printf "\033[1;31m$@\033[0m\n"
}
Error_n()
{
	Error "$@"
}
Error_s()
{
	Error "${red}===========================================================${reset}"
}
log_s()
{
	Info "${green}=========================================================== ${reset}"
}
cp_s ()
{
	Info "${green}===================${white}KVSQEX${green}======================${reset}"
}
log_n()
{
	Info "- - - $@"
}
log_t()
{
	log_s
	Info "- - - $@ - - -"
	log_s
}
RED=$(tput setaf 1)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
white=$(tput setaf 7)
reset=$(tput sgr0)
toend=$(tput hpa $(tput cols))$(tput cub 6)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
LIME_YELLOW=$(tput setaf 190)
CYAN=$(tput setaf 6)

UPD="0"
upd()
{
	if [ "$UPD" = "0" ]; then
		echo "• Обновление ${green}списка пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		UPD="1"
	fi
}
menu()
{
	clear
	Info
	log_t "${white}Добро пожаловать в меню установки ${red}HOSTINPL 5.4 (Fix by kvsqex)${green}"
	Info "- ${YELLOW}1${green} -  ${white}Установка и настройка панели управления ${red} HostinPL 5.4 PRO"
	Info "- ${YELLOW}2${green} -  ${white}Настройка локации под игры ${red}HostinPL 5.4 PRO"
	Info "- ${YELLOW}0${green} -  ${white}Выход"
	cp_s
	Info
	read -p "${white}Пожалуйста, введите пункт меню:" case
	case $case in
		1) Info "${white}Здравствуйте, данный скрипт установит ${red} HOSTINPL 5.4 PRO (Fix by kvsqex) ${white}за Вас!"
	read -p "${white}Пожалуйста, введите домен или IP:${reset}" DOMAIN
	read -p "${white}Пожалуйста, введите код recaptcha v2 (публичный ключ):${reset}" RECAPT
	read -p "${white}Пожалуйста, введите код для кронов (любые буквы):${reset}" CRONTOKE
	echo "• Обновление ${green}списка пакетов! •"
	apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Установка пакета ${green}apt-utils! •"
	apt-get install -y apt-utils > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Установка пакета ${green}pwgen! •"
	apt-get install -y pwgen > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Установка пакета ${green}dialog! •"
	apt-get install -y dialog > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	MYPASS=$(pwgen -cns -1 10)
	MYPASS2=$(pwgen -cns -1 10)
	OS=$(lsb_release -s -i -c -r | xargs echo |sed 's; ;-;g' | grep Ubuntu)
	if [ "$OS" = "" ]; then
		echo "deb http://packages.dotdeb.org wheezy-php55 all">"/etc/apt/sources.list.d/dotdeb.list"
		echo "deb-src http://packages.dotdeb.org wheezy-php55 all">>"/etc/apt/sources.list.d/dotdeb.list"
		echo "• Загрузка ${green}Dotdeb! •"
		wget http://www.dotdeb.org/dotdeb.gpg > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		echo "• Активация ${green}Dotdeb! •"
		apt-key add dotdeb.gpg > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		rm dotdeb.gpg
		echo "• Обновление ${green}списка пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	fi
	echo "• Обновление ${green}пакетов! •"
	apt-get upgrade -y > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Установка пароля на ${green}mysql! •"
	echo mysql-server mysql-server/root_password select "$MYPASS" | debconf-set-selections > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Повторная установка пароля на ${green}mysql! •"
	echo mysql-server mysql-server/root_password_again select "$MYPASS" | debconf-set-selections > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Проверка наличие необходимых ${green}пакетов •"
	apt-get -f install > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Установка пакетов ${green}apache2 php5 php5-dev cron unzip sudo mysql-server fail2ban curl php5-curl php5-gd mysql-workbench! •"
	apt-get install -y apache2 php5 php5-dev cron unzip sudo mysql-server fail2ban curl php5-curl php5-gd mysql-workbench > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		cd /root
		echo "• Загрузка ${green}php-ssh2! •"
		wget http://ftp.us.debian.org/debian/pool/main/p/php-ssh2/php5-ssh2_0.12-3+deb8u1_amd64.deb > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		echo "• Установка пакета ${green}php5-ssh2! •"
		dpkg -i /root/php5-ssh2_0.12-3+deb8u1_amd64.deb > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Удаление мусора от ${green}php5-ssh2! •"
	echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
	echo "phpmyadmin phpmyadmin/mysql/admin-user string root" | debconf-set-selections
	echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYPASS" | debconf-set-selections
	echo "phpmyadmin phpmyadmin/mysql/app-pass password $MYPASS" |debconf-set-selections
	echo "phpmyadmin phpmyadmin/app-password-confirm password $MYPASS" | debconf-set-selections
	echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections
    echo "• Установка пакета ${green}phpmyadmin! •"
	apt-get install -y phpmyadmin > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
   echo "• Перезагрузка ${green}apache! •"
   service apache2 restart > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
   cd /etc/apache2/sites-available/
   touch panel.conf
  	FILE='panel.conf'
		echo "<VirtualHost *:80>">>$FILE
		echo "ServerAdmin webmaster@localhost">>$FILE
		echo "ServerAlias $DOMAIN">>$FILE
		echo "DocumentRoot /var/www">>$FILE
		echo "<Directory /var/www/>">>$FILE
		echo "Options Indexes FollowSymLinks">>$FILE
		echo "AllowOverride All">>$FILE
		echo "Require all granted">>$FILE
		echo "</Directory>">>$FILE
		echo "ErrorLog ${APACHE_LOG_DIR}/error.log">>$FILE
		echo "CustomLog ${APACHE_LOG_DIR}/access.log combined">>$FILE
		echo "</VirtualHost>">>$FILE
    cd 
	echo "• Установка параметров ${green}HOSTINPL! •"
	a2ensite panel > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Остановка демо сайта ${green}000-default! •"
	a2dissite 000-default > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Запуск ${green}rewrite! •"
	a2enmod rewrite > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Запуск ${green}php5! •"
	a2enmod php5 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Запуск ${green}short_open_tab! •"
	sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php5/apache2/php.ini	> /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Перезагрузка ${green}apache! •"
	service apache2 restart > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
   (crontab -l ; echo "0 12 * * * curl http://$DOMAIN/main/cron/index?token=$CRONTOKE") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
	(crontab -l ; echo "*/1 * * * * curl http://$DOMAIN/main/cron/updateSystemLoad?token=$CRONTOKE") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
	(crontab -l ; echo "0 */1 * * * curl http://$DOMAIN/main/cron/updateStats?token=$CRONTOKE") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
	(crontab -l ; echo "0 */10 * * * curl http://$DOMAIN/main/cron/serverReloader?token=$CRONTOKE") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
	(crontab -l ; echo "0 12 * * * curl http://$DOMAIN/main/cron/gamelocationstatsupd?token=$CRONTOKE") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
	(crontab -l ; echo "0 * 7 * * curl http://$DOMAIN/main/cron/clearLogs?token=$CRONTOKE") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
	echo "• Установка пакета ${green}zip unzip! •"
	apt-get install -y zip unzip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Создание папки ${green}/var/www! •"
	mkdir /var/www/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${green}[Папка существует]"
		tput sgr0
	fi
	cd /var/www/
	echo "• Загрузка ${green}HOSTINPL 5.4 PRO (Fix by kvsqex)! •"
	wget https://www.dropbox.com/pri/get/panelweb.zip?_download_id=578578722347607131202579954870724977887169305046442815421157482914&_notify_domain=www.dropbox.com&_subject_uid=3135605264&dl=1&w=AABhaI-H5Qg1gua2YF176Iu0ru-_bX1OqpCbd64EreFM3w > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Распаковка ${green}HOSTINPL 5.4 PRO (Fix by kvsqex)! •"
	unzip panelweb.zip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Удаление архива ${green}HOSTINPL! •"
	rm panelweb.zip > /dev/null 2>&1
	rm -Rfv /var/www/html > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Настройка панели управления •"
	echo "• Вводим пароль от ${green}mysql-server! •"
    sed -i "s/parol/${MYPASS}/g" /var/www/application/config.php > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Вводим ${green}домен! •"
	sed -i "s/domen.ru/${DOMAIN}/g" /var/www/application/config.php > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Вводим код ${green}рекапчи! •"
	sed -i "s/Ключ/${RECAPT}/g" /var/www/application/config.php > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Вводим код ${green}крона! •"
	sed -i "s/xtwcklwhw222a/${CRONTOKE}/g" /var/www/application/config.php > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	chmod -R 755 /var/www/
	cd
	echo "• Создание папки ${green}/var/lib/mysql/hostin! •"
	mkdir /var/lib/mysql/hostin > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${green}[Папка существует]"
		tput sgr0
	fi
	chown -R mysql:mysql /var/lib/mysql/hostin
    cd	
	echo "• Загрузка ${green}hostinpl.sql! •"
	wget http://hos7.ru/testingpl/hostinpl.sql > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	cd
	echo "• Установка ${green}hostinpl.sql! •"
	mysql -u root -p$MYPASS hostin < hostinpl.sql > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Удаление ${green}hostinpl.sql! •"
	rm hostinpl.sql > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	chown -R www-data:www-data /var/www/
	chmod -R 755 /var/www/
	
	echo "• Настройка серверной части! •"
	
	echo "• Создание папки ${green}/home! •"
		mkdir -p /home/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${green}[Папка существует]"
		tput sgr0
	fi
		echo "• Создание группы ${green}gameservers! •"
		groupadd gameservers > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		echo "• Обновление ${green}списока пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Установка ${green}sudo zip unzip openssh-server python3 screen! •"
		apt-get install -y sudo zip unzip openssh-server python3 screen > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
		echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
		echo "• Обновление ${green}списка пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			cd /home/
			echo "• Загрузка ${green}игр! •"
			wget https://hos7.ru/testingpl/hostplcp.zip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			echo "• Распаковка ${green}игр! •"
			unzip hostplcp.zip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			rm hostplcp.zip
			echo "• Выдача прав ${green}на папки и файлы! •"
			chown -R root /home/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	        chmod -R 755 /home/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			cd
			cd /home/cp/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			chmod -R 700 /home/cp/gameservers.py > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			cd			
		OS=$(lsb_release -s -i -c -r | xargs echo |sed 's; ;-;g' | grep Ubuntu)
		echo "• Добавление пакетов ${green}x32! •"
	sudo dpkg --add-architecture i386 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Обновление ${green}списка пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Установка ${green}libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386! •"
    sudo apt-get install -y libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Закрытие доступа к ssh группе ${green}gameservers! •"
    echo 'DenyGroups gameservers' » /etc/ssh/sshd_config	 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Обновление ${green}списка пакетов! •"
	apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Установка ${green}pure-ftpd! •"
	apt-get install -y pure-ftpd > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone
	echo "yes" > /etc/pure-ftpd/conf/CreateHomeDir
	echo "yes" > /etc/pure-ftpd/conf/DontResolve 
	echo "• Перезагрузка ${green}pure-ftpd! •"
	/etc/init.d/pure-ftpd restart > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi

		log_s
		log_n "${white}Панель управления ${red} HOSTINPL 5.4 PRO ${white} установлена и настроена!"
		log_n ""
		log_n "${white} Пользователь от ${red} MySQL${white}: root"
		log_n ""
		log_n "${white} Root пароль от ${red} MySQL${white}: $MYPASS"
		log_n "${white} Ссылка на ${red} MySQL${white}: http://$DOMAIN/phpmyadmin"
		log_n ""
		log_n "${white} Ссылка на ${red} ваш хостинг: ${white}http://$DOMAIN"
		log_n "${white} Выдели и нажми Ctrl+C далее нажми правой кнопкой мышки (вставить)"
		log_n ""
		cp_s
		rm -f LOG_PIPE
	;;
		2) echo "• Создание папки ${green}/home! •"
		mkdir -p /home/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${green}[Папка существует]"
		tput sgr0
	fi
		echo "• Создание группы ${green}gameservers! •"
		groupadd gameservers > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		echo "• Обновление ${green}списка пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Установка ${green}sudo zip unzip openssh-server python3 screen! •"
		apt-get install -y sudo zip unzip openssh-server python3 screen > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
		echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
		echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
		echo "• Обновление ${green}списка пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			cd /home/
			echo "• Загрузка ${green}игр! •"
			wget https://hos7.ru/testingpl/hostplcp.zip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			echo "• Распаковка ${green}игр! •"
			unzip hostplcp.zip > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			rm hostplcp.zip
			echo "• Выдача прав ${green}на папки и файлы! •"
			chown -R root /home/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	        chmod -R 755 /home/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			cd
			cd /home/cp/ > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			chmod -R 700 /home/cp/gameservers.py > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			cd			
		OS=$(lsb_release -s -i -c -r | xargs echo |sed 's; ;-;g' | grep Ubuntu)
		echo "• Добавление пакетов ${green}x32! •"
	sudo dpkg --add-architecture i386 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Обновление ${green}списка пакетов! •"
		apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Установка ${green}libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386! •"
    sudo apt-get install -y libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Ограничение доступа к ssh группе ${green}gameservers! •"
    echo 'DenyGroups gameservers' » /etc/ssh/sshd_config	 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Обновление ${green}списка пакетов! •"
	apt-get update > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "• Установка ${green}pure-ftpd! •"
	apt-get install -y pure-ftpd > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
	echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone
	echo "yes" > /etc/pure-ftpd/conf/CreateHomeDir
	echo "yes" > /etc/pure-ftpd/conf/DontResolve 
	echo "• Перезагрузка ${green}pure-ftpd! •"
	/etc/init.d/pure-ftpd restart > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "${green}[OK]"
		tput sgr0
	else
		echo "${red}[fail]"
		tput sgr0
		exit
	fi
			;;
	
		0) exit;;
	esac
}
menu