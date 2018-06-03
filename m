Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeFCMFC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:05:02 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46503 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeFCME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:04:58 -0400
X-Google-Smtp-Source: ADUXVKJIvyEasIkGlLSiWOv9m1ZZTjUyeza4SFSpwSnoMSoP/2reIvOVpT2GuQtI1AeIyVf9AoSpzg==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org, colin.king@canonical.com,
        pombredanne@nexb.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v5 3/8] staging: rtl8192e: Remove unnecessary return statements - Coding style
Date: Sun,  3 Jun 2018 13:04:08 +0100
Message-Id: <20180603120413.13042-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180603120413.13042-1-johnfwhitmore@gmail.com>
References: <20180603120413.13042-1-johnfwhitmore@gmail.com>
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
