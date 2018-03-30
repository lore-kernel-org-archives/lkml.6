Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx483ciQ5lbRxuCl85vlEwMDRg93IWe7SMzTxWRirtNB/S5CUqp3gq+TOefLCUPDE2evWfVwg
ARC-Seal: i=1; a=rsa-sha256; t=1522393790; cv=none;
        d=google.com; s=arc-20160816;
        b=NNEeenn/XBuptdRl8AjdmnouHNj2+oKm0PP70fHVoygcfpOLK7i4KTkvL5/Y5OZTff
         m1X2c8oJ9VYAf/PhdufmgWnUonB9xpBkPXXEACDeHcUXnMEp1fuq6zbuNhdR36ZemS1V
         dfjCG4UPcUmkK1EfQhTAx4BNFQKBln22X4ENBQ/OvAETxQyxV2mhVidtV/8dpKu0I/HB
         Vrqp1udnJJnxH3PddmlAvczPRjfPUrmUBsfaJ5IR0em7u93o+xHjz+Vo4UCyRPbAA1Xv
         U1teZ7teXJztA2imDDvrNQyLLDE8vosAXfHcanG3IMllob7g0N4uOXM2CPRKFaBv6P+u
         QyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=toDBUverASQL5BHx/OAF2vE5YTyBVy2tp5GkFvaio7w=;
        b=HEfzUQAkHfE9DCtPwGIaJjNslhkr3zaMwhcPjE+1Lrb2cPoj26+hODEaMBwPuMLSlN
         vWWopyQ9oFHd0OZDQbW12ldHRlNmlvXF+aGdqUyaIjiC8uavVPqO+hJri6S4aZcmu248
         hoaCv+GaGB7Yb+MauUtWtWkncnQmMuaPBvP4Jb/8G6X0028hTDtqrJdc76/Q2gNDzNhF
         TAuaFVyWAozYa3+1+QRoBP5CBMdJ70w1smULnUH9FvCNOZ7EnPTw+FeDQ/X5+f01KAAf
         KQgJsNu/QQdIPzaqb2w2/LezViZSn11VRgMlf6GGN/taql5XXBuswNaGeD6rbI4EI2Ap
         O6Xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 61/76] staging: ks7010: Remove trailing _t from 'struct wpa_key_t'.
Date: Fri, 30 Mar 2018 00:08:24 -0700
Message-Id: <20180330070842.25224-61-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:CNB5ABEKGN7P6m9mPwhItRdLUrK9HT4TQ6vJcHNV757Y+PB6RRx
 HG4wj+Uck+T8XvpHu86iqSJsf0wSWqGCk6cmPnjteRw5vTwsLXazRWNdqyKMQX38Jf1xhEc
 B7D3cDwM9JhA8oOHEkma05D2AlOmsI0rxYxPAwx6XNByWT0OUERczvlJdGBrwE71fhio7E5
 el6OusbYcW4JYc5YuL2SQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i1x1Ig2+GJo=:wtSsOpZMWCW+ZZHr5KJhyr
 8eypTItdaAwPwfL+auoFawwAbIK08I6HToe5SD8JHp+SfhCCH3ixZhQimM7+8ktmxZAW+SCB4
 Pcagc3mK9OcdS6fx9fWC9KQbwqTLFe88PZA0Lw5IzYYdCeU3CESf6U7c8sDwJB1sTeV1lspqM
 6XkuQmS8GzqeZs6zw2M9WaiqiHxqKmprrA9nbE+vO+Ff033QVZWKNoUgrfo54lmeRL8lV4B6m
 1H+1tlt5vHJ93/5YnkEpUfB5vAJBBhLz0d+CLBGqBA9BeEO5sX6V8gfpckRI7MSoqKv1tpA3V
 AkWU3DYwPf/BLi0zlWWPrJnOHg+5xp1jMuq6eXCs8kQ4CxLXPKC2PMqPyu/9+TtNLjBfC8cNm
 V84kdulQ8FsIQ/JkUvcENOZQImvVlwe01CRu/9vUeX05eAlcwFXwObDIpPICjRpwmOPYqUGts
 +u5gElsVe97FhARKfE/E8zewSOtb3r0ZId/Yuq9RUqfa/ysC8gilNDVCQzdNPVRA1TxRlUtjn
 IA7USYiQkwonzsKMDgh6YxM1h+PZAM9F/jqmEYsREcBsFDTMSkc3bkZkSiP8VnvoFPjJNra5J
 eM+B9Ljjg3ose6/6vdVvI52nP/EkPKGP0lZA2WvnjQP41FcfEnDBX5Ed5p44wStNmFgKeoBB2
 Q5PrBeHflk+yPYSgG/0+lfuWxp0JBy5dnmvx39Ccz6VLwYYffseVMma2vm2/HyXOPt815HeAG
 5H5s932D3Vb9t9U40fvYl4yKGjCphxO5nqcF8A==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345591342548909?=
X-GMAIL-MSGID: =?utf-8?q?1596345591342548909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct wpa_key_t' with 'struct wpa_key'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c   | 2 +-
 drivers/staging/ks7010/ks_wlan.h     | 4 ++--
 drivers/staging/ks7010/ks_wlan_net.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 0e6f9e954a36..d8b40fd83b6b 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -318,7 +318,7 @@ int hostif_data_indication_wpa(struct ks_wlan_private *priv,
 	struct michael_mic_t michael_mic;
 	union iwreq_data wrqu;
 	unsigned int key_index = auth_type - 1;
-	struct wpa_key_t *key = &priv->wpa.key[key_index];
+	struct wpa_key *key = &priv->wpa.key[key_index];
 
 	eth_hdr = (struct ether_hdr *)(priv->rxp);
 	eth_proto = ntohs(eth_hdr->h_proto);
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index ece9950ba893..2458dbba66a0 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -339,7 +339,7 @@ enum {
 
 #define MIC_KEY_SIZE 8
 
-struct wpa_key_t {
+struct wpa_key {
 	u32 ext_flags;	/* IW_ENCODE_EXT_xxx */
 	u8 tx_seq[IW_ENCODE_SEQ_MAX_SIZE];	/* LSB first */
 	u8 rx_seq[IW_ENCODE_SEQ_MAX_SIZE];	/* LSB first */
@@ -373,7 +373,7 @@ struct wpa_status_t {
 	int key_mgmt_suite;	/* authentication key management suite */
 	int auth_alg;
 	int txkey;
-	struct wpa_key_t key[WPA_KEY_INDEX_MAX];
+	struct wpa_key key[WPA_KEY_INDEX_MAX];
 	struct scan_ext scan_ext;
 	struct mic_failure_t mic_failure;
 };
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index a4f10bec865f..1b8234720d78 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1706,7 +1706,7 @@ static int ks_wlan_set_encode_ext(struct net_device *dev,
 	struct iw_encode_ext *enc;
 	int index = dwrq->flags & IW_ENCODE_INDEX;
 	unsigned int commit = 0;
-	struct wpa_key_t *key;
+	struct wpa_key *key;
 
 	enc = (struct iw_encode_ext *)extra;
 	if (!enc)
-- 
2.16.3
