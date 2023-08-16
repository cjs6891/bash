#/bin/bash

V-230234 () {
## V-230234 - RHEL 8 operating systems booted with United Extensible Firmware Interface (UEFI) must require authentication upon booting into single-user mode and maintenance.
grub2_passwd="toor"
grub2_passwd_encrypted=$(/usr/bin/echo -e "$grub2_passwd\n$grub2_passwd" | /usr/bin/grub2-mkpasswd-pbkdf2)
/usr/sbin/grub2-setpassword <<< "$grub2_passwd_encrypted"
}


V-230244 () {
## V-230244 - RHEL 8 must be configured so that all network connections associated with SSH traffic are terminated at the end of the session or after 10 minutes of inactivity, except to fulfill documented and validated mission requirements.
/usr/bin/sed -i '/^ClientAliveInterval/d' /etc/ssh/sshd_config
/usr/bin/sed -i '/^ClientAliveCountMax/d' /etc/ssh/sshd_config
/usr/bin/echo "ClientAliveInterval 600" >> /etc/ssh/sshd_config
/usr/bin/echo "ClientAliveCountMax 0" >> /etc/ssh/sshd_config
/usr/bin/systemctl restart sshd.service
}


V-230311 () {
## V-230311 - RHEL 8 must disable the kernel.core_pattern.
/usr/bin/echo "kernel.core_pattern = |/bin/false" > /etc/sysctl.d/99-disable-core-dumps.conf
/usr/sbin/sysctl --system
}


V-230333 () {
## V-230333 - RHEL 8 must automatically lock an account when three unsuccessful logon attempts occur.
/usr/bin/sed -i '/^deny/d' /etc/security/faillock.conf
/usr/bin/echo "deny=3" >> /etc/security/faillock.conf

/usr/bin/sed -i '/^auth.*pam_faillock.so.*preauth/d' /etc/pam.d/system-auth
/usr/bin/sed -i '/^auth.*pam_faillock.so.*authfail/d' /etc/pam.d/system-auth
/usr/bin/sed -i '/^account.*pam_faillock.so/d' /etc/pam.d/system-auth
/usr/bin/echo "auth required pam_faillock.so preauth silent audit deny=3 even_deny_root fail_interval=900" >> /etc/pam.d/system-auth
/usr/bin/echo "auth required pam_faillock.so authfail silent audit deny=3 even_deny_root fail_interval=900" >> /etc/pam.d/system-auth
/usr/bin/echo "account required pam_faillock.so" >> /etc/pam.d/system-auth

/usr/bin/sed -i '/^auth.*pam_faillock.so.*preauth/d' /etc/pam.d/password-auth
/usr/bin/sed -i '/^auth.*pam_faillock.so.*authfail/d' /etc/pam.d/password-auth
/usr/bin/sed -i '/^account.*pam_faillock.so/d' /etc/pam.d/password-auth
/usr/bin/echo "auth required pam_faillock.so preauth silent audit deny=3 even_deny_root fail_interval=900" >> /etc/pam.d/password-auth
/usr/bin/echo "auth required pam_faillock.so authfail silent audit deny=3 even_deny_root fail_interval=900" >> /etc/pam.d/password-auth
/usr/bin/echo "account required pam_faillock.so" >> /etc/pam.d/password-auth
}


V-230335 () {
## V-230335 - RHEL 8 must automatically lock an account when three unsuccessful logon attempts occur during a 15-minute time period.
/usr/bin/echo "auth required pam_faillock.so preauth dir=/var/log/faillock silent audit deny=3 even_deny_root fail_interval=900 unlock_time=0" >> /etc/pam.d/system-auth
/usr/bin/echo "auth required pam_faillock.so authfail dir=/var/log/faillock unlock_time=0" >> /etc/pam.d/system-auth

/usr/bin/echo "auth required pam_faillock.so preauth dir=/var/log/faillock silent audit deny=3 even_deny_root fail_interval=900 unlock_time=0" >> /etc/pam.d/password-auth
/usr/bin/echo "auth required pam_faillock.so authfail dir=/var/log/faillock unlock_time=0" >> /etc/pam.d/password-auth
}


V-230341 () {
## V-230341 - RHEL 8 must prevent system messages from being presented when three unsuccessful logon attempts occur.
/usr/bin/echo "auth required pam_faillock.so preauth" >> /etc/pam.d/system-auth
/usr/bin/echo "auth required pam_faillock.so authfail" >> /etc/pam.d/system-auth
#/usr/bin/echo "account required pam_faillock.so" >> /etc/pam.d/system-auth

/usr/bin/echo "auth required pam_faillock.so preauth" >> /etc/pam.d/password-auth
/usr/bin/echo "auth required pam_faillock.so authfail" >> /etc/pam.d/password-auth
#/usr/bin/echo "account required pam_faillock.so" >> /etc/pam.d/password-auth
}


V-230343 () {
## V-230343 - RHEL 8 must log user name information when unsuccessful logon attempts occur.
#/usr/bin/echo "auth required pam_faillock.so preauth" >> /etc/pam.d/system-auth
/usr/bin/echo "auth required pam_faillock.so authfail audit" >> /etc/pam.d/system-auth
#/usr/bin/echo "account required pam_faillock.so" >> /etc/pam.d/system-auth

#/usr/bin/echo "auth required pam_faillock.so preauth" >> /etc/pam.d/password-auth
/usr/bin/echo "auth required pam_faillock.so authfail audit" >> /etc/pam.d/password-auth
#/usr/bin/echo "account required pam_faillock.so" >> /etc/pam.d/password-auth
}


V-230348 () {
## V-230348 - RHEL 8 must enable a user session lock until that user re-establishes access using established identification and authentication procedures for command line sessions.
/usr/bin/echo "set -g lock-command vlock" > /etc/tmux.conf
/usr/bin/echo "set -g lock-after-time 900" >> /etc/tmux.conf
/usr/bin/echo "bind X lock-session" >> /etc/tmux.conf
}


V-230349 () {
## V-230349 - RHEL 8 must ensure session control is automatically started at shell initialization.
/usr/bin/echo "[ -n \"\$PS1\" -a -z \"\$TMUX\" ] && exec tmux" >> /etc/bashrc
}


V-230364 () {
## V-230364 - RHEL 8 passwords must have a 24 hours/1 day minimum password lifetime restriction in /etc/shadow.
/usr/bin/echo ""
}


V-230367 () {
## V-230367 - RHEL 8 user account passwords must be configured so that existing passwords are restricted to a 60-day maximum lifetime.
/usr/bin/echo ""
}


V-230368 () {
## V-230368 - RHEL 8 must be configured in the password-auth file to prohibit password reuse for a minimum of five generations.
/usr/bin/echo ""
}


V-230377 () {
## V-230377 - RHEL 8 must prevent the use of dictionary words for passwords.
/usr/bin/echo "dictcheck=1" >> /etc/security/pwquality.conf
}

#########################

V-230234
V-230244
V-230311
V-230333
V-230335
V-230341
V-230343
V-230348
V-230349
V-230364
V-230367
V-230368
V-230377
