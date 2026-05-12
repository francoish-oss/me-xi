#!/usr/bin/env bash

# 1. Remount /boot as Read-Write
echo "🔓 Unlocking /boot..."
sudo mount -o remount,rw /boot

# 2. Run the NixOS Switch
echo "❄️ Starting NixOS Rebuild..."
sudo nixos-rebuild switch

# 3. Remount /boot as Read-Only
echo "🔒 Locking /boot..."
sudo mount -o remount,ro /boot

echo "✅ Done! System is updated and /boot is secured."
read -p "Press enter to close..."
