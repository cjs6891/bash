#/bin/bash

V-230223 () {
## V-230223 - RHEL 8 must implement NIST FIPS-validated cryptography for the following: to provision digital signatures, to generate cryptographic hashes, and to protect data requiring data-at-rest protections in accordance with applicable federal laws, Executive Orders, directives, policies, regulations, and standards.

/usr/bin/fips-mode-setup --enable
}


V-230235 () {
## V-230235 - RHEL 8 operating systems booted with a BIOS must require authentication upon booting into single-user and maintenance modes.

BIOS_PASSWD="toor"
/usr/bin/printf '%s\n' "$BIOS_PASSWD" "$BIOS_PASSWD" | /usr/bin/script -qf -c '/usr/sbin/grub2-setpassword' /dev/null
/usr/bin/cat /boot/grub2/user.cfg
/usr/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg
}


V-244540 () {
## V-244540 - RHEL 8 must not allow blank or null passwords in the system-auth file.
/usr/bin/sed -i 's/nullok\ //g' /etc/pam.d/system-auth
}


V-244541 () {
## V-244541 - RHEL 8 must not allow blank or null passwords in the password-auth file.
/usr/bin/sed -i 's/nullok\ //g' /etc/pam.d/password-auth
}


V-230300 () {
## V-230300 - RHEL 8 must prevent files with the setuid and setgid bit set from being executed on the /boot directory.
#/usr/bin/sed -i '/\/boot/s/defaults/defaults,nosuid/' /etc/fstab

if grep -q '/boot.*defaults,nosuid' /etc/fstab; then
    echo "V-230300"
else
    sed -i '/\/boot/s/defaults/defaults,nosuid/' /etc/fstab
fi
}


V-230503 () {
## V-230503 - RHEL 8 must be configured to disable USB mass storage.
if grep -q 'install usb-storage /bin/true' /etc/modprobe.d/blacklist.conf && grep -q 'blacklist usb-storage' /etc/modprobe.d/blacklist.conf; then
    echo "V-230503"
else
    echo "install usb-storage /bin/true" >> /etc/modprobe.d/blacklist.conf
    echo "blacklist usb-storage" >> /etc/modprobe.d/blacklist.conf
fi
}


V-230507 () {
## V-230507 - RHEL 8 Bluetooth must be disabled.
if grep -q "blacklist bluetooth" /etc/modprobe.d/blacklist.conf; then
    echo "V-230507"
else
    echo "blacklist bluetooth" >> /etc/modprobe.d/blacklist.conf
fi
}


V-237642 () {
## V-237642 - RHEL 8 must use the invoking user's password for privilege escalation when using "sudo".
if grep -q "Defaults !targetpw" /etc/sudoers /etc/sudoers.d/*; then
    echo "Defaults !targetpw exists in /etc/sudoers or /etc/sudoers.d/"
else
    echo "Defaults !targetpw does not exist in /etc/sudoers or /etc/sudoers.d/"
    echo "Defaults !targetpw" >> /etc/sudoers.d/defaults.conf
fi

if grep -q "Defaults !rootpw" /etc/sudoers /etc/sudoers.d/*; then
    echo "Defaults !rootpw exists in /etc/sudoers or /etc/sudoers.d/"
else
    echo "Defaults !rootpw does not exist in /etc/sudoers or /etc/sudoers.d/"
    echo "Defaults !rootpw" >> /etc/sudoers.d/defaults.conf
fi

if grep -q "Defaults !runaspw" /etc/sudoers /etc/sudoers.d/*; then
    echo "Defaults !runaspw exists in /etc/sudoers or /etc/sudoers.d/"
else
    echo "Defaults !runaspw does not exist in /etc/sudoers or /etc/sudoers.d/"
    echo "Defaults !runaspw" >> /etc/sudoers.d/defaults.conf
fi
}


V-230349 () {
## V-230349 - RHEL 8 must ensure session control is automatically started at shell initialization.
cat <<EOF > /etc/profile.d/custom.sh
if [ "\$PS1" ]; then
    parent=\$(ps -o ppid= -p \$\$)
    name=\$(ps -o comm= -p \$parent)
    case "\$name" in (sshd|login) tmux ;; esac
fi
EOF
}


V-230494 () {
## V-230494 - RHEL 8 must disable the asynchronous transfer mode (ATM) protocol.
if grep -q 'install atm /bin/true' /etc/modprobe.d/blacklist.conf && grep -q 'blacklist atm' /etc/modprobe.d/blacklist.conf; then
    echo "V-230494"
else
    echo "install atm /bin/true" >> /etc/modprobe.d/blacklist.conf
    echo "blacklist atm" >> /etc/modprobe.d/blacklist.conf
fi
}

#########################

V-230223
V-230235
V-244540
V-244541
V-230300
V-230503
V-230507
V-237642
V-230349
V-230494
