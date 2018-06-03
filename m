Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeFCMFE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:05:04 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46505 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeFCMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:05:02 -0400
X-Google-Smtp-Source: ADUXVKK+lvdhNVmeEpFucn1Q/P2ypHPIDYZGup2JBlu2RQzHaFCN9FNfZHG9T5Wf592ztTdyYKwgMQ==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org, colin.king@canonical.com,
        pombredanne@nexb.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v5 4/8] staging: rtl8192e: Correct alignment of if statements - Coding Style
Date: Sun,  3 Jun 2018 13:04:09 +0100
Message-Id: <20180603120413.13042-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180603120413.13042-1-johnfwhitmore@gmail.com>
References: <20180603120413.13042-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function HTIOTPeerDetermine used incorrect indentation in if statements.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 65b2cd692ec8..10d9c58680a2 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -362,16 +362,16 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 	else if (net->broadcom_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
 	else if ((memcmp(net->bssid, UNKNOWN_BORADCOM, 3) == 0) ||
-			(memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
-			(memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0) ||
-			(memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3) == 0))
+		 (memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
+		 (memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0) ||
+		 (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3) == 0))
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
 	else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
-			(memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
-			(memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
-			(memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
-			(memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
-			 net->ralink_cap_exist)
+		 (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
+		 (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
+		 (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
+		 (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
+		 net->ralink_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_RALINK;
 	else if (net->atheros_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_ATHEROS;
-- 
2.17.0
