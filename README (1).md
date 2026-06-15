# 🔍 Monitor de Rede Local

Ferramenta em Bash para detectar dispositivos **não autorizados** conectados à rede local. Desenvolvida para uso doméstico como exercício prático de monitoramento de rede.

## 💡 Motivação

Redes domésticas raramente são monitoradas. Qualquer dispositivo que se conectar ao roteador — seja um vizinho usando o Wi-Fi, um ataque de reconhecimento, ou um gadget esquecido — passa despercebido. Este script resolve isso de forma simples e sem depender de interfaces gráficas.

## ⚙️ Como funciona

1. Define uma lista de IPs **conhecidos e autorizados** (seus dispositivos)
2. Executa uma varredura na rede local via `nmap -sn` (ping scan — sem invasão de portas)
3. Compara os IPs detectados com a lista autorizada
4. Exibe e registra em log qualquer IP fora da lista

```
Rede local (192.168.1.0/24)
         │
         ▼
    nmap -sn
         │
         ▼
  IPs detectados ──► Comparação com lista ──► ✅ Limpo
                                          └──► ⚠️  Alerta + Log
```

## 🛠️ Dependências

- `bash` (já incluso em qualquer Linux/macOS)
- `nmap` — instalação:
  ```bash
  # Debian/Ubuntu
  sudo apt install nmap

  # Arch
  sudo pacman -S nmap
  ```

## 🚀 Como usar

**1. Clone o repositório:**
```bash
git clone https://github.com/seu-usuario/portfolio-cybersec.git
cd portfolio-cybersec/ferramentas/monitor-rede
```

**2. Edite o script com seus IPs:**
```bash
nano verificaroteador.sh
```

Altere a seção `IPS_CONHECIDOS` com os IPs dos seus dispositivos:
```bash
IPS_CONHECIDOS=(
    "192.168.1.1"   # Roteador
    "192.168.1.5"   # Seu celular
    # ...
)
```

**3. Dê permissão e execute:**
```bash
chmod +x verificaroteador.sh
sudo ./verificaroteador.sh
```

## 📋 Exemplo de saída

```
========================================
 Monitor de Rede Local
 2025-06-10 22:30:00
========================================
Iniciando varredura em 192.168.1.0/24...
----------------------------------------
⚠️  ATENÇÃO: Dispositivos desconhecidos encontrados!

IPs suspeitos:
192.168.1.45
192.168.1.99

----------------------------------------
Log salvo em: ./log_varredura.txt
```

## ⏰ Automatizando com cron

Para rodar a cada 30 minutos automaticamente:

```bash
crontab -e
```

Adicione a linha:
```
*/30 * * * * /caminho/para/verificaroteador.sh >> /var/log/monitor-rede.log 2>&1
```

## 🔐 Conceitos de segurança aplicados

| Conceito | Aplicação |
|---|---|
| **Network Reconnaissance** | Uso do `nmap` para mapeamento passivo |
| **Allowlist (lista branca)** | Abordagem deny-by-default: tudo que não está na lista é suspeito |
| **Log de segurança** | Registro com timestamp de todos os eventos |
| **Automação defensiva** | Integração com cron para monitoramento contínuo |

## 📌 Próximas melhorias planejadas

- [ ] Notificação por e-mail ou Telegram ao detectar intruso
- [ ] Resolução de hostname dos IPs detectados
- [ ] Scan com identificação de fabricante via MAC address
- [ ] Integração com `arp-scan` como alternativa ao nmap

## ⚠️ Aviso Legal

Esta ferramenta é para uso **exclusivo na sua própria rede**. Executar scans em redes de terceiros sem autorização é ilegal e antiético.

---

*Desenvolvido por Matheus Lima Pimenta como parte do portfólio de estudos em cibersegurança.*
