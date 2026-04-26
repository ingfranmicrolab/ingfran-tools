#!/bin/bash
clear
echo "================================================="
echo "   INGFRANMICROLAB - INSPECCIÓN DE HARDWARE      "
echo "================================================="

# Detectar el ID PCI de la tarjeta AMD
pci_id=$(lspci | grep -Ei "VGA|Display" | grep -Ei "AMD|Radeon" | awk '{print $1}' | head -n 1)

if [ -z "$pci_id" ]; then
    echo ""
    echo "❌ ERROR: NO SE DETECTA NINGUNA GPU AMD"
    echo "-------------------------------------------------"
    echo "POSIBLES CORRECTIVOS:"
    echo "1. Revisar alimentación del Riser (6-pin)."
    echo "2. Verificar cable USB del Riser."
    echo "3. Posible corto en líneas de 12V o 3.3V de la GPU."
    echo "-------------------------------------------------"
    read -p "¿Deseas APAGAR el equipo para revisar? (s/n): " op
    [[ "$op" == "s" || "$op" == "S" ]] && poweroff
else
    info_full=$(lspci -s $pci_id)
    subsystem=$(lspci -v -s $pci_id | grep "Subsystem" | sed 's/Subsystem: //')
    mem_addr=$(lspci -v -s $pci_id | grep "Memory at" | head -n 1 | awk '{print $3}')
    echo "✅ DISPOSITIVO DETECTADO:"
    echo "   Modelo: $info_full"
    echo "   Vendor: $subsystem"
    echo "   Dirección BAR (Memoria): $mem_addr"
    echo "-------------------------------------------------"
    echo "Hardware listo para el diagnóstico."
fi
