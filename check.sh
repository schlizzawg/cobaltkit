#!/bin/sh

[ -f ./.env ] || {
    echo '[!] .env does not exist, please create it by copying .env.example' >&2;
    exit 1;
}

. ./.env;

check_mode() {
    if [ "$COBALT_MODE" = "both" ]; then
        [ "$WEB_DOMAIN" = "" ] && {
            echo '[!] mode is both, but WEB_DOMAIN is not set' >&2
            exit 1
        }
    elif [ "$COBALT_MODE" != "api" ]; then
        echo "[!] invalid mode: $MODE" >&2
        exit 1  
    fi

    [ "$API_DOMAIN" = "" ] && {
       echo '[!] API_DOMAIN is not set' >&2
       exit 1
    }

    [ "$WEB_DOMAIN" = "$API_DOMAIN" ] && {
        echo '[!] web domain cannot be the same as api domain' >&2
        exit 1
    }
}

check_ip() {
    PUBLIC_IP=$(curl -${1}s https://icanhazip.com)
    VERSION=$1 DNS_TYPE=$2 IP_ERR=0

    [ "$PUBLIC_IP" = "" ] && {
        echo "[?] server has no ipv${1}, skipping check"
        return
    }

    [ "$COBALT_MODE" = "both" ] && {
        WEB_IP=$(dig +short $DNS_TYPE "$WEB_DOMAIN")
        [ "$WEB_IP" != "$PUBLIC_IP" ] && {
            echo "[!] $DNS_TYPE record '$WEB_IP' for $WEB_DOMAIN does not match public-facing IPv$1 '$PUBLIC_IP'" >&2
            IP_ERR=1
        }
    }

    [ "$API_DOMAIN" != "" ] && {
        API_IP=$(dig +short $DNS_TYPE "$API_DOMAIN")
        [ "$API_IP" != "$PUBLIC_IP" ] && {
            echo "[!] $DNS_TYPE record '$API_IP' for $API_DOMAIN does not match public-facing IPv$1 '$PUBLIC_IP'" >&2
            IP_ERR=1
        }
    }

    [ "$IP_ERR" = 1 ] && {
        echo "    If you want your instance to support IPv${1}, you may want to fix this; otherwise, you may ignore it"
        echo "    The IP might also not match if you are using a WAF such as CloudFlare, in which case you can also ignore this"
        echo
    }
}

check_dns() {
  command -v curl >/dev/null || { echo 'no curl available, skipping dns check'; return; }
  command -v dig >/dev/null 2>/dev/null || { echo 'no dig available, skipping dns check'; return; }
  check_ip 4 A
  check_ip 6 AAAA
}

check_cors() {
  [ "$CORS" = 0 ] && return
  [ "$CORS" = 1 ] && return
  echo "Invalid CORS setting: $CORS" >&2
  exit 1
}

check_mode
check_dns
check_cors
echo ok
