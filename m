Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+HylqSfepg7G0aaHfwsCM68/S9XXet1xBLUQ+eE8QUgifBFmtPVs26jS6nA3oUSB113xE3
ARC-Seal: i=1; a=rsa-sha256; t=1522393794; cv=none;
        d=google.com; s=arc-20160816;
        b=c0GqmbW6YlNOKtzDS0k0SJj7GLXREx+2XiJ4Vbz4ha01IqwVuK01J9sK38dZTnSIoo
         N9XhWM1OAl0VfI2piEW9VjP9fqbvLf0qKVxLpvoNN1t2jesqgwlKLr0gt63vPjPTaUx1
         4pQxTK1SqT30FKSEmHAZJfDYPg3R6I9mV4D8jCmuYOuBiKPlpDvEkPxaSAAhAoYttmWv
         XQXkHNfo0noDUOZ7kA2PTgzBzhjT/ShRYhfF+WEwOm7Wi7R7jEYFhVa4K7pwQ4hfkYUZ
         l4gzGtoZ5rxpv+vPHJVJlfGcx/gRUYqowz8LOzuUp7rgUa1BF/3tYdVLTdNrN4v6rffb
         1fCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=4P9FOUBbQ0DMspAF3B1rv2MRaLUfp7v4QUvGJqIGP6w=;
        b=asyAqpfJEZVwdlAxoAGsJtCGgg+InNPUCk/CaYfLRK+Uk6qsXcUgylOM/LLL8qsrpE
         kQZ26mJDWhOLGgOLfBRqakaSwu1ODhv6i1KAWZKlrUMN/ZVDJsXVIAqFsSffSt9sEc1i
         oSrBQprxAuITXI4fk0GI0WNTR+eiU0/o9PKeV9UL8lQ1jOqp7zdu/ZCxWirjud3zkYge
         CE2mHLTsVHB/fT1b/wvjBvgC3YMG0RCjRLCf3OVh3Mve7C0yolghWdemJiKdhfWGk+vf
         kYbtpxQCXc2BUfs7oKe77eP8JCCy6ttpwHQoJfsqODkOuSGw6TJPorl4gvhz2Oy84J2g
         JqNg==
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
Subject: [PATCH 65/76] staging: ks7010: Remove trailing _t from 'struct pmk_t'.
Date: Fri, 30 Mar 2018 00:08:28 -0700
Message-Id: <20180330070842.25224-65-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:B2lja5Iu1wMvt0WlMLJjG+p8a4USBlscBe/tQ57erzoLEmC//3n
 R4u/7hy7masc9GaTlHyM7YnzDlbZGpRU+KLeU3SjDSNKhJX2pgpnuWcYIY/bAn+YM7+qpAD
 8NA7DNXgY4CoS310H3X0COvueKJKN8KxO++l1+/IuKZeDJ45kvZYEUTMbNhwTm2DIAF+d/7
 BtoVLmsj1wVZaBSARYAGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k3G+7b8dc0o=:dIWEWDf2sQ1BXhcL+AA8yb
 t5AwU54Ys9spELQCWR+mbWLa4BlWNZgsSJU4D3NbEkMrl7o9sQUjudbZSNPINDXvUUEbUde/R
 5W+fpr2V1rzKKtmZ45ne/Vpeb8VKjy7pR8DqO27YLLFpdJ4gVSwNmVNlrwXtdMVIvvdjVGYVX
 MZ2qwVh5OTlMT6cLPMwY4eetQzUzwDn1m3zsCCvvhWBtbOpNbqH9xzKzaBa3SuY8aPIJt/Pq7
 mOKJMAuLzmkLkxH5dQl2Xg0GyunS7y1MIltMynwNQRyTanXpiUDAvNZXZC9nNWiumU/v4vsEq
 rIkJ5mwAOeqZFm2RZLhaA22BPqpo9t8z5OkxyY6uQiE9augwIvttGbZc3OJhrLIOprmFmrRGg
 cz3s2bkKiu9zH2vwLY8iF3Yq+jrlk7fYZe5hScxZ1ghfeFNaarazaXBwmY/ktN0lFHYxJqp7k
 SGVNveuFwQURtkgM5BE09nrTf1lW8ll+yAHcNr82Pb8pwU3u7ARtXKU84m3q2gt7Su19ZhI4l
 4VEr60eHYHESTlLD8mecONW0MZLGp6HuFlDSFU+yPRXGHBiR5I0w4sPMaHbsWoaRqRu1tI1/q
 4ZgeZuGR1ydHus6tVBOU6SBDtI3I1o1BpydFoNm4jMIGjwTUEl13SzTWC8etu6eqDLh/AyTVb
 p1pI8a6WcBCwat60ilxhHpFscYfDnTlwj0xIyBC2ckVbZaqxXzbnFR/ucWq7tFeN9kBJI3MYP
 2NjEye1TcD7nYvuBwtlI/qbtsY0fgzEbtvPvZg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345595052534853?=
X-GMAIL-MSGID: =?utf-8?q?1596345595052534853?=
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
