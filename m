Return-Path: <johnfwhitmore@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526313252; cv=none;
        d=google.com; s=arc-20160816;
        b=SKJMN+tPZ1PIqD2hF2MmM2LOeTvyxCUwg+KcZcQtPUkddfEM5Ytj0/7HFGlKSl5GY0
         FZb/Cu+ar8SIUasZnXbDPw8TBrvRXx5VKbQN1vjc6xGlcs74NHBk4oRhkgbotStNOlta
         2p4vLpn9AXsBxACQcGaqqn3tDE+qRUI2QBYBrLB4YKUwWV78Ox6o8ftEqVUVAG8Mzt7r
         A1axAYfOgy7AWkBYgVR3jMtgw+WlZCBrLkTXSvimJWZo6Ifq0AT3Zhr0GjcsAQldcvpD
         lIqprfyih8gY8PbUm1vIQUYinlxyWIRaGQuwyR9R4UDxRT7m9SjrAekEQoZM4RF9B5Q1
         FyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=e9sBl8j+U3+svDLQodwOvu2mwC8AisvR54Svz6bxAKo=;
        b=TiQGwcwqcjq8SHgKl16GheQGZk9ipiyDZgedgWoYk+6VV3c+2x1IG4hCJZUccZgliM
         TF+i4abDy27Bvum0AGh+Xtp/tt8XiY0ivVq3sPsoOAljFRb7UgvP9Y6NFOzJVeb2bsLP
         6LpJb/MZ/ky9czjSs8lNuaprJn8MWDj0ONR43gWDnVQfIIsj8zY6mPat/k21VjngWP0g
         UflS+FnLA9QgopWaJTpULCpgKhpY2nuHUP7VRzCmIW+fwwmZ1o7Ebd2/ehiycf8ABv0I
         gEcQG9n4VSm2eVDCWf++msCOo4svhZUNDYd4KrhkFzbrjxc25SugMTXOrAI4L8p/d7oe
         105Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FthBVjMW;
       spf=pass (google.com: domain of johnfwhitmore@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=johnfwhitmore@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FthBVjMW;
       spf=pass (google.com: domain of johnfwhitmore@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=johnfwhitmore@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZomD+rehkwCQASDJ7vNFBF/FDW4eVVa/CE2AI4GRzI1A2uhKBMisxVOgINIOsk7EiT56etY0Q==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org,
	colin.king@canonical.com,
	tglx@linutronix.de,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	johnfwhitmore@gmail.com
Subject: [PATCH 05/13] Coding style corrections. Added spaces around operators.
Date: Mon, 14 May 2018 16:53:10 +0100
Message-Id: <20180514155318.32195-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180514155318.32195-1-johnfwhitmore@gmail.com>
References: <20180514155318.32195-1-johnfwhitmore@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600455444747181873?=
X-GMAIL-MSGID: =?utf-8?q?1600455444747181873?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 148 ++++++++++-----------
 1 file changed, 74 insertions(+), 74 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 110fa8ba15db..925a8f313e9f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -63,8 +63,8 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 	//printk("pHTinfo:%p, &pHTinfo:%p, mptr:%p,  offsetof:%x\n", pHTInfo, &pHTInfo, __mptr, offsetof(struct ieee80211_device, pHTInfo));
 	//printk("===>ieee:%p,\n", ieee);
 	// ShortGI support
-	pHTInfo->bRegShortGI20MHz= 1;
-	pHTInfo->bRegShortGI40MHz= 1;
+	pHTInfo->bRegShortGI20MHz = 1;
+	pHTInfo->bRegShortGI40MHz = 1;
 
 	// 40MHz channel support
 	pHTInfo->bRegBW40MHz = 1;
@@ -140,12 +140,12 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString);
 
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->ChlWidth)?"20MHz": "20/40MHz");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->ShortGI20Mhz)?"YES": "NO");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 40M = %s\n", (pCapELE->ShortGI40Mhz)?"YES": "NO");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport TX STBC = %s\n", (pCapELE->TxSTBC)?"YES": "NO");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMSDU Size = %s\n", (pCapELE->MaxAMSDUSize)?"3839": "7935");
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode = %s\n", (pCapELE->DssCCk)?"YES": "NO");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->ChlWidth) ? "20MHz" : "20/40MHz");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 20M = %s\n", (pCapELE->ShortGI20Mhz) ? "YES" : "NO");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport Short GI for 40M = %s\n", (pCapELE->ShortGI40Mhz) ? "YES" : "NO");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport TX STBC = %s\n", (pCapELE->TxSTBC) ? "YES" : "NO");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMSDU Size = %s\n", (pCapELE->MaxAMSDUSize) ? "3839" : "7935");
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode = %s\n", (pCapELE->DssCCk) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMPDU Factor = %d\n", pCapELE->MaxRxAMPDUFactor);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMPDU Density = %d\n", pCapELE->MPDUDensity);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->MCS[0],\
@@ -194,7 +194,7 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 		IEEE80211_DEBUG(IEEE80211_DL_HT, "Lower Channel\n");
 		break;
 	}
-	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tRecommended channel width = %s\n", (pHTInfoEle->RecommemdedTxWidth)?"20Mhz": "40Mhz");
+	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tRecommended channel width = %s\n", (pHTInfoEle->RecommemdedTxWidth) ? "20Mhz" : "40Mhz");
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tOperation mode for protection = ");
 	switch (pHTInfoEle->OptMode) {
@@ -268,21 +268,21 @@ u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee,	u8	nMcsRate)
 	u8	is40MHz;
 	u8	isShortGI;
 
-	is40MHz  =  (IsHTHalfNmode40Bandwidth(ieee))?1:0;
-	isShortGI = (IsHTHalfNmodeSGI(ieee, is40MHz))? 1:0;
+	is40MHz  =  (IsHTHalfNmode40Bandwidth(ieee)) ? 1 : 0;
+	isShortGI = (IsHTHalfNmodeSGI(ieee, is40MHz)) ? 1 : 0;
 
-	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
+	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
 }
 
 u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
 
-	u8	is40MHz = (pHTInfo->bCurBW40MHz)?1:0;
-	u8	isShortGI = (pHTInfo->bCurBW40MHz)?
-						((pHTInfo->bCurShortGI40MHz)?1:0):
-						((pHTInfo->bCurShortGI20MHz)?1:0);
-	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
+	u8	is40MHz = (pHTInfo->bCurBW40MHz) ? 1 : 0;
+	u8	isShortGI = (pHTInfo->bCurBW40MHz) ?
+						((pHTInfo->bCurShortGI40MHz) ? 1 : 0) :
+						((pHTInfo->bCurShortGI20MHz) ? 1 : 0);
+	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
 }
 
 /*******************************************************************************
@@ -309,7 +309,7 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 			isShortGI = 0;
 
 		      // nDataRate = nDataRate - 12;
-		} else if (nDataRate >=0x20  && nDataRate <= 0x2f) { //(27, 44)
+		} else if (nDataRate >= 0x20  && nDataRate <= 0x2f) { //(27, 44)
 			is40MHz = 1;
 			isShortGI = 0;
 
@@ -325,7 +325,7 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 
 			//nDataRate = nDataRate - 60;
 		}
-		return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate&0xf];
+		return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
 	}
 }
 
@@ -333,17 +333,17 @@ bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee)
 {
 	bool			retValue = false;
 	struct ieee80211_network *net = &ieee->current_network;
-	if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3)==0) ||
-	    (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3)==0) ||
-	    (memcmp(net->bssid, PCI_RALINK, 3)==0) ||
-	    (memcmp(net->bssid, EDIMAX_RALINK, 3)==0) ||
-	    (memcmp(net->bssid, AIRLINK_RALINK, 3)==0) ||
+	if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
+	    (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
+	    (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
+	    (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
+	    (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
 	    (net->ralink_cap_exist))
 		retValue = true;
-	else if ((memcmp(net->bssid, UNKNOWN_BORADCOM, 3)==0) ||
-		 (memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0)||
-		 (memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)==0)||
-		 (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3)==0) ||
+	else if ((memcmp(net->bssid, UNKNOWN_BORADCOM, 3) == 0) ||
+		 (memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
+		 (memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0) ||
+		 (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3) == 0) ||
 		 (net->broadcom_cap_exist))
 		  retValue = true;
 	else if (net->bssht.bdRT2RTAggregation)
@@ -370,21 +370,21 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 		pHTInfo->IOTPeer = HT_IOT_PEER_REALTEK;
 	else if (net->broadcom_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
-	else if ((memcmp(net->bssid, UNKNOWN_BORADCOM, 3)==0) ||
-		 (memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0)||
-		 (memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)==0)||
-		 (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3)==0))
+	else if ((memcmp(net->bssid, UNKNOWN_BORADCOM, 3) == 0) ||
+		 (memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
+		 (memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0) ||
+		 (memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3) == 0))
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
-	else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3)==0) ||
-		 (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3)==0) ||
-		 (memcmp(net->bssid, PCI_RALINK, 3)==0) ||
-		 (memcmp(net->bssid, EDIMAX_RALINK, 3)==0) ||
-		 (memcmp(net->bssid, AIRLINK_RALINK, 3)==0) ||
+	else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
+		 (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
+		 (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
+		 (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
+		 (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
 		 net->ralink_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_RALINK;
 	else if (net->atheros_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_ATHEROS;
-	else if (memcmp(net->bssid, CISCO_BROADCOM, 3)==0)
+	else if (memcmp(net->bssid, CISCO_BROADCOM, 3) == 0)
 		pHTInfo->IOTPeer = HT_IOT_PEER_CISCO;
 	else
 		pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
@@ -424,7 +424,7 @@ static bool HTIOTActIsDisableMCS15(struct ieee80211_device *ieee)
 
 #ifdef TODO
 	// Apply for 819u only
-#if (HAL_CODE_BASE==RTL8192)
+#if (HAL_CODE_BASE == RTL8192)
 
 #if (DEV_BUS_TYPE == USB_INTERFACE)
 	// Alway disable MCS15 by Jerry Chang's request.by Emily, 2008.04.15
@@ -505,9 +505,9 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 static u8 HTIOTActIsCCDFsync(u8 *PeerMacAddr)
 {
 	u8	retValue = 0;
-	if ((memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3)==0) ||
-	    (memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0) ||
-	    (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ==0))
+	if ((memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3) == 0) ||
+	    (memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
+	    (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0))
 		retValue = 1;
 
 	return retValue;
@@ -544,7 +544,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE = (PHT_CAPABILITY_ELE)&(posHTCap[4]);
+		pCapELE = (PHT_CAPABILITY_ELE) & (posHTCap[4]);
 	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)posHTCap;
 	}
@@ -554,7 +554,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pCapELE->ChlWidth = 0;
 	else
-		pCapELE->ChlWidth = (pHT->bRegBW40MHz?1:0);
+		pCapELE->ChlWidth = (pHT->bRegBW40MHz ? 1 : 0);
 
 //	pCapELE->ChlWidth		= (pHT->bRegBW40MHz?1:0);
 	pCapELE->MimoPwrSave		= pHT->SelfMimoPs;
@@ -566,8 +566,8 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->TxSTBC			= 1;
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;	// Do not support now!!
-	pCapELE->MaxAMSDUSize	= (MAX_RECEIVE_BUFFER_SIZE>=7935)?1:0;
-	pCapELE->DssCCk			= ((pHT->bRegBW40MHz)?(pHT->bRegSuppCCK?1:0):0);
+	pCapELE->MaxAMSDUSize	        = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
+	pCapELE->DssCCk			= ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
 	pCapELE->PSMP			= 0; // Do not support now!!
 	pCapELE->LSigTxopProtect	= 0; // Do not support now!!
 
@@ -598,7 +598,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	// For RTL819X, if pairwisekey = wep/tkip, ap is ralink, we support only MCS0~7.
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
 		int i;
-		for(i = 1; i< 16; i++)
+		for(i = 1; i < 16; i++)
 			pCapELE->MCS[i] = 0;
 	}
 
@@ -648,10 +648,10 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	memset(posHTInfo, 0, *len);
 	if ( (ieee->iw_mode == IW_MODE_ADHOC) || (ieee->iw_mode == IW_MODE_MASTER)) { //ap mode is not currently supported
 		pHTInfoEle->ControlChl			= ieee->current_network.channel;
-		pHTInfoEle->ExtChlOffset		= ((!pHT->bRegBW40MHz)?HT_EXTCHNL_OFFSET_NO_EXT:
-											(ieee->current_network.channel<=6)?
-												HT_EXTCHNL_OFFSET_UPPER:HT_EXTCHNL_OFFSET_LOWER);
-		pHTInfoEle->RecommemdedTxWidth	= pHT->bRegBW40MHz;
+		pHTInfoEle->ExtChlOffset		= ((!pHT->bRegBW40MHz) ? HT_EXTCHNL_OFFSET_NO_EXT :
+											(ieee->current_network.channel <= 6) ?
+												HT_EXTCHNL_OFFSET_UPPER : HT_EXTCHNL_OFFSET_LOWER);
+		pHTInfoEle->RecommemdedTxWidth	        = pHT->bRegBW40MHz;
 		pHTInfoEle->RIFS			= 0;
 		pHTInfoEle->PSMPAccessOnly		= 0;
 		pHTInfoEle->SrvIntGranularity		= 0;
@@ -766,7 +766,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 		//legacy rate routine handled at selectedrate
 
 		//no MCS rate
-		for(i=0;i<=15;i++){
+		for(i = 0; i <= 15; i++){
 			pOperateMCS[i] = 0;
 		}
 		break;
@@ -778,9 +778,9 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 
 		//HT part
 		// TODO: may be different if we have different number of antenna
-		pOperateMCS[0] &=RATE_ADPT_1SS_MASK;	//support MCS 0~7
-		pOperateMCS[1] &=RATE_ADPT_2SS_MASK;
-		pOperateMCS[3] &=RATE_ADPT_MCS32_MASK;
+		pOperateMCS[0] &= RATE_ADPT_1SS_MASK;	//support MCS 0~7
+		pOperateMCS[1] &= RATE_ADPT_2SS_MASK;
+		pOperateMCS[3] &= RATE_ADPT_MCS32_MASK;
 		break;
 
 		//should never reach here
@@ -821,7 +821,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
 		return false;
 	}
-	for(i=0; i<16; i++)
+	for(i = 0; i < 16; i++)
 		availableMcsRate[i] = pMCSRateSet[i] & pMCSFilter[i];
 
 	for(i = 0; i < 16; i++)
@@ -838,15 +838,15 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 			bitMap = availableMcsRate[i];
 			for(j = 0; j < 8; j++)
 			{
-				if ((bitMap%2) != 0) {
-					if (HTMcsToDataRate(ieee, (8*i+j)) > HTMcsToDataRate(ieee, mcsRate))
-						mcsRate = (8*i+j);
+				if ((bitMap % 2) != 0) {
+					if (HTMcsToDataRate(ieee, (8 * i + j)) > HTMcsToDataRate(ieee, mcsRate))
+						mcsRate = (8 * i + j);
 				}
 				bitMap >>= 1;
 			}
 		}
 	}
-	return (mcsRate|0x80);
+	return (mcsRate | 0x80);
 }
 
 /*
@@ -861,11 +861,11 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 			  u8 *pOperateMCS)
 {
-	u8 i=0;
+	u8 i = 0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
-	for(i=0;i<=15;i++){
-		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i]&pSupportMCS[i];
+	for(i = 0; i <= 15; i++){
+		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i] & pSupportMCS[i];
 	}
 
 	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
@@ -885,7 +885,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	 * For RTL819X, we support only MCS0~15.
 	 * And also, we do not know how to use MCS32 now.
 	 */
-	for(i=2; i<=15; i++)
+	for(i = 2; i <= 15; i++)
 		pOperateMCS[i] = 0;
 
 	return true;
@@ -926,7 +926,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	////////////////////////////////////////////////////////
 	// Configurations:
 	////////////////////////////////////////////////////////
-	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_HT, pPeerHTCap, sizeof(HT_CAPABILITY_ELE));
+	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, pPeerHTCap, sizeof(HT_CAPABILITY_ELE));
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_HT, pPeerHTInfo, sizeof(HT_INFORMATION_ELE));
 	// Config Supported Channel Width setting
 	//
@@ -960,7 +960,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	//
 	pHTInfo->bCurrent_AMSDU_Support = pHTInfo->bAMSDU_Support;
 
-	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize==0)?3839:7935;
+	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
 
 	if (pHTInfo->nAMSDU_MaxSize > nMaxAMSDUSize )
 		pHTInfo->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
@@ -1146,7 +1146,7 @@ void HTInitializeBssDesc(PBSS_HT pBssHT)
 	memset(pBssHT->bdHTInfoBuf, 0, sizeof(pBssHT->bdHTInfoBuf));
 	pBssHT->bdHTInfoLen = 0;
 
-	pBssHT->bdHTSpecVer= HT_SPEC_VER_IEEE;
+	pBssHT->bdHTSpecVer = HT_SPEC_VER_IEEE;
 
 	pBssHT->bdRT2RTAggregation = false;
 	pBssHT->bdRT2RTLongSlotTime = false;
@@ -1300,11 +1300,11 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
 		return;
 	}
 	//if in half N mode, set to 20M bandwidth please 09.08.2008 WB.
-	if (Bandwidth==HT_CHANNEL_WIDTH_20_40 && (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))) {
+	if (Bandwidth == HT_CHANNEL_WIDTH_20_40 && (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))) {
 			// Handle Illegal extension channel offset!!
-		if (ieee->current_network.channel<2 && Offset==HT_EXTCHNL_OFFSET_LOWER)
+		if (ieee->current_network.channel < 2 && Offset == HT_EXTCHNL_OFFSET_LOWER)
 			Offset = HT_EXTCHNL_OFFSET_NO_EXT;
-		if (Offset==HT_EXTCHNL_OFFSET_UPPER || Offset==HT_EXTCHNL_OFFSET_LOWER) {
+		if (Offset == HT_EXTCHNL_OFFSET_UPPER || Offset == HT_EXTCHNL_OFFSET_LOWER) {
 			pHTInfo->bCurBW40MHz = true;
 			pHTInfo->CurSTAExtChnlOffset = Offset;
 		} else {
@@ -1336,10 +1336,10 @@ void HTSetConnectBwModeCallback(struct ieee80211_device *ieee)
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "======>%s()\n", __func__);
 
 	if (pHTInfo->bCurBW40MHz) {
-		if (pHTInfo->CurSTAExtChnlOffset==HT_EXTCHNL_OFFSET_UPPER)
-			ieee->set_chan(ieee->dev, ieee->current_network.channel+2);
-		else if (pHTInfo->CurSTAExtChnlOffset==HT_EXTCHNL_OFFSET_LOWER)
-			ieee->set_chan(ieee->dev, ieee->current_network.channel-2);
+		if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
+			ieee->set_chan(ieee->dev, ieee->current_network.channel + 2);
+		else if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_LOWER)
+			ieee->set_chan(ieee->dev, ieee->current_network.channel - 2);
 		else
 			ieee->set_chan(ieee->dev, ieee->current_network.channel);
 
-- 
2.16.3
