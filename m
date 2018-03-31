Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4/sppjzYrXubqDucpiMYwePVdJX+c+msCMxZoOcPKoYHSYryTYSdzxrgMM/8WWb9jAPXcWy
ARC-Seal: i=1; a=rsa-sha256; t=1522476585; cv=none;
        d=google.com; s=arc-20160816;
        b=FR49X2fKVxcnC3T0vPCgiDvOTu+Mvm9ACOi2Wi3fw1iUPlNH2A9qNM+wSIg5fvjNgM
         cyMCnn/SEHBNUKj4a2/zjycbSa96q8eJjsMa0VszRI978+4Mih+eN2zVksKvELm5KVn8
         Xhuylnb//g0/QmeqabrlljBxoY62wiz93e33YnV5dFW5aVjGqUirDWBuqBCyazGm/bxx
         A+1q1QbQ+ndYcWBmLpOg50bqPmpZ3XtCC5iQ4hpoQv+rqf2ylzb8b3hwnUtk/wqD7AW9
         pdueI6DUGFskwLcEOjCCW8UicOOavVgKprBNLWUdXg/9YAPpcty0BLz4t7Hd2n+2h+gD
         X+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=5Jc6WmFSfSP1mFSBsB0l9uOADVyaYwFOY8Yb/OJgIz0=;
        b=inT39SyD7HC/DEOyq5zyajqsCmT+WeSPRhDHlpqNjn0Hj4DfL44qI5WLuYq5wzDYrm
         afstUfDJr6LiF1EdM9HtSqfksPewfGku2lzgY5+NVPaUFWIw//yq8aPP7qGQezp+KgVd
         JcnHq+u6P8DtV0y0UZ+Zaq4jjdCDeVgGp09XsEpmfALsi2t5BPM5KeHzZ+99LFYfFNSq
         vrvVOAviMaxxMSijKVBOniej6SAWEJnwd/qVl5EKariUJGohMmSzJHUBYVsWl/2M/OfE
         lsqqD6zE8WfzTkr35La/V9PVJp6Sq3TBUTR03hltWsLbYXFrPhfLSbVzUxXHCgL3dp9r
         VEEA==
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
Subject: [PATCH v2 26/75] staging: ks7010: Remove trailing _t from 'struct ap_info_t'.
Date: Fri, 30 Mar 2018 23:08:06 -0700
Message-Id: <20180331060855.9452-26-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:JbAbp76pS/qlDFmIlEh9gNFcuUHtn4gZdTT3rGR/5Q2k79wgsNk
 lUU8xYM3R3wWd7unxegACqc1QOcn7g+0f0DhiAbOJh13NBDOCNY1j17J+bANc5+9W787yQj
 dkpGHBzLmPX9qzaPzQwurPvupolJ+TfpMOAgqXjN0IPKb65pHxyG+KEQ5+eK8LKx/ID5gfX
 M+aXiamUYwQU+E086Ni5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IbDYNP3eblA=:59HNUwHkL6Y4gx3+beP24Z
 n3RSlWPddkpuQawOawgbMp5xUloKu5c+bGUyyZsa6dNTTnjezajTqP9Lq930+gFMsJ1K6H/+E
 BpX7TBGt4r8CykqGZ0E1y/3KNQeYxEgzbHoFgxPcY6bVvMTQ/wqgL9yWBKck92mqJrkT4s/O4
 EahSfZGbcxiZ3qYK0h+axTq1YwdZ5AWYtXgDivVqI8n7SXiJjz1cwFlSnsDhMQUUeAujvXgtu
 djBG7o77QsktHMQIH/TZfqw1YwjRSPD2CXcC4T8O+N9MRdniEW6OwLrCEs308xZLPjJLKDPUk
 YAeTJonU5JzVXp55DNfw6J8N7vg8Qj4JFYZJvAOXkwHHT73/gghXrERzNKz2Rks0m4eQaD9PA
 R4SMtpd1lCySv+pKEWJ+vjt95m/BNOBJQsjCOEn6aXVqKA05VA+gB5s4OqvdHZjHzAb+IizP5
 1OJyKG7sOdpuDnrCE1oNoAf99Q5he8ZE9GTukvNoxHfkpRigl0olhQ2YTcS46ix+02h0vmXLM
 xLJCi9CD28PDFEmGamrOK7bBWjXJnBon6DG7sbZ8fJ4nfVZCSZfYthNVCK5ZSHT5rRtWXLhWp
 oR7JEbi3SzGh6RO1qvxVXPcqfjqCJpIVso3j/pWuLjeFNdlZZ09U52ZSwI/AojQlAaFE6yZlT
 YS8bsRkLjtDEDhdIWwZEy6w3AW4H7xOTVkzybbNMTdQ9ULMz042xE9Q4f0t2u1IFVBIGA6Ovl
 KOOqNgpRBt/bDkQE9LPFjMC9OjmELvYMtwmNSw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432409061662667?=
X-GMAIL-MSGID: =?utf-8?q?1596432409061662667?=
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
index 87d018f83fa2..d61225958df3 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -243,7 +243,7 @@ struct rate_set16 {
 	u8 rate_pad;
 } __packed;
 
-struct ap_info_t {
+struct ap_info {
 	u8 bssid[6];	/* +00 */
 	u8 rssi;	/* +06 */
 	u8 sq;	/* +07 */
-- 
2.16.3
