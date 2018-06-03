Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeFCMFS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:05:18 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36471 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeFCMFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:05:15 -0400
X-Google-Smtp-Source: ADUXVKJqi9qR098VZW5NB8hxjLu/ECTrgUu4NRNt+Rnvb4Aw4HAgd+5A71ZiTo6Vli66q5OHA/Jwgw==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org, colin.king@canonical.com,
        pombredanne@nexb.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v5 8/8] staging: rtl8192e: remove unnecessary parentheses - Coding Style
Date: Sun,  3 Jun 2018 13:04:13 +0100
Message-Id: <20180603120413.13042-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180603120413.13042-1-johnfwhitmore@gmail.com>
References: <20180603120413.13042-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 9cca4a8f1cf5..fad740309558 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -529,7 +529,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE = (PHT_CAPABILITY_ELE)&(posHTCap[4]);
+		pCapELE = (PHT_CAPABILITY_ELE)&posHTCap[4];
 	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)posHTCap;
 	}
@@ -1072,10 +1072,10 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 
 	// Initialize all of the parameters related to 11n
-	memset((void *)(&(pHTInfo->SelfHTCap)), 0, sizeof(pHTInfo->SelfHTCap));
-	memset((void *)(&(pHTInfo->SelfHTInfo)), 0, sizeof(pHTInfo->SelfHTInfo));
-	memset((void *)(&(pHTInfo->PeerHTCapBuf)), 0, sizeof(pHTInfo->PeerHTCapBuf));
-	memset((void *)(&(pHTInfo->PeerHTInfoBuf)), 0, sizeof(pHTInfo->PeerHTInfoBuf));
+	memset((void *)(&pHTInfo->SelfHTCap), 0, sizeof(pHTInfo->SelfHTCap));
+	memset((void *)(&pHTInfo->SelfHTInfo), 0, sizeof(pHTInfo->SelfHTInfo));
+	memset((void *)(&pHTInfo->PeerHTCapBuf), 0, sizeof(pHTInfo->PeerHTCapBuf));
+	memset((void *)(&pHTInfo->PeerHTInfoBuf), 0, sizeof(pHTInfo->PeerHTInfoBuf));
 
 	pHTInfo->bSwBwInProgress = false;
 	pHTInfo->ChnlOp = CHNLOP_NONE;
@@ -1091,7 +1091,7 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 
 	//MCS rate initialized here
 	{
-		u8 *RegHTSuppRateSets = &(ieee->RegHTSuppRateSet[0]);
+		u8 *RegHTSuppRateSets = &ieee->RegHTSuppRateSet[0];
 
 		RegHTSuppRateSets[0] = 0xFF;	//support MCS 0~7
 		RegHTSuppRateSets[1] = 0xFF;	//support MCS 8~15
-- 
2.17.0
