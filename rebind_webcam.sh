
if [ -z "$1" ]; then
  echo ""
  echo "Argument \033[0;32m[VENDOR_ID]\033[0m must be supplied."
  echo "i.e.: 046d (Logitech)"
  echo ""
  exit 1;
fi

VID="$1"

bind_usb() {
  echo "$1" >/sys/bus/usb/drivers/usb/bind
}

unbind_usb() {
  echo "$1" >/sys/bus/usb/drivers/usb/unbind
}

# find proper usb port and rebind
for USB in /sys/bus/usb/devices/*; do 
  if [ -f "$USB/idVendor" ]; then

    FOUND_VID=${ cat "$USB/idVendor" }

    if [ "$FOUND_VID" == "$VID" ]
    then
      PORT=${USB##*/}

      echo -e  "\n\033[0;32mFound usb port $PORT with vendor id : $VID.\033[0m"
      
      echo "Disconnect usb port..."
      unbind_usb "$PORT"
      
      sleep 5
      
      echo "Reconnect usb port..."
      bind_usb "$PORT"
      echo "\n\033[0;32mFinished.\033[0m"
      echo ""
    fi
  fi
done
