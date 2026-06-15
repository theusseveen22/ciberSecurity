#!/bin/bash

# =============================================================================
# monitor-rede.sh — Detector de dispositivos desconhecidos na rede local
# Autor: Matheus Lima Pimenta
# =============================================================================

# --- 1. CONFIGURAÇÃO DOS IPS CONHECIDOS ---
# Adicione os IPs dos seus dispositivos autorizados
IPS_CONHECIDOS=(
    "192.168.1.1"   # Roteador
    "192.168.1.5"   # Celular principal
    "192.168.1.6"   # Celular secundário
    "192.168.1.10"  # TV
    "192.168.1.20"  # Notebook
)

# --- 2. CONFIGURAÇÃO DA REDE ---
REDE="192.168.1.0/24"
LOG_FILE="$(dirname "$0")/log_varredura.txt"
DATA_HORA=$(date '+%Y-%m-%d %H:%M:%S')

echo "========================================"
echo " Monitor de Rede Local"
echo " $DATA_HORA"
echo "========================================"
echo "Iniciando varredura em $REDE..."

# --- 3. VARREDURA COM NMAP ---
ips_detectados=$(sudo nmap -sn "$REDE" \
    | grep "Nmap scan report" \
    | awk '{print $NF}' \
    | tr -d '()')

ips_desconhecidos=""

# --- 4. COMPARAÇÃO ---
for ip in $ips_detectados; do
    if [[ ! " ${IPS_CONHECIDOS[@]} " =~ " ${ip} " ]]; then
        ips_desconhecidos+="$ip\n"
    fi
done

# --- 5. RESULTADO ---
echo "----------------------------------------"
if [ -z "$ips_desconhecidos" ]; then
    echo "✅ Tudo limpo! Nenhum dispositivo desconhecido."
    echo "[$DATA_HORA] OK - Nenhum intruso detectado." >> "$LOG_FILE"
else
    echo "⚠️  ATENÇÃO: Dispositivos desconhecidos encontrados!"
    echo ""
    echo "IPs suspeitos:"
    echo -e "$ips_desconhecidos"
    echo "[$DATA_HORA] ALERTA - IPs desconhecidos: $ips_desconhecidos" >> "$LOG_FILE"
fi
echo "----------------------------------------"
echo "Log salvo em: $LOG_FILE"
