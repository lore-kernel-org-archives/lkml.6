Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48s5lrx7MxtCrYV8SVNAmF/LXmj2ZD1nfe2ndAejmytUDI1JPmkg+GWxpvzrKT48vvvh1ol
ARC-Seal: i=1; a=rsa-sha256; t=1522476617; cv=none;
        d=google.com; s=arc-20160816;
        b=xSb6ygLgohWezBjc4PqBg208XT8f4vIJNutUR/yg1GpFiZ1JO3GttyeUOZRNma+OHn
         4kBm3jDdS5i+P7SbcZtSxUIj8Fowcl8ui6JNNLVhtvh7KX35nixy6d+3LiQLa3T/Tehb
         L1bUdSA2FHpmAdO6KLXj+riWZK7Vx9T3uPJCsEd6xIumJpQMTw9NgL5NnPuk4gZjzbNT
         D6sggQdj9LW44LGWZ8IUaoFIkr9TGA3uXSvGsc2yoJJrs0b69N0Z87ur5N+XhOmH0js3
         V6zvvjTjztUiJ8eSEWXlgvbkTPFvN711jPzN61MiVP/kDX0oNBQV1MM9DC7ZLny1WQM0
         6F0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=toDBUverASQL5BHx/OAF2vE5YTyBVy2tp5GkFvaio7w=;
        b=aJHQSfu6lU1ypy7ShAi1EuR0M9UPuc0n4AZ3WhZhQRSJYnrnfFWykpn8qiFEGgKK74
         XADBi/BGjwtFgynuu4qKWVjAeXD5x7uw1Vjq3WL/6Qe9kgmxwMlugX0jdoaiGWd9zG9F
         kGm3JU664+avhFSjcmaWSBXtwqhm5Jf2IIPCBNzehmogTXCb5xFcEYgBm/vTJ3NUxFVS
         ovUPLlts622W6tI3FRYktHL1TT71Sd9CyB2T8GLnbW7PPYnOXnkN31YOi6oLzRA8DwlH
         MBHuiKOU7XWnaFj6MxFfsrlvL2LRCu8cSVqV/9xAZkYrEFiJzA37mzKFAXpK8Ej4j2WG
         5x5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 61/75] staging: ks7010: Remove trailing _t from 'struct wpa_key_t'.
Date: Fri, 30 Mar 2018 23:08:41 -0700
Message-Id: <20180331060855.9452-61-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:J7iXbcxTj31625pGQ9Ec2Rrhql2jRQTIiu3eG2nEEh1hfn6hpzw
 TW9iiLeeQESf/MMEJhEHGQYAw2kwoafMT9mAZ8e7nk87B7tt8ZrxROEN+iRvs2ZYrA/gjUk
 dFGRyED2Djj1nh8IolCO/qmY8wH/KxpDIHXTKVbv8V72yyZmga+6oQfeBOKhWYcViJ+vpVn
 6s3zZQCCHULFBfFK3TY6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IC+zq01DHxI=:C2q+SosXfL5b3wCZzrrpwF
 MtnJ+5UKLjMMQmjCO4rFMvakaBx1G5KdqZI4Nj4NdO5YjyFovvB04nkKAYnFV7YZefsXbDdo7
 OCO1/d2ITnzWke2V3txStiGnQQpbwRfsGwUpt6rYgi/BHhmf52NcyGoLFEqw93ygqZ9WwI/b/
 LLJK5L1VtK9LLtQ7J03xEx/wYmsi39nQ+Hju6+92f5hBp/flQYCr4OSRikJ94yhi0hFu5t8gI
 9yZmM1hzzxBevDoxdDVAj5gTr+7AEOyXis6i6+1Vd0SzTKBIKNIUeQZp4yc3wqkTV50oAyJoD
 TA9KXAbKqvIhk3Uc5LZH2+D1WPpsM5SXm/VLWBA+IBccjeSgidu6vnVK/PhvgJ6xyUHiuRUYc
 4pcwcIWMx6jrAWrTiVKF8o1QnYHnV15OAQiFbw20012j01CC/QvuDBGTPs5WsDQ7SWm3JVc0v
 KFBxb92+3JWcnMnBkBu7+VoDajBhx3S3j9rWSm7vsJB0J6VvGRCW56tkK15vMufQbcHUs3VlO
 ze3QV992C4cdlbpMvfc+to58kUas8xDjSqcqgQesnpprZ8PHD9foK6see8/Kj/6QP+YEK91aT
 zrh5M9x0WOasOFixOC+ED3U8M0sw966ArSxCww2PbByWRFEf495FSTMioUgGQ5LauQ4Te91uj
 IaOfm6Z8XmZB01sFfBBbwCTRPyt+CFkA9SCRqJtbnEH26+PRfPfW3VmCCn5HxYyz13G4socEM
 NN1RRpld3/9rd0BktsoW9vG87y0K+J4URHbb2g==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432441528290108?=
X-GMAIL-MSGID: =?utf-8?q?1596432441528290108?=
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
