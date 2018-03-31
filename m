Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48062lnbE+mgW9aE+ZlVPa/NQ+9JdjZWOD91CGMjOppxolm46UJRhurs69PGglL4Ulon7P5
ARC-Seal: i=1; a=rsa-sha256; t=1522476620; cv=none;
        d=google.com; s=arc-20160816;
        b=O+zkLpsPb1zlU72WghH6EsE6/SH9u5UFANgxAfYqMoKVg4zKTtmriYAgCp9OxqtXyG
         QHIlb5oRXA6n9FXC5EWAj0kLdDB+pwkSeCl3cn/cpu3aTY3GCFspyc7AAwx4WAdUajKC
         1V7GoCjyF++j41QOEWMCCryV/9ANw7dsCEe/zK567XzAlLfNe5GUxPCa3J1MClBO1Q9S
         2CA3wDucva0U8X4AUAjMDFWg4cXBuUSCSSnBme/xb5Rcm69sB5JuowEL+84DqiNld3WA
         IBvBQ8+rUFbAriWb7Xuxic+V3zEfMIH/44CjVGid4RmsvlZN2ruWZE0Yd2Owj0h8Bjah
         +bhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=4P9FOUBbQ0DMspAF3B1rv2MRaLUfp7v4QUvGJqIGP6w=;
        b=qlWbGgAux+u3u+F4O0//2Sa6qD/0WKken+FW1DZpA/9oQCnFtFAEWKevx+6qohWymi
         OObzPUKTOrUFjIKAH0WotCzOcHeRX2MJyFLzIUpP4ql/lEEaeE667rwtHUgPvGFi1DY+
         teUImzbk6w07LtSLWW1Cif6F9JEdHY2Eqkw7Zzyfzpm1qnnNe9VTGxjFSahcjgf4kvp3
         2Gu4GOR2IF6Tf9yd30ZcRBhv5kddT/7UdnRa7s+nVgcDCC3sOeAbFlyZKlNHONV92BBA
         fWpHFZr5ugFAF50ACTjjPqEl0WR85LzAC0FFOsHcALujzVm/OWX+K3fOCL1CSSnDlCi5
         OuhQ==
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
Subject: [PATCH v2 65/75] staging: ks7010: Remove trailing _t from 'struct pmk_t'.
Date: Fri, 30 Mar 2018 23:08:45 -0700
Message-Id: <20180331060855.9452-65-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:RKf9VqOlGMbmn+QQIF4OKZuWGoxvGN9YWG4bgsEm6m5Xe3XLAIO
 38y8rQk2+gUJsiMflN174H7Fa11iGkJOzukM8Mfu2xKRQZKLJAbP2HdOFGurIQIFTwNv/54
 O0yFGn/AYrtJLKuIEFoncu3PvDsuW2Yc53p33UKjHBSKQrcMVSswSZBNuVQuUbX0Rd6xSNe
 2laV0BvGzVmTILLX8cGWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hhZiNJRAqQs=:6XBC0jhjh/QRDE9+d1XFsV
 drSCgEjDSCq9N256f3KiRO+9tAusc9/X8Vc1GfMSU9JVkWRGGkLtRp+apgJt8HglaVj38rW4I
 zWGL0U8/XR5k6xsKH65f0rG925adQ1Zf7ps8stdEINN8UgAHZTwKJCp557EJgCBRJRHFU9TPg
 ohifvLEQfoXIo68Lw8PCCO6ue/VRTY1AfWC0s178BcXGGUTw6mCX1YfRoyf/cf6g+zUrEaAQK
 kWviZ2VWPO9UjkqSzkEPgqBgXV17LJclyl69fMrWdU61ikF0mJxEvrV+Ijk6i6Q55FlJZlyE1
 FW1sOWoeeocKFo0amvIwQltvcvjcxNtA8ijIpYXYI7wdmc/Tj9V113x1fmu1sfUS7IYLeTy6U
 2EC/CyYR/sw0N5d64gzd5PT1r1GV+ESJA43+uetHloxYinFJ/wYrxAGyCVXPuriCiqqorHJKf
 eNARP6k76yVr6g+p+Np8EPcS+BYIGIOvBxTnmHNqsURtJ+llQ/xN7iHWHqGohm2bl89/ldri1
 l/Md5uaR31U5pfkMcaQXUEIblUUmr5UpGc1lboCnvojxUmUcGSWkJV8LguuEQ1qAFVN9b4Txg
 jnAoxmzu9xJRhtiM0npND4zBsPgPf1+5uHzGV8u8iH9e5hMiVWNu2bR290306yYvTMz2UYtNz
 dQBaCuaS7xQ5cX4SpU7PUEPFXJr2OvfPRAoMeOq+KAh1qkJFc8Iar88TnI8kfr0pVjTEdmRAQ
 fmmCtFS2lE1BZcqturC8UNeEErO6wLWcUxkTUg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432445133492703?=
X-GMAIL-MSGID: =?utf-8?q?1596432445133492703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct pmk_t' with 'struct pmk'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c   | 2 +-
 drivers/staging/ks7010/ks_wlan.h     | 2 +-
 drivers/staging/ks7010/ks_wlan_net.c | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index fbe18ddf3ea0..f87e707e8bd3 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -2130,7 +2130,7 @@ void hostif_sme_set_pmksa(struct ks_wlan_private *priv)
 			u8 pmkid[IW_PMKID_LEN];
 		} __packed list[PMK_LIST_MAX];
 	} __packed pmkcache;
-	struct pmk_t *pmk;
+	struct pmk *pmk;
 	int i;
 
 	i = 0;
diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 69eac00e75b1..20b584524a77 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -383,7 +383,7 @@ struct wpa_status {
 struct pmk_list {
 	u16 size;
 	struct list_head head;
-	struct pmk_t {
+	struct pmk {
 		struct list_head list;
 		u8 bssid[ETH_ALEN];
 		u8 pmkid[IW_PMKID_LEN];
diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 1b8234720d78..72a52c6f9fd2 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1818,7 +1818,7 @@ static int ks_wlan_set_pmksa(struct net_device *dev,
 	struct ks_wlan_private *priv = netdev_priv(dev);
 	struct iw_pmksa *pmksa;
 	int i;
-	struct pmk_t *pmk;
+	struct pmk *pmk;
 	struct list_head *ptr;
 
 	if (priv->sleep_mode == SLP_SLEEP)
@@ -1847,7 +1847,7 @@ static int ks_wlan_set_pmksa(struct net_device *dev,
 		}
 		/* search cache data */
 		list_for_each(ptr, &priv->pmklist.head) {
-			pmk = list_entry(ptr, struct pmk_t, list);
+			pmk = list_entry(ptr, struct pmk, list);
 			if (memcmp(pmksa->bssid.sa_data, pmk->bssid, ETH_ALEN) == 0) {
 				memcpy(pmk->pmkid, pmksa->pmkid, IW_PMKID_LEN);
 				list_move(&pmk->list, &priv->pmklist.head);
@@ -1869,7 +1869,7 @@ static int ks_wlan_set_pmksa(struct net_device *dev,
 			list_add(&pmk->list, &priv->pmklist.head);
 			priv->pmklist.size++;
 		} else {	/* overwrite old cache data */
-			pmk = list_entry(priv->pmklist.head.prev, struct pmk_t,
+			pmk = list_entry(priv->pmklist.head.prev, struct pmk,
 					 list);
 			memcpy(pmk->bssid, pmksa->bssid.sa_data, ETH_ALEN);
 			memcpy(pmk->pmkid, pmksa->pmkid, IW_PMKID_LEN);
@@ -1882,7 +1882,7 @@ static int ks_wlan_set_pmksa(struct net_device *dev,
 		}
 		/* search cache data */
 		list_for_each(ptr, &priv->pmklist.head) {
-			pmk = list_entry(ptr, struct pmk_t, list);
+			pmk = list_entry(ptr, struct pmk, list);
 			if (memcmp(pmksa->bssid.sa_data, pmk->bssid, ETH_ALEN) == 0) {
 				eth_zero_addr(pmk->bssid);
 				memset(pmk->pmkid, 0, IW_PMKID_LEN);
-- 
2.16.3
