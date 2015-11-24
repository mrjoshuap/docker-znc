oc new-project znc \
  --display-name="ZNC" \
  --description="ZNC is a portable, open source IRC bouncer written in C++."

oc new-app https://github.com/mrjoshuap/docker-znc.git --name="bouncer"

oc expose service bouncer
