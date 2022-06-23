;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	pv2.pvnet.example.ru. root.pvnet.example.ru. (
		       22061843		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
; name servers - NS records - определяем имена DNS-серверов
@ IN      NS      pv2.pvnet.example.ru.
;
; name servers - A records - определяем адреса компьютеров, сначала сервер(ы) DNS
pv2.pvnet.example.ru.           IN      A      192.168.225.138
;
; 192.168.32.0/24 - A records - а потом все остальные компьютер(ы) сети
pv.pvnet.example.ru.          	IN      A      192.168.225.211
brest.pvnet.example.ru.	IN	CNAME  pv.pvnet.example.ru.
dns.pvnet.example.ru.	IN	CNAME  pv2.pvnet.example.ru.
