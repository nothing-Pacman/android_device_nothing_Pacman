#!/vendor/bin/sh

cp -rf /vendor/etc/sttesttool.json /data/nfc/sttesttool.json
chmod 666 /data/nfc/sttesttool.json

sku=`getprop ro.boot.hardware.sku`
case "$sku" in
    "JPN")
        setprop persist.vendor.st_nfc_felica_ese 1
        ;;
    *)
        setprop persist.vendor.st_nfc_felica_ese 0
esac

