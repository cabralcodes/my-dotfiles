#!/bin/bash

# Verifica se o Spotify está rodando
if ! pgrep -x "spotify" > /dev/null && ! pgrep -f "spotify-launcher" > /dev/null; then
    echo '{"text": "", "tooltip": "Spotify Fechado"}'
    exit 0
fi

# Pega os metadados do playerctl
TITLE=$(playerctl -p spotify metadata --format '{{title}}' 2>/dev/null)
ARTIST=$(playerctl -p spotify metadata --format '{{artist}}' 2>/dev/null)
ALBUM=$(playerctl -p spotify metadata --format '{{album}}' 2>/dev/null)

# Se estiver vazio (ex: aberto mas sem música carregada)
if [ -z "$TITLE" ]; then
    echo '{"text": " Sem música", "tooltip": "Nenhuma música tocando no momento."}'
    exit 0
fi

# Corta o texto se for muito longo para não quebrar a barra
TEXT_DISPLAY="${ARTIST} - ${TITLE}"
if [ ${#TEXT_DISPLAY} -gt 40 ]; then
    TEXT_DISPLAY="${TEXT_DISPLAY:0:37}..."
fi

# Monta o Tooltip Retangular exatamente como você pediu
TOOLTIP="┌──────────────────────────────┐\n"
TOOLTIP+="│        PLAYER SPOTIFY        │\n"
TOOLTIP+="├──────────────────────────────┤\n"
TOOLTIP+="│ 󰎆 Música: ${TITLE}\n"
TOOLTIP+="│ 󰠃 Artista: ${ARTIST}\n"
TOOLTIP+="│ 󰠎 Álbum: ${ALBUM}\n"
TOOLTIP+="├──────────────────────────────┤\n"
TOOLTIP+="│  󰒮 Anterior | 󰐊/󰏤 Play | 󰒭 Próxima │\n"
TOOLTIP+="│     (Use o Scroll do Mouse)  │\n"
TOOLTIP+="└──────────────────────────────┘"

# Retorna o JSON limpo para a Waybar
echo "{\"text\": \" ${TEXT_DISPLAY}\", \"tooltip\": \"${TOOLTIP}\"}"
