#!/bin/bash

echo "🔄 Aggiornamento sistema..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installazione Nextcloud Desktop (Flatpak)..."
flatpak install -y flathub org.nextcloud.Nextcloud

echo "🔗 Installazione integrazione con Nemo..."
sudo apt install -y nemo-nextcloud

echo "🎨 Applicazione tema Catppuccin..."
# Assicuriamoci che Flatpak usi i temi di sistema
flatpak install -y flathub org.gtk.Gtk3theme.Catppuccin-Mocha
flatpak install -y flathub org.gtk.Gtk3theme.Catppuccin-Latte
flatpak install -y flathub org.gtk.Gtk3theme.Catppuccin-Frappe
flatpak install -y flathub org.gtk.Gtk3theme.Catppuccin-Macchiato

# Colleghiamo il tema attivo a Flatpak
THEME=$(gsettings get org.cinnamon.desktop.interface gtk-theme | tr -d \')
echo "➡️ Tema GTK attuale: $THEME"
flatpak override --user --env=GTK_THEME=$THEME org.nextcloud.Nextcloud

echo "🎨 Applicazione icone Papirus..."
flatpak install -y flathub org.freedesktop.Platform.IconThemes
flatpak override --user --filesystem=~/.icons org.nextcloud.Nextcloud
flatpak override --user --filesystem=/usr/share/icons org.nextcloud.Nextcloud

echo "✅ Installazione completata!"
echo ""
echo "👉 Puoi avviare Nextcloud dal menu con il nome 'Nextcloud'."
echo "👉 Per ricaricare Nemo e vedere le icone di stato, esegui: nemo -q"

