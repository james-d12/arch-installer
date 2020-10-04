#!/usr/bin/env bash

restrict_kernel_log_access(){
    echo "kernel.dmesg_restrict = 1" >> /etc/sysctl.d/51-dmesg-restrict.conf
}

set_user_login_timeout(){
    echo "auth optional pam_faildelay.so delay=4000000" >> /etc/pam.d/system-login
}

deny_ip_spoofs(){
    echo "order bind, hosts\n multi on" >> /etc/host.conf
}

configure_apparmor_and_firejail(){
    if [[ command -v firejail > /dev/null && command -v apparmor ]]; then 
        firecfg
        sudo apparmor_parser -r /etc/apparmor.d/firejail-default
    fi 
}

configure_firewall(){
    if command -v ufw > /dev/null; then
        echo -e "${MSGCOLOUR}Configuring the firewall....${NC}"
        sudo ufw limit 22/tcp  
        sudo ufw limit ssh
        sudo ufw allow 80/tcp  
        sudo ufw allow 443/tcp  
        sudo ufw default deny
        sudo ufw default deny incoming  
        sudo ufw default allow outgoing
        sudo ufw allow from 192.168.0.0/24
        sudo ufw allow Deluge
        sudo ufw enable
    fi
}

configure_sysctl(){
    if command -v sysctl > /dev/null; then
        echo -e "${MSGCOLOUR}Hardening sysctl....${NC}"
        sudo sysctl kernel.modules_disabled=1
        sudo sysctl -a
        sudo sysctl -A
        sudo sysctl mib
        sudo sysctl net.ipv4.conf.all.rp_filter
        sudo sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'
    fi
}

configure_fail2ban(){
    if command -v fail2ban > /dev/null; then
        echo -e "${MSGCOLOUR}Setting up fail2ban....${NC}"
        sudo cp fail2ban.local /etc/fail2ban/
        sudo systemctl enable fail2ban
        sudo systemctl start fail2ban
    fi
}