#!/bin/bash
read -s -p "SSH Password: " password
echo ""

read -s -p "Desired User Password: " userpass
echo ""
hosts=(zdvuww1 zdvuww2 zdvuwm1 zdvuws1)

echo "Building install.sh..."
sed "s/{{PASSWORD}}/$userpass/gI" install.tmpl > install.sh
echo "Done"

for h in "${hosts[@]}"; do
  echo ""
  echo "Handling $h"
  
  sshpass -p "$password" scp install.sh root@${h}.kzdv.io:/tmp/install.sh
  sshpass -p "$password" ssh root@${h}.kzdv.io "bash /tmp/install.sh ${h}.kzdv.io"

  echo ""
  echo "Done"
done

echo "Cleaning up install.sh"
rm install.sh
