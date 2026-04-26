#!/bin/bash
clear
echo "================================================="
echo "   INGFRANMICROLAB - EJECUCIÓN TEST DMGG         "
echo "================================================="

pci_id=$(lspci | grep -Ei "VGA|Display" | grep -Ei "AMD|Radeon" | awk '{print $1}' | head -n 1)
mem_addr=$(lspci -v -s $pci_id | grep "Memory at" | head -n 1 | awk '{print $3}')

if [ -z "$mem_addr" ]; then
    echo "❌ Error: No se detectó dirección de memoria."
    exit 1
fi

echo "📍 Dirección detectada: $mem_addr"
echo "-------------------------------------------------"
read -p "MB a testear [Default 10]: " mb
mb=${mb:-10}
read -p "Número de chips [Default 8]: " chips
chips=${chips:-8}

echo ""
echo "🚀 Lanzando: python3 /root/dmgg.py $mem_addr $mb $chips"
echo "-------------------------------------------------"

# Ejecuta el script de python (asegúrate de que dmgg.py esté en /root/)
python3 /root/dmgg.py $mem_addr $mb $chips
