#!/bin/bash

tokens=(
#  "8407022066:AAE_aztkTfyjkl66NRuBF6J1MhTxt3pqgUo"
#  "8332708016:AAGTbm6RVTe3eSt9UWbkU8VCGSSrn6nADJc"
#  "8339608498:AAH54orBOj6Cw-NmyIO3TWZ9rbS_OBMj_eE"
#  "8410274951:AAG0LtebaNr-WaYMoqMBJtiL_NYdqKWS6Ks"
 # "7973953933:AAG3E-kLso68hfAsCrZR4smc0uL8Ulg3fKk"
#  "8234310100:AAFh8hwhC0EuWsKKKPdnu3gNcnfiMXQDeLE"
  #"8287978101:AAEA8zOoDuv5T9aStKjvUldFFtQp8PgJoFc"
 # "7689012030:AAGgSWurMUElwFPnh6xkEniXkzjBKQhERqI"
 # "5520213910:AAF0Y15i-s-dnZiLVM6xCxAp7e5-WHz70Lc"
 # "7609887102:AAF9vMxFQPI8ffJ4uRzh1PRgjnA-7-89VzM"
  "7689012030:AAGgSWurMUElwFPnh6xkEniXkzjBKQhERqI"
  "5520213910:AAF0Y15i-s-dnZiLVM6xCxAp7e5-WHz70Lc"
  "7609887102:AAF9vMxFQPI8ffJ4uRzh1PRgjnA-7-89VzM"
)

user_id="7249019670"
chat_id="-1002489303434"
reply_id="699326"
clean_text="منم بکن مادرت هستم کیان بیناموس"

# Now the full Markdown message
text="[${clean_text}](tg://user?id=${user_id})"

echo ${text}
i=0

while true; do
  token_index=$((i % 10))
  token=${tokens[$token_index]}

  status_code=$(curl -s -o /dev/null -w "%{http_code}" -X POST "https://api.telegram.org/bot${token}/sendMessage" \
    -H "Content-Type: application/json" \
    -d "{
      \"chat_id\": ${chat_id},
      \"text\": \"[$clean_text](tg://user?id=$user_id)\",
      \"parse_mode\": \"MarkdownV2\",
      \"reply_to_message_id\": ${reply_id}
    }")

  echo "[$(date)] Token #$token_index -> HTTP $status_code"

  if [[ "$status_code" == "429" ]]; then
    echo "Rate limited cuh... sleeping 30s"
    sleep 30
  else
    sleep 2
  fi

  ((i++))
done
