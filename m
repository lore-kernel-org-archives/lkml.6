Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQP+pZGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D52560860
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeFFLkm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:40:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56174 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeFFLkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:40:39 -0400
X-Google-Smtp-Source: ADUXVKIiXNv2EgGuPbex3aUII56Sj+HzlN8CIbrYCAqbvSLHqVwOcO+/vCX8LLSRYZhjTJ43yZP7hg==
From: John Whitmore <johnfwhitmore@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, colin.king@canonical.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        devel@driverdev.osuosl.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v6 4/8] staging: rtl8192e: Correct alignment of if statements - Coding Style
Date: Wed,  6 Jun 2018 12:39:59 +0100
Message-Id: <20180606114003.22654-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180606114003.22654-1-johnfwhitmore@gmail.com>
References: <20180606114003.22654-1-johnfwhitmore@gmail.com>
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
