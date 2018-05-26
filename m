Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031437AbeEZIMJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 04:12:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40520 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031469AbeEZILf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 04:11:35 -0400
X-Google-Smtp-Source: AB8JxZqRUYKMj2jK5S7c/n0PWbmhfG4W/fLPY/LxvITR0vlWDTvqVHK0Icxbi1ytPNq1AoAu6MuF0Q==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: colin.king@canonical.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v4 5/5] staging: rtl8192e: Remove unrequired blank lines - Coding Style
Date: Sat, 26 May 2018 09:10:19 +0100
Message-Id: <20180526081019.4738-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180526081019.4738-1-johnfwhitmore@gmail.com>
References: <20180526081019.4738-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed these in the last pass. Coding style does not require blank line after
opening brace of a function.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 8021b96771dc..87d0e46b7bf5 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -146,7 +146,6 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->MCS[0],\
 				pCapELE->MCS[1], pCapELE->MCS[2], pCapELE->MCS[3], pCapELE->MCS[4]);
 	return;
-
 }
 
 /********************************************************************************************************************
@@ -159,7 +158,6 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
  * *****************************************************************************************************************/
 void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 {
-
 	static u8	EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
 	PHT_INFORMATION_ELE		pHTInfoEle;
 
@@ -260,7 +258,6 @@ static bool IsHTHalfNmodeSGI(struct ieee80211_device *ieee, bool is40MHz)
 
 u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee,	u8	nMcsRate)
 {
-
 	u8	is40MHz;
 	u8	isShortGI;
 
@@ -613,7 +610,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//Print each field in detail. Driver should not print out this message by default
 //	HTDebugHTCapability(posHTCap, (u8*)"HTConstructCapability()");
 	return;
-
 }
 
 /********************************************************************************************************************
@@ -1117,7 +1113,6 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 ********************************************************************************************************************/
 void HTInitializeBssDesc(PBSS_HT pBssHT)
 {
-
 	pBssHT->bdSupportHT = false;
 	memset(pBssHT->bdHTCapBuf, 0, sizeof(pBssHT->bdHTCapBuf));
 	pBssHT->bdHTCapLen = 0;
-- 
2.16.3
