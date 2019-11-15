# Rebind Android USB device.

Shell script for rebind android usb devices such as webcam or disk without physical plug in-out.
You can find connected usb device list via command-line script below.

```bash
for X in /sys/bus/usb/devices/*; do 
  echo "$X"
  cat "$X/idVendor" 2>/dev/null 
  cat "$X/idProduct" 2>/dev/null
  echo
done
```
