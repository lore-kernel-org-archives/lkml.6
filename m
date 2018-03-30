Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49cM9ZIlKSRUK/rD7TEdJQO0xu/CM+mU5ScpEMw6gGKt0jKkb0LLeIs/YPgsAYml3zTjeWK
ARC-Seal: i=1; a=rsa-sha256; t=1522393761; cv=none;
        d=google.com; s=arc-20160816;
        b=aGPbprk9Q+MHATq7MTylPFlZQriJVoqSJgFlL3zNPoSAHvmkkNbFlV4yCBAlpEKNOX
         9jTvFs94vCkMLPgJ6L9XDj9a8w+ccegfxK7ZCNwnyfbU3k2+zx5uVI65vve/ifKoiDK1
         RgPiOEGFWZD2xsefzbwSdbSrQ+GwZos5O1F/w79z+UwrANeax8HEY7XTWBslCFqvTTpz
         R4sMH/nTTYAGb4oa0dcCkoIMpGqhStQLELKRhWtxi/jPSeWFnnCFsvTxXASaNqb1hq7j
         co6e3irXgosuTPy6jgyRmO40FkD/EC+zGyaBl3Kc8pNnPilRzCeagkLmMeC5hSnc4ISg
         L/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=QyX8GXqBF1yZyaylbVAHnYti6RH2pFdiRScaiIhBiJY=;
        b=xGwoMKCU19x9GOvWq+wZQpZkHq0ZbCPE84J87WUbjyFfb8EhC88na+MxF1wndk7CTY
         bzLzQJ1KPIj++DebNYvxZjgZ+reiun0Dz2SLK3TrGp0ASpcDNQFJaky4ymWBotOaYGO8
         laWI07U6h5XkAoOukjJQYvJexkDsoQQLC4/tAsXJrZZ0PdICn44LgbbWIhymt3QuRx1E
         YmQsj/PLfJmKiPaAqxPY0wGkvN6UI1+KGdvSGceV+fpKsaPx4bHk2pfQ26oHMEqtW+mG
         PqIu4N2UBL3411dpD72o4tykovZ7/Q0nUP6UmZa5GfVGkSLUmI2WWt+xspWmjANrt2xM
         gE7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 26/76] staging: ks7010: Remove trailing _t from 'struct ap_info_t'.
Date: Fri, 30 Mar 2018 00:07:49 -0700
Message-Id: <20180330070842.25224-26-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:LvPM1oytworE+lGiHAYJLMmli2yYhq4gU2shyx09pt+H+UPERvW
 IWFFNdAn3w9fv20DuHFU8Zm83kIxvWRr7m/T2ZDOfJQFNGfATCqTkX13ev1qD5cNnlVA92Y
 vRcJPtW2JmKIj6twDNzS8d0fvJaTcAv4Atm5DtI9+mrhVJqmuf3XQt5+ZpieUEwgT4oeRdi
 13MhJL5NPPi7wk13wL19w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lE6RvvzvVXs=:Ma+lAD8MW0EK8m8TrECiEt
 kHSYrpw4lpywRXUnqGamP6T5CITA0Nv6rvmyifLLyhW100WOxOcoDJKwiLQtze2AtZpVH2fsk
 qDbsT2oKjsDBLlDhXzEwdFzAtPSPU/rPZKfxOf1ueyaPtODxAg2FR+CDxNmzthGmyJd8CCkWm
 U8hff2UsKwo+UZfeOBcmVXeHA2QU0BtpEGaRDU5O01IJwkwMkwJH4IxZmRkJ2gAlF4oZr7Hdt
 JboK/XK7yR0zZV7YO5pb9YgoAfi1GDX0wLGfNOlI6P7eJxsv0dFr+SsHtMgH2A51Nbvz2NMee
 qgJLMsNLb21JjEvduQHiFj0THhctVCnpI0O4Uuq22mP+uR5IYlfsH8zIDQVDjeSvZ6B1c0chP
 v1/sY2prO8urNc5MP5vTWk+hfYXKoJ1v6zYHO58xOzCZm0sTpu9WOBXik2DoZnKuqI/BpEk+G
 EoKY8FAel1FeftI9q5goBJPIaSUAivrt7liHec1XMQmVH4BLvaaA1cCD1ewYO5XgInXGM7QAW
 2D44v383fOumqs1UUs9H+N8bioXbQlmtssShPx+HLFlPHX6Ag/5rmbwc4rtL6x6L5t1Z7tNLf
 YD+HLD73S2nW6rUCCN4NnhlHQ2rbGCYgV4yQgzqMUQixQXTju63Qlk5p+aX4VxxBIBLPrzCQ2
 FiACrXOY9AGEFiT+XBf/5oDZPTSGiYKtylv5oVG2hMtR3XKcf+RJGDQIRtOH3ETniVA6HhRcZ
 izD5/l/dibvRbXra1jZhVpTSuDDbey45OssnQw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345560939262973?=
X-GMAIL-MSGID: =?utf-8?q?1596345560939262973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct ap_info_t' with 'struct ap_info'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 8 ++++----
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 9bfef9c9f64b..c9cf61efaf5a 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -223,7 +223,7 @@ static u8 read_ie(unsigned char *bp, u8 max, u8 *body)
 
 
 static
-int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
+int get_ap_information(struct ks_wlan_private *priv, struct ap_info *ap_info,
 		       struct local_ap_t *ap)
 {
 	unsigned char *bp;
@@ -771,10 +771,10 @@ static
 void hostif_scan_indication(struct ks_wlan_private *priv)
 {
 	int i;
-	struct ap_info_t *ap_info;
+	struct ap_info *ap_info;
 
 	netdev_dbg(priv->net_dev, "scan_ind_count = %d\n", priv->scan_ind_count);
-	ap_info = (struct ap_info_t *)(priv->rxp);
+	ap_info = (struct ap_info *)(priv->rxp);
 
 	if (priv->scan_ind_count) {
 		/* bssid check */
@@ -794,7 +794,7 @@ void hostif_scan_indication(struct ks_wlan_private *priv)
 	if (priv->scan_ind_count < LOCAL_APLIST_MAX + 1) {
 		netdev_dbg(priv->net_dev, " scan_ind_count=%d :: aplist.size=%d\n",
 			priv->scan_ind_count, priv->aplist.size);
-		get_ap_information(priv, (struct ap_info_t *)(priv->rxp),
+		get_ap_information(priv, (struct ap_info *)(priv->rxp),
 				   &(priv->aplist.ap[priv->scan_ind_count - 1]));
 		priv->aplist.size = priv->scan_ind_count;
 	} else {
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index e68bf18e6a82..fbc8e58eb544 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -276,7 +276,7 @@ struct rate_set16 {
 	u8 rate_pad;
 } __packed;
 
-struct ap_info_t {
+struct ap_info {
 	u8 bssid[6];	/* +00 */
 	u8 rssi;	/* +06 */
 	u8 sq;	/* +07 */
-- 
2.16.3
