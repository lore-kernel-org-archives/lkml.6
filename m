Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+cyyUQAeKoTCyIaWakPJYvtYBpEEsviANBRiXW+L0Gm82e2FTcSINsfWfleR0dJpuhvis4
ARC-Seal: i=1; a=rsa-sha256; t=1522476611; cv=none;
        d=google.com; s=arc-20160816;
        b=HF4gamvBp9Rd7eMY8MGh4YjchGk/xQRQZykkphUPieOpXzOiTeYWpq/+HyyAzd63zZ
         KQt+Sq9NQ6KahHDguE1E8olBJcPo5/NkjXrmu2FNTk4C4DxnxRezHUsXKJrGXOtAj3gQ
         N56tQ+sFwfvAg2u6pbzOJw3ktQYpD207jYkA3Q0EkiqkULruABxZInN7llv+EnU1iw0Y
         knkEBH/pzx5UiAsWzECvGpZvwW03jyNyyq7jNeC2kFWLDZrNKXpKtSsvlIlFscjf4SOT
         dgy0kh/xvGW6pIpgzc1h3SiOgfAhVbOGIVDwtDJi5Rii7mR6tUheZVmG/tGJhoeHlmvW
         op5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=UwIcQzipFgg3TvM13kG8ZVSzH7AfUF3iLyyQIB1/Imo=;
        b=0mUloD91BS30QniWfFykGiN4Et9Dpqbvj0jL16QpGeCG6MKiBm01fcdtLjMzZNQX+n
         lr46aW3UJV2j5UgRkZ9WnhYRbqfiTnQGLDsHtrSd7WQEYb1AQggCy1Q2K8JMjUEkq9dv
         UCPPgHm5pgP7v+nqpuA/zDotRXu2RKMtMg6QQ7iHfuZ9M6EpQJ1SOPu56Fg6Yi8I2d3e
         rtVv6YWKLbsuzSxa6WMLIX0eo3k+0IHtQSOlkSS9l98Gy+vXHq0nmJTxjPmShDPpyh/5
         akvNS3hr5w5YFD3bXpeQRW4Q3pzxBOsfRVHr/OMA9EyR6bbrfKdj/LLrlUJd45coKENE
         Jbrg==
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
Subject: [PATCH v2 54/75] staging: ks7010: Remove trailing _t from 'struct local_ap_t'.
Date: Fri, 30 Mar 2018 23:08:34 -0700
Message-Id: <20180331060855.9452-54-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:AOLZypu1EQ5sCaYMbiry6lqXveH1UPsjpObtKtkv068NDGUVsHJ
 8Mw9oSTgtFh2cxYeWxSGfeZeg4zTTtSQyAAZ6Xbp4sgAlQhkUiEqEhWPWKRKd+PzfPfuHK8
 CfCWUQmrNXQwUm9iN3gjmUtaOpiT2lz8NWFz1NEZy5QSmiPLWk2ilkLYqwXGXz12bZ5flJE
 VgSZva5SfX3wmbAqQH4Fg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SqU0GYLj6hw=:FXB8uQBLktooL/fnlveSbF
 76sQ2Slse4PLvmmB6oOjA8wgt3TZjI1iNYcGUM18OBzI0Uzq5p9LWw+Ib2V9DYcPuuVOELC0L
 pSCk7D/qDP3IIUWfH2/A9DxD/uMpIqKwyPqfgJRyYYzZP3OZwHSbauBFI5Myop1VHXardxz/+
 8NBRwJccH9IVGH6ZVfjf44pIE5Q/sxqaDvYMgr9yY6LW8S++yVsjtjZ9AaKzaCuC2gPb2Elgv
 SzxngLpXZYriuTlFh2aQMVdwZPFwEBi45IdShm3pZtvyC0Ddp3SyVja8qBXf1XshGhuYRv655
 afDbGb7ZPHkRMtsYuNWhKulzHrKm6fXQCCGwEJtCbq7HijurCC4kkiV6plh9i3EMsMeFR/Z50
 bMlP0jZI7o7b1ZfiENuD28akGk9vtpS6VcPXJPXmrzsjX/TjQB/Tb0WqE6N51+DqMPzYY/1/3
 iqJUFtEXrYTwiijVOei2JwNGwQlHCaSBLVlmMx/JtaIdFkuBeXOqtveOdYMt8WYyOTE+37uT2
 vbRs0h24sonvIKIQAq/hq+ZGbAR7UCvpMwI6Ug/HSvDKJ3+E3HSZyUQUHsr8AAMSCtqRK0qPp
 sBOFoeO7Pnf9JTq0Sz+ckFdChoIGGo0zpZnJlVv9X3HD8gDyEIniaFQ21fbg5KLdQZbZRYuKC
 dvnmUSBWuEfPWH6rvWYZ/TFFSBilLtBY+8wlSeXpyofdsi/oXqd8FeYt7BQ5Qpdu+vPQmDjNa
 Vw7WZhfh6JVELGqhvxx27fseSMXWmTp2CCWsKg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432434638075435?=
X-GMAIL-MSGID: =?utf-8?q?1596432434638075435?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct local_ap_t' with 'struct local_ap'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c   | 10 +++++-----
 drivers/staging/ks7010/ks_wlan.h     |  6 +++---
 drivers/staging/ks7010/ks_wlan_net.c |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 2f732d8bcc4f..0e6f9e954a36 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -109,14 +109,14 @@ int ks_wlan_do_power_save(struct ks_wlan_private *priv)
 static
 int get_current_ap(struct ks_wlan_private *priv, struct link_ap_info *ap_info)
 {
-	struct local_ap_t *ap;
+	struct local_ap *ap;
 	union iwreq_data wrqu;
 	struct net_device *netdev = priv->net_dev;
 
 	ap = &priv->current_ap;
 
 	if (is_disconnect_status(priv->connect_status)) {
-		memset(ap, 0, sizeof(struct local_ap_t));
+		memset(ap, 0, sizeof(struct local_ap));
 		return -EPERM;
 	}
 
@@ -224,12 +224,12 @@ static u8 read_ie(unsigned char *bp, u8 max, u8 *body)
 
 static
 int get_ap_information(struct ks_wlan_private *priv, struct ap_info *ap_info,
-		       struct local_ap_t *ap)
+		       struct local_ap *ap)
 {
 	unsigned char *bp;
 	int bsize, offset;
 
-	memset(ap, 0, sizeof(struct local_ap_t));
+	memset(ap, 0, sizeof(struct local_ap));
 
 	/* bssid */
 	memcpy(ap->bssid, ap_info->bssid, ETH_ALEN);
@@ -2359,7 +2359,7 @@ void hostif_sme_enqueue(struct ks_wlan_private *priv, unsigned short event)
 
 static inline void hostif_aplist_init(struct ks_wlan_private *priv)
 {
-	size_t size = LOCAL_APLIST_MAX * sizeof(struct local_ap_t);
+	size_t size = LOCAL_APLIST_MAX * sizeof(struct local_ap);
 	priv->aplist.size = 0;
 	memset(&priv->aplist.ap[0], 0, size);
 }
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 30d81f9456b7..3104ff92c453 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -218,7 +218,7 @@ struct wps_ie {
 } __packed;
 #endif /* WPS */
 
-struct local_ap_t {
+struct local_ap {
 	u8 bssid[6];
 	u8 rssi;
 	u8 sq;
@@ -246,7 +246,7 @@ struct local_ap_t {
 #define LOCAL_CURRENT_AP LOCAL_APLIST_MAX
 struct local_aplist_t {
 	int size;
-	struct local_ap_t ap[LOCAL_APLIST_MAX + 1];
+	struct local_ap ap[LOCAL_APLIST_MAX + 1];
 };
 
 struct local_gain_t {
@@ -424,7 +424,7 @@ struct ks_wlan_private {
 	unsigned char eth_addr[ETH_ALEN];
 
 	struct local_aplist_t aplist;
-	struct local_ap_t current_ap;
+	struct local_ap current_ap;
 	struct power_save_status_t psstatus;
 	struct sleep_status_t sleepstatus;
 	struct wpa_status_t wpa;
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 533feef604a9..a4f10bec865f 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1301,7 +1301,7 @@ static int ks_wlan_set_scan(struct net_device *dev,
 static inline char *ks_wlan_translate_scan(struct net_device *dev,
 					   struct iw_request_info *info,
 					   char *current_ev, char *end_buf,
-					   struct local_ap_t *ap)
+					   struct local_ap *ap)
 {
 	/* struct ks_wlan_private *priv = (struct ks_wlan_private *)dev->priv; */
 	struct iw_event iwe;	/* Temporary buffer */
-- 
2.16.3
