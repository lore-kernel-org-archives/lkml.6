Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031431AbeEZIMq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 04:12:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54394 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031331AbeEZIL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 04:11:29 -0400
X-Google-Smtp-Source: ADUXVKIUd8s4QdLHRtPxxxnIQFr53DcDSdBjlL7+jP702lO+6qoLNzXmhhMmDaWSrSP24Y6XS72LkA==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: colin.king@canonical.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v4 1/5] staging: rtl8192e: Add spaces where required by coding standard
Date: Sat, 26 May 2018 09:10:15 +0100
Message-Id: <20180526081019.4738-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180526081019.4738-1-johnfwhitmore@gmail.com>
References: <20180526081019.4738-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were numerous coding syle errors in this file where spaces were required
around operators.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 126 ++++++++++-----------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 6952dab6ec80..0a8be54fea4a 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -60,8 +60,8 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 	//printk("pHTinfo:%p, &pHTinfo:%p, mptr:%p,  offsetof:%x\n", pHTInfo, &pHTInfo, __mptr, offsetof(struct ieee80211_device, pHTInfo));
 	//printk("===>ieee:%p,\n", ieee);
 	// ShortGI support
-	pHTInfo->bRegShortGI20MHz= 1;
-	pHTInfo->bRegShortGI40MHz= 1;
+	pHTInfo->bRegShortGI20MHz = 1;
+	pHTInfo->bRegShortGI40MHz = 1;
 
 	// 40MHz channel support
 	pHTInfo->bRegBW40MHz = 1;
@@ -138,12 +138,12 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString )
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString );
 
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
@@ -193,7 +193,7 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 			IEEE80211_DEBUG(IEEE80211_DL_HT, "Lower Channel\n");
 			break;
 	}
-	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tRecommended channel width = %s\n", (pHTInfoEle->RecommemdedTxWidth)?"20Mhz": "40Mhz");
+	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tRecommended channel width = %s\n", (pHTInfoEle->RecommemdedTxWidth) ? "20Mhz" : "40Mhz");
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tOperation mode for protection = ");
 	switch (pHTInfoEle->OptMode)
@@ -272,8 +272,8 @@ u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee,	u8	nMcsRate)
 	u8	is40MHz;
 	u8	isShortGI;
 
-	is40MHz  =  (IsHTHalfNmode40Bandwidth(ieee))?1:0;
-	isShortGI = (IsHTHalfNmodeSGI(ieee, is40MHz))? 1:0;
+	is40MHz = (IsHTHalfNmode40Bandwidth(ieee)) ? 1 : 0;
+	isShortGI = (IsHTHalfNmodeSGI(ieee, is40MHz)) ? 1 : 0;
 
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
 }
@@ -283,10 +283,10 @@ u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
 
-	u8	is40MHz = (pHTInfo->bCurBW40MHz)?1:0;
-	u8	isShortGI = (pHTInfo->bCurBW40MHz)?
-						((pHTInfo->bCurShortGI40MHz)?1:0):
-						((pHTInfo->bCurShortGI20MHz)?1:0);
+	u8	is40MHz = (pHTInfo->bCurBW40MHz) ? 1 : 0;
+	u8	isShortGI = (pHTInfo->bCurBW40MHz) ?
+						((pHTInfo->bCurShortGI40MHz) ? 1 : 0) :
+						((pHTInfo->bCurShortGI20MHz) ? 1 : 0);
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
 }
 
@@ -318,7 +318,7 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 
 		      // nDataRate = nDataRate - 12;
 		}
-		else if (nDataRate >=0x20  && nDataRate <= 0x2f ) //(27, 44)
+		else if (nDataRate >= 0x20  && nDataRate <= 0x2f ) //(27, 44)
 		{
 			is40MHz = 1;
 			isShortGI = 0;
@@ -349,17 +349,17 @@ bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee)
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
@@ -385,21 +385,21 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 		pHTInfo->IOTPeer = HT_IOT_PEER_REALTEK;
 	else if (net->broadcom_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
-	else if ((memcmp(net->bssid, UNKNOWN_BORADCOM, 3)==0) ||
-			(memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0)||
-			(memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)==0)||
-			(memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3)==0) )
+	else if ((memcmp(net->bssid, UNKNOWN_BORADCOM, 3) == 0) ||
+			(memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
+			(memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0) ||
+			(memcmp(net->bssid, NETGEAR834Bv2_BROADCOM, 3) == 0) )
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
-	else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3)==0) ||
-			(memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3)==0) ||
-			(memcmp(net->bssid, PCI_RALINK, 3)==0) ||
-			(memcmp(net->bssid, EDIMAX_RALINK, 3)==0) ||
-			(memcmp(net->bssid, AIRLINK_RALINK, 3)==0) ||
+	else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
+			(memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
+			(memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
+			(memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
+			(memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
 			 net->ralink_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_RALINK;
 	else if (net->atheros_cap_exist)
 		pHTInfo->IOTPeer = HT_IOT_PEER_ATHEROS;
-	else if (memcmp(net->bssid, CISCO_BROADCOM, 3)==0)
+	else if (memcmp(net->bssid, CISCO_BROADCOM, 3) == 0)
 		pHTInfo->IOTPeer = HT_IOT_PEER_CISCO;
 	else
 		pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
@@ -438,7 +438,7 @@ static bool HTIOTActIsDisableMCS15(struct ieee80211_device *ieee)
 
 #ifdef TODO
 	// Apply for 819u only
-#if (HAL_CODE_BASE==RTL8192)
+#if (HAL_CODE_BASE == RTL8192)
 
 #if (DEV_BUS_TYPE == USB_INTERFACE)
 	// Alway disable MCS15 by Jerry Chang's request.by Emily, 2008.04.15
@@ -515,9 +515,9 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 static u8 HTIOTActIsCCDFsync(u8 *PeerMacAddr)
 {
 	u8	retValue = 0;
-	if ((memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3)==0) ||
-	    (memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3)==0) ||
-	    (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ==0))
+	if ((memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3) == 0) ||
+	    (memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
+	    (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0))
 	{
 		retValue = 1;
 	}
@@ -575,7 +575,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	}
 	else
 	{
-		pCapELE->ChlWidth = (pHT->bRegBW40MHz?1:0);
+		pCapELE->ChlWidth = (pHT->bRegBW40MHz ? 1 : 0);
 	}
 
 //	pCapELE->ChlWidth		= (pHT->bRegBW40MHz?1:0);
@@ -588,8 +588,8 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->TxSTBC			= 1;
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;	// Do not support now!!
-	pCapELE->MaxAMSDUSize	= (MAX_RECEIVE_BUFFER_SIZE>=7935)?1:0;
-	pCapELE->DssCCk			= ((pHT->bRegBW40MHz)?(pHT->bRegSuppCCK?1:0):0);
+	pCapELE->MaxAMSDUSize	        = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
+	pCapELE->DssCCk			= ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) : 0);
 	pCapELE->PSMP			= 0; // Do not support now!!
 	pCapELE->LSigTxopProtect	= 0; // Do not support now!!
 
@@ -600,11 +600,11 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 	if (IsEncrypt) {
 		pCapELE->MPDUDensity	= 7; // 8us
-		pCapELE->MaxRxAMPDUFactor	= 2; // 2 is for 32 K and 3 is 64K
+		pCapELE->MaxRxAMPDUFactor = 2; // 2 is for 32 K and 3 is 64K
 	}
 	else
 	{
-		pCapELE->MaxRxAMPDUFactor	= 3; // 2 is for 32 K and 3 is 64K
+		pCapELE->MaxRxAMPDUFactor = 3; // 2 is for 32 K and 3 is 64K
 		pCapELE->MPDUDensity	= 0; // no density
 	}
 
@@ -624,7 +624,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 	{
 		int i;
-		for (i = 1; i< 16; i++)
+		for (i = 1; i < 16; i++)
 			pCapELE->MCS[i] = 0;
 	}
 
@@ -676,9 +676,9 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 	if ( (ieee->iw_mode == IW_MODE_ADHOC) || (ieee->iw_mode == IW_MODE_MASTER)) //ap mode is not currently supported
 	{
 		pHTInfoEle->ControlChl			= ieee->current_network.channel;
-		pHTInfoEle->ExtChlOffset			= ((!pHT->bRegBW40MHz)?HT_EXTCHNL_OFFSET_NO_EXT:
-											(ieee->current_network.channel<=6)?
-												HT_EXTCHNL_OFFSET_UPPER:HT_EXTCHNL_OFFSET_LOWER);
+		pHTInfoEle->ExtChlOffset		= ((!pHT->bRegBW40MHz) ? HT_EXTCHNL_OFFSET_NO_EXT :
+											(ieee->current_network.channel <= 6) ?
+												HT_EXTCHNL_OFFSET_UPPER : HT_EXTCHNL_OFFSET_LOWER);
 		pHTInfoEle->RecommemdedTxWidth	= pHT->bRegBW40MHz;
 		pHTInfoEle->RIFS					= 0;
 		pHTInfoEle->PSMPAccessOnly		= 0;
@@ -805,7 +805,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 			//legacy rate routine handled at selectedrate
 
 			//no MCS rate
-			for (i=0;i<=15;i++){
+			for (i = 0; i <= 15; i++){
 				pOperateMCS[i] = 0;
 			}
 			break;
@@ -817,9 +817,9 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 
 			//HT part
 			// TODO: may be different if we have different number of antenna
-			pOperateMCS[0] &=RATE_ADPT_1SS_MASK;	//support MCS 0~7
-			pOperateMCS[1] &=RATE_ADPT_2SS_MASK;
-			pOperateMCS[3] &=RATE_ADPT_MCS32_MASK;
+			pOperateMCS[0] &= RATE_ADPT_1SS_MASK;	//support MCS 0~7
+			pOperateMCS[1] &= RATE_ADPT_2SS_MASK;
+			pOperateMCS[3] &= RATE_ADPT_MCS32_MASK;
 			break;
 
 	//should never reach here
@@ -862,7 +862,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
 		return false;
 	}
-	for (i=0; i<16; i++)
+	for (i = 0; i < 16; i++)
 		availableMcsRate[i] = pMCSRateSet[i] & pMCSFilter[i];
 
 	for (i = 0; i < 16; i++)
@@ -907,10 +907,10 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 			  u8 *pOperateMCS)
 {
 
-	u8 i=0;
+	u8 i = 0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
-	for (i=0;i<=15;i++){
+	for (i = 0; i <= 15; i++){
 		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i]&pSupportMCS[i];
 	}
 
@@ -929,7 +929,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	// For RTL819X, we support only MCS0~15.
 	// And also, we do not know how to use MCS32 now.
 	//
-	for (i=2; i<=15; i++)
+	for (i = 2; i <= 15; i++)
 		pOperateMCS[i] = 0;
 
 	return true;
@@ -1006,7 +1006,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	//
 	pHTInfo->bCurrent_AMSDU_Support = pHTInfo->bAMSDU_Support;
 
-	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize==0)?3839:7935;
+	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
 
 	if (pHTInfo->nAMSDU_MaxSize > nMaxAMSDUSize )
 		pHTInfo->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
@@ -1196,7 +1196,7 @@ void HTInitializeBssDesc(PBSS_HT pBssHT)
 	memset(pBssHT->bdHTInfoBuf, 0, sizeof(pBssHT->bdHTInfoBuf));
 	pBssHT->bdHTInfoLen = 0;
 
-	pBssHT->bdHTSpecVer= HT_SPEC_VER_IEEE;
+	pBssHT->bdHTSpecVer = HT_SPEC_VER_IEEE;
 
 	pBssHT->bdRT2RTAggregation = false;
 	pBssHT->bdRT2RTLongSlotTime = false;
@@ -1357,12 +1357,12 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
 		return;
 	}
 	//if in half N mode, set to 20M bandwidth please 09.08.2008 WB.
-	if (Bandwidth==HT_CHANNEL_WIDTH_20_40 && (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)))
+	if (Bandwidth == HT_CHANNEL_WIDTH_20_40 && (!ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)))
 	 {
 			// Handle Illegal extension channel offset!!
-		if (ieee->current_network.channel<2 && Offset==HT_EXTCHNL_OFFSET_LOWER)
+		if (ieee->current_network.channel < 2 && Offset == HT_EXTCHNL_OFFSET_LOWER)
 			Offset = HT_EXTCHNL_OFFSET_NO_EXT;
-		if (Offset==HT_EXTCHNL_OFFSET_UPPER || Offset==HT_EXTCHNL_OFFSET_LOWER) {
+		if (Offset == HT_EXTCHNL_OFFSET_UPPER || Offset == HT_EXTCHNL_OFFSET_LOWER) {
 			pHTInfo->bCurBW40MHz = true;
 			pHTInfo->CurSTAExtChnlOffset = Offset;
 		} else {
@@ -1393,9 +1393,9 @@ void HTSetConnectBwModeCallback(struct ieee80211_device *ieee)
 
 	if (pHTInfo->bCurBW40MHz)
 	{
-		if (pHTInfo->CurSTAExtChnlOffset==HT_EXTCHNL_OFFSET_UPPER)
+		if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
 			ieee->set_chan(ieee->dev, ieee->current_network.channel+2);
-		else if (pHTInfo->CurSTAExtChnlOffset==HT_EXTCHNL_OFFSET_LOWER)
+		else if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_LOWER)
 			ieee->set_chan(ieee->dev, ieee->current_network.channel-2);
 		else
 			ieee->set_chan(ieee->dev, ieee->current_network.channel);
-- 
2.16.3
