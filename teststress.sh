#!/bin/bash
# Script de estrés de memoria para ingfranmicrolab

clear
echo "================================================="
echo "   INGFRANMICROLAB - STRESS TEST (MEMTEST)       "
echo "================================================="

# Detectar dirección de memoria automáticamente
pci_id=$(lspci | grep -Ei "VGA|Display" | grep -Ei "AMD|Radeon" | awk '{print $1}' | head -n 1)
mem_addr=$(lspci -v -s $pci_id | grep "Memory at" | head -n 1 | awk '{print $3}')

if [ -z "$mem_addr" ]; then
    echo "❌ Error: Hardware no detectado para el test de estrés."
    exit 1
fi

echo "✅ GPU Detectada en: $mem_addr"
echo "-------------------------------------------------"

# Parámetro con valor predeterminado (Enter = 10MB)
read -p "Cantidad de MB para stress [Default 10]: " mb
mb=${mb:-10}

echo ""
echo "🚀 Iniciando Ciclos de Estrés: python3 memtest.py $mem_addr $mb"
echo "-------------------------------------------------"

# Ejecución desde la carpeta donde copies los archivos del pendrive
# Asumiremos que los pones en /root/ para consistencia
python3 /root/memtest.py $mem_addr $mb

echo ""
echo "================================================="
echo "        ESTRÉS FINALIZADO - INGFRANMICROLAB      "
echo "================================================="
