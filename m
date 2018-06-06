Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8NCdzLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9518860764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeFFLls (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:41:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54061 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbeFFLki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:40:38 -0400
X-Google-Smtp-Source: ADUXVKIhFdtwLzDmzbS0AMggDxWmlGp028m9eZRjr5KuZzKPIM1bcRIbqOLLvo1gxp9vVE66H/e2pA==
From: John Whitmore <johnfwhitmore@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, colin.king@canonical.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        devel@driverdev.osuosl.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v6 3/8] staging: rtl8192e: Remove unnecessary return statements - Coding style
Date: Wed,  6 Jun 2018 12:39:58 +0100
Message-Id: <20180606114003.22654-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180606114003.22654-1-johnfwhitmore@gmail.com>
References: <20180606114003.22654-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return statments from void functions are not required by the coding standard.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 0db98c77a8e9..65b2cd692ec8 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -145,7 +145,6 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMPDU Density = %d\n", pCapELE->MPDUDensity);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->MCS[0],\
 				pCapELE->MCS[1], pCapELE->MCS[2], pCapELE->MCS[3], pCapELE->MCS[4]);
-	return;
 }
 
 /********************************************************************************************************************
@@ -207,7 +206,6 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tBasic MCS Rate Set = [%x][%x][%x][%x][%x]\n", pHTInfoEle->BasicMSC[0],\
 				pHTInfoEle->BasicMSC[1], pHTInfoEle->BasicMSC[2], pHTInfoEle->BasicMSC[3], pHTInfoEle->BasicMSC[4]);
-	return;
 }
 
 /*
@@ -611,7 +609,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 	//Print each field in detail. Driver should not print out this message by default
 //	HTDebugHTCapability(posHTCap, (u8*)"HTConstructCapability()");
-	return;
 }
 
 /********************************************************************************************************************
@@ -661,7 +658,6 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	}
 	//IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, posHTInfo, *len - 2);
 	//HTDebugHTInfo(posHTInfo, "HTConstructInforElement");
-	return;
 }
 
 /*
-- 
2.17.0
