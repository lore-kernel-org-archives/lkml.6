Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocDyMvtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2AC6608A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeFFLkj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:40:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38426 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbeFFLkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:40:35 -0400
X-Google-Smtp-Source: ADUXVKKoy/OUpasmLvMmlmuJzo6nt7mQsZLjbnZR0tLNpZfHgsU7rOmGWluSo4p2tCLZG7u0f+RjUQ==
From: John Whitmore <johnfwhitmore@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, colin.king@canonical.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        devel@driverdev.osuosl.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v6 1/8] staging: rtl8192e: Add and remove blank lines - Coding style
Date: Wed,  6 Jun 2018 12:39:56 +0100
Message-Id: <20180606114003.22654-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180606114003.22654-1-johnfwhitmore@gmail.com>
References: <20180606114003.22654-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple addition & removal of blank lines as required

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 64 +++++--------------
 1 file changed, 16 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 1b61a8de1edf..47b6add256d0 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -111,9 +111,8 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 	pHTInfo->UsbRxFwAggrPacketNum = 8;
 	pHTInfo->UsbRxFwAggrTimeout = 16; ////usb rx FW aggregation timeout threshold.It's in units of 64us
 #endif
-
-
 }
+
 /********************************************************************************************************************
  *function:  This function print out each field on HT capability IE mainly from (Beacon/ProbeRsp/AssocReq)
  *   input:  u8*	CapIE       //Capability IE to be printed out
@@ -124,7 +123,6 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
  * *****************************************************************************************************************/
 void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 {
-
 	static u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
 	PHT_CAPABILITY_ELE		pCapELE;
 
@@ -148,8 +146,8 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set = [%x][%x][%x][%x][%x]\n", pCapELE->MCS[0],\
 				pCapELE->MCS[1], pCapELE->MCS[2], pCapELE->MCS[3], pCapELE->MCS[4]);
 	return;
-
 }
+
 /********************************************************************************************************************
  *function:  This function print out each field on HT Information IE mainly from (Beacon/ProbeRsp)
  *   input:  u8*	InfoIE       //Capability IE to be printed out
@@ -160,7 +158,6 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
  * *****************************************************************************************************************/
 void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 {
-
 	static u8	EWC11NHTInfo[] = {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC definition, 2007.07.17, by Emily
 	PHT_INFORMATION_ELE		pHTInfoEle;
 
@@ -261,7 +258,6 @@ static bool IsHTHalfNmodeSGI(struct ieee80211_device *ieee, bool is40MHz)
 
 u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee,	u8	nMcsRate)
 {
-
 	u8	is40MHz;
 	u8	isShortGI;
 
@@ -271,7 +267,6 @@ u16 HTHalfMcsToDataRate(struct ieee80211_device *ieee,	u8	nMcsRate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate&0x7f)];
 }
 
-
 u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
@@ -326,12 +321,11 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 	}
 }
 
-
-
 bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee)
 {
 	bool			retValue = false;
 	struct ieee80211_network *net = &ieee->current_network;
+
 	if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
 	    (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
 	    (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
@@ -364,6 +358,7 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
 	struct ieee80211_network *net = &ieee->current_network;
+
 	if (net->bssht.bdRT2RTAggregation)
 		pHTInfo->IOTPeer = HT_IOT_PEER_REALTEK;
 	else if (net->broadcom_cap_exist)
@@ -389,6 +384,7 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 
 	IEEE80211_DEBUG(IEEE80211_DL_IOT, "Joseph debug!! IOTPEER: %x\n", pHTInfo->IOTPeer);
 }
+
 /********************************************************************************************************************
  *function:  Check whether driver should declare received rate up to MCS13 only since some chipset is not good
  *	     at receiving MCS14~15 frame from some AP.
@@ -402,7 +398,6 @@ static u8 HTIOTActIsDisableMCS14(struct ieee80211_device *ieee, u8 *PeerMacAddr)
 	return 0;
  }
 
-
 /**
 * Function:	HTIOTActIsDisableMCS15
 *
@@ -496,6 +491,7 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 static u8 HTIOTActIsCCDFsync(u8 *PeerMacAddr)
 {
 	u8	retValue = 0;
+
 	if ((memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3) == 0) ||
 	    (memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
 	    (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0))
@@ -512,7 +508,6 @@ void HTResetIOTSetting(
 	pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
 }
 
-
 /********************************************************************************************************************
  *function:  Construct Capablility Element in Beacon... if HTEnable is turned on
  *   input:  struct ieee80211_device*	ieee
@@ -536,13 +531,13 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	memset(posHTCap, 0, *len);
 	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
+
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
 		pCapELE = (PHT_CAPABILITY_ELE)&(posHTCap[4]);
 	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)posHTCap;
 	}
 
-
 	//HT capability info
 	pCapELE->AdvCoding		= 0; // This feature is not supported now!!
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
@@ -566,7 +561,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->PSMP			= 0; // Do not support now!!
 	pCapELE->LSigTxopProtect	= 0; // Do not support now!!
 
-
 	//MAC HT parameters info
 	// TODO: Nedd to take care of this part
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "TX HT cap/info ele BW=%d MaxAMSDUSize:%d DssCCk:%d\n", pCapELE->ChlWidth, pCapELE->MaxAMSDUSize, pCapELE->DssCCk);
@@ -594,6 +588,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	// For RTL819X, if pairwisekey = wep/tkip, ap is ralink, we support only MCS0~7.
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
 		int i;
+
 		for (i = 1; i < 16; i++)
 			pCapELE->MCS[i] = 0;
 	}
@@ -601,7 +596,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	//Extended HT Capability Info
 	memset(&pCapELE->ExtHTCapInfo, 0, 2);
 
-
 	//TXBF Capabilities
 	memset(pCapELE->TxBFCap, 0, 4);
 
@@ -613,15 +607,13 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	else
 		*len = 26 + 2;
 
-
-
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, posHTCap, *len -2);
 
 	//Print each field in detail. Driver should not print out this message by default
 //	HTDebugHTCapability(posHTCap, (u8*)"HTConstructCapability()");
 	return;
-
 }
+
 /********************************************************************************************************************
  *function:  Construct  Information Element in Beacon... if HTEnable is turned on
  *   input:  struct ieee80211_device*	ieee
@@ -636,6 +628,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 {
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
 	PHT_INFORMATION_ELE		pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
+
 	if ((posHTInfo == NULL) || (pHTInfoEle == NULL)) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in HTConstructInfoElement()\n");
 		return;
@@ -661,9 +654,7 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 
 		memset(pHTInfoEle->BasicMSC, 0, 16);
 
-
 		*len = 22 + 2; //same above
-
 	} else {
 		//STA should not generate High Throughput Information Element
 		*len = 0;
@@ -733,20 +724,14 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 		posRT2RTAgg->Octet[5] &= 0xfb;
 	}
 	*/
-
 #else
 	// Do Nothing
 #endif
 
 	posRT2RTAgg->Length = 6;
 #endif
-
-
-
-
 }
 
-
 /********************************************************************************************************************
  *function:  Pick the right Rate Adaptive table to use
  *   input:  struct ieee80211_device*	ieee
@@ -757,6 +742,7 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
 	u8					i;
+
 	if (pOperateMCS == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
 		return false;
@@ -787,9 +773,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 
 	//should never reach here
 	default:
-
 			break;
-
 	}
 
 	return true;
@@ -820,6 +804,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		bitMap;
 	u8		mcsRate = 0;
 	u8		availableMcsRate[16];
+
 	if (pMCSRateSet == NULL || pMCSFilter == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
 		return false;
@@ -849,8 +834,6 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	return (mcsRate|0x80);
 }
 
-
-
 /*
 **
 **1.Filter our operation rate set with AP's rate set
@@ -863,7 +846,6 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 			  u8 *pOperateMCS)
 {
-
 	u8 i = 0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
@@ -871,7 +853,6 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i]&pSupportMCS[i];
 	}
 
-
 	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
 
 	// TODO: fill suggested rate adaptive rate index and give firmware info using Tx command packet
@@ -891,6 +872,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 
 	return true;
 }
+
 void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidth, HT_EXTCHNL_OFFSET	Offset);
 void HTOnAssocRsp(struct ieee80211_device *ieee)
 {
@@ -924,7 +906,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	else
 		pPeerHTInfo = (PHT_INFORMATION_ELE)(pHTInfo->PeerHTInfoBuf);
 
-
 	////////////////////////////////////////////////////////
 	// Configurations:
 	////////////////////////////////////////////////////////
@@ -957,7 +938,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	pHTInfo->bCurSuppCCK = pHTInfo->bRegSuppCCK &&
 			       (pPeerHTCap->DssCCk == 1);
 
-
 	//
 	// Config and configure A-MSDU setting
 	//
@@ -969,8 +949,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 		pHTInfo->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
 	else
 		pHTInfo->nCurrent_AMSDU_MaxSize = pHTInfo->nAMSDU_MaxSize;
-
-
 	//
 	// Config A-MPDU setting
 	//
@@ -985,7 +963,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 			pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
 		else
 			pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
-
 	} else {
 		// Set MPDU density to 2 to Realtek AP, and set it to 0 for others
 		// Replace MPDU factor declared in original association response frame format. 2007.08.20 by Emily
@@ -1056,9 +1033,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	// Config current operation mode.
 	//
 	pHTInfo->CurrentOpMode = pPeerHTInfo->OptMode;
-
-
-
 }
 
 void HTSetConnectBwModeCallback(struct ieee80211_device *ieee);
@@ -1103,8 +1077,6 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
 	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 
-
-
 	// Initialize all of the parameters related to 11n
 	memset((void *)(&(pHTInfo->SelfHTCap)), 0, sizeof(pHTInfo->SelfHTCap));
 	memset((void *)(&(pHTInfo->SelfHTInfo)), 0, sizeof(pHTInfo->SelfHTInfo));
@@ -1126,11 +1098,13 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	//MCS rate initialized here
 	{
 		u8 *RegHTSuppRateSets = &(ieee->RegHTSuppRateSet[0]);
+
 		RegHTSuppRateSets[0] = 0xFF;	//support MCS 0~7
 		RegHTSuppRateSets[1] = 0xFF;	//support MCS 8~15
 		RegHTSuppRateSets[4] = 0x01;	//support MCS 32
 	}
 }
+
 /********************************************************************************************************************
  *function:  initialize Bss HT structure(struct PBSS_HT)
  *   input:  PBSS_HT pBssHT //to be initialized
@@ -1140,7 +1114,6 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 ********************************************************************************************************************/
 void HTInitializeBssDesc(PBSS_HT pBssHT)
 {
-
 	pBssHT->bdSupportHT = false;
 	memset(pBssHT->bdHTCapBuf, 0, sizeof(pBssHT->bdHTCapBuf));
 	pBssHT->bdHTCapLen = 0;
@@ -1152,6 +1125,7 @@ void HTInitializeBssDesc(PBSS_HT pBssHT)
 	pBssHT->bdRT2RTAggregation = false;
 	pBssHT->bdRT2RTLongSlotTime = false;
 }
+
 /********************************************************************************************************************
  *function:  initialize Bss HT structure(struct PBSS_HT)
  *   input:  struct ieee80211_device	*ieee
@@ -1213,7 +1187,6 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_ALL_2SS;
 
-
 		bIOTAction = HTIOTActIsDisableEDCATurbo(ieee, pNetwork->bssid);
 		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_EDCA_TURBO;
@@ -1225,8 +1198,6 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 		bIOTAction = HTIOTActIsCCDFsync(pNetwork->bssid);
 		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_CDD_FSYNC;
-
-
 	} else {
 		pHTInfo->bCurrentHTSupport = false;
 		pHTInfo->bCurrentRT2RTAggregation = false;
@@ -1234,7 +1205,6 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 
 		pHTInfo->IOTAction = 0;
 	}
-
 }
 
 void HTUpdateSelfAndPeerSetting(struct ieee80211_device *ieee,	struct ieee80211_network *pNetwork)
@@ -1287,8 +1257,6 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
 	if (!pHTInfo->bRegBW40MHz)
 		return;
 
-
-
 	// To reduce dummy operation
 //	if((pHTInfo->bCurBW40MHz==false && Bandwidth==HT_CHANNEL_WIDTH_20) ||
 //	   (pHTInfo->bCurBW40MHz==true && Bandwidth==HT_CHANNEL_WIDTH_20_40 && Offset==pHTInfo->CurSTAExtChnlOffset))
-- 
2.17.0
