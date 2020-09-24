#!/bin/bash
date=`date +'%Y.%m.%d @ %T'`

##WSHEIN.COM
/bin/echo "Monitoring System Email... $date" | mailx -r "no-reply@wshein.com" -s "Monitoring System Email... $date" "cjs@wshein.com"

##GMAIL.COM
/bin/echo "_OUTBOUND Email TEST... $date" | mailx -r "no-reply@wshein.com" -s "_OUTBOUND Email TEST... $date" "heinonline.org@gmail.com"

##OUTLOOK.COM
/bin/echo "_OUTBOUND Email TEST... $date" | mailx -r "no-reply@wshein.com" -s "_OUTBOUND Email TEST... $date" "heinonline.org@outlook.com"

##YAHOO.COM
/bin/echo "_OUTBOUND Email TEST... $date" | mailx -r "no-reply@wshein.com" -s "_OUTBOUND Email TEST... $date" "heinonline.org@yahoo.com"


# --OR--
 
 #!/bin/bash
date=`date +'%Y.%m.%d @ %T'`
HOSTNAME=`hostname`

/bin/echo "$HOSTNAME email... $date" | mailx -r "no-reply@wshein.com" -s "$HOSTNAME email... $date" "cjs@wshein.com"
