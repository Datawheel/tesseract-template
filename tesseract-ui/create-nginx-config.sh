TESSERACT_URL=$1

length=${#TESSERACT_URL}
last_char=${TESSERACT_URL:length-1:1}

[[ $last_char != "/" ]] && TESSERACT_URL="$TESSERACT_URL/"; :

echo "
server { 
  listen 80;
  server_name _;

  location / {
    root /usr/share/nginx/html;
    try_files \$uri /index.html;
  }

  location /tesseract/ {
    proxy_pass ${TESSERACT_URL};
  }
}"