Return-Path: <johnfwhitmore@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526313260; cv=none;
        d=google.com; s=arc-20160816;
        b=ZUQ9Q0HNgiD88KBKX7rY7AJ+RGdEarrOOKTR2biiof4PItzzYNWWFRJtMj8NXsvrbv
         8LzijIhQDY2Mh5XRMk7GAQaCKtq4o0fyTYlHAmfQwVSc9Nchn2O3f+HsGJvymiNyjlvT
         FPbb8jwZbmqBy6aAiBt7kAyu71S4r6RQQgiZFx+mARWZIlbZIJTjeJGWZrwRQJPV+uNe
         O47+lA2OXdUdAd5N0S8p7MmBMtZNin0R6+/DVndGt+e6yrJlmR51A/rzhc5A6BM0XUMn
         3ALehc/9sqbYbeS4JXOb1vq0wB51xJ9EgAsXMUD5xmV1apfD0cDUgs5Ev1wjY6jHtnkI
         UcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=gQ0AcRwtMpyzMxJIclVuzeeRvLPL5LSF8t+Vjht0QdQ=;
        b=OrZUfUeB5VctWIS4paTWrD3Ekn8GshwiCj4+chZdqF1KPpKQqvfqoi9F57b59hxgHh
         EqCQF4uZu2/phiW7WQSSsvA5qaFgxnD2cmyigye0IcRP56f6aorycG568s+y5Dq+yBoN
         pAsT1RpQI60up0kTpwMnK8h1/DdoulPuw2fQp0WpK43+E0Z+K0BJ8JEeNo9+OqPXEt1q
         G8xqPj7X5w02i/V7b7uhiLquqjkGxMNHe8n5A8cDH3nkxr6EXNVENTgffbYKjxhzRGhW
         H4Jiz0pOSpfDaiAaEVAmXOdRppqY0nIIeqKDrEGWV2wIet873zt69aVcCHpEDHvtmMc5
         H93g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CRVqR56r;
       spf=pass (google.com: domain of johnfwhitmore@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=johnfwhitmore@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CRVqR56r;
       spf=pass (google.com: domain of johnfwhitmore@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=johnfwhitmore@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZosARayEJEG+eG+DEUCHlwEFdPsZxFSya7mtKE0QAEhYziUH8iDeVTkm3rcImZFNJMBmvz9VA==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org,
	colin.king@canonical.com,
	tglx@linutronix.de,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	johnfwhitmore@gmail.com
Subject: [PATCH 11/13] Coding style: corrections to for statements.
Date: Mon, 14 May 2018 16:53:16 +0100
Message-Id: <20180514155318.32195-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180514155318.32195-1-johnfwhitmore@gmail.com>
References: <20180514155318.32195-1-johnfwhitmore@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600455453552482541?=
X-GMAIL-MSGID: =?utf-8?q?1600455453552482541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I few other minor coding style issues.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 42 ++++++++++------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 25db009e0a37..742eb35ae442 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -547,7 +547,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE = (PHT_CAPABILITY_ELE) &posHTCap[4];
+		pCapELE = (PHT_CAPABILITY_ELE)&posHTCap[4];
 	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)posHTCap;
 	}
@@ -602,7 +602,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
 		int i;
 
-		for(i = 1; i < 16; i++)
+		for (i = 1; i < 16; i++)
 			pCapELE->MCS[i] = 0;
 	}
 
@@ -719,7 +719,7 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 	*posRT2RTAgg++ = 0x4c;
 	*posRT2RTAgg++ = 0x02;
 	*posRT2RTAgg++ = 0x01;
-	*posRT2RTAgg = 0x10;//*posRT2RTAgg = 0x02;
+	*posRT2RTAgg = 0x10;    // *posRT2RTAgg = 0x02;
 
 	if (ieee->bSupportRemoteWakeUp)
 		*posRT2RTAgg |= 0x08;//RT_HT_CAP_USE_WOW;
@@ -729,16 +729,14 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 #ifdef TODO
 #if (HAL_CODE_BASE == RTL8192 && DEV_BUS_TYPE == USB_INTERFACE)
 	/*
-	//Emily. If it is required to Ask Realtek AP to send AMPDU during AES mode, enable this
-	   section of code.
-	if(IS_UNDER_11N_AES_MODE(Adapter))
-	{
-		posRT2RTAgg->Octet[5] |=RT_HT_CAP_USE_AMPDU;
-	}else
-	{
-		posRT2RTAgg->Octet[5] &= 0xfb;
-	}
-	*/
+	 * Emily. If it is required to Ask Realtek AP to send AMPDU during AES
+	 * mode, enable this section of code.
+	 *   if(IS_UNDER_11N_AES_MODE(Adapter)) {
+	 *           posRT2RTAgg->Octet[5] |=RT_HT_CAP_USE_AMPDU;
+	 *   } else {
+	 *           posRT2RTAgg->Octet[5] &= 0xfb;
+	 *   }
+	 */
 #else
 	// Do Nothing
 #endif
@@ -770,7 +768,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 		//legacy rate routine handled at selectedrate
 
 		//no MCS rate
-		for(i = 0; i <= 15; i++){
+		for (i = 0; i <= 15; i++) {
 			pOperateMCS[i] = 0;
 		}
 		break;
@@ -826,23 +824,21 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
 		return false;
 	}
-	for(i = 0; i < 16; i++)
+	for (i = 0; i < 16; i++)
 		availableMcsRate[i] = pMCSRateSet[i] & pMCSFilter[i];
 
-	for(i = 0; i < 16; i++)
-	{
+	for (i = 0; i < 16; i++) {
 		if (availableMcsRate[i] != 0)
 			break;
 	}
 	if (i == 16)
 		return false;
 
-	for(i = 0; i < 16; i++)
+	for (i = 0; i < 16; i++)
 	{
 		if (availableMcsRate[i] != 0) {
 			bitMap = availableMcsRate[i];
-			for(j = 0; j < 8; j++)
-			{
+			for (j = 0; j < 8; j++) {
 				if ((bitMap % 2) != 0) {
 					if (HTMcsToDataRate(ieee, (8 * i + j)) > HTMcsToDataRate(ieee, mcsRate))
 						mcsRate = (8 * i + j);
@@ -869,7 +865,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	u8 i = 0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
-	for(i = 0; i <= 15; i++){
+	for (i = 0; i <= 15; i++) {
 		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i] & pSupportMCS[i];
 	}
 
@@ -890,7 +886,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	 * For RTL819X, we support only MCS0~15.
 	 * And also, we do not know how to use MCS32 now.
 	 */
-	for(i = 2; i <= 15; i++)
+	for (i = 2; i <= 15; i++)
 		pOperateMCS[i] = 0;
 
 	return true;
@@ -1016,7 +1012,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 
 	// Lanhsin: mark for tmp to avoid deauth by ap from  s3
 	//if(memcmp(pMgntInfo->Bssid, NETGEAR834Bv2_BROADCOM, 3)==0)
-	if (0){
+	if (0) {
 		pHTInfo->bCurrentAMPDUEnable = false;
 		pHTInfo->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
 		pHTInfo->ForcedAMSDUMaxSize = 7935;
-- 
2.16.3
