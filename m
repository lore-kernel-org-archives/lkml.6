Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D62C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79616208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79616208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tamalin.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754956AbeFQFcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:32:11 -0400
Received: from mout.perfora.net ([74.208.4.197]:37501 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932132AbeFQFbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:31:11 -0400
Received: from kahja.local ([73.231.184.107]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LnAbb-1g8hm00kST-00hLb1;
 Sun, 17 Jun 2018 07:30:57 +0200
From:   Quytelda Kahja <quytelda@tamalin.org>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 01/11] staging: rtl8723bs: Clean up whitespace in 'PHY_GetTxPowerLimit()'.
Date:   Sat, 16 Jun 2018 22:30:30 -0700
Message-Id: <20180617053040.5903-1-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:NrW9w0SPSqMpwTK7VRQgR80+nPrtBpXK8/T1IDxZDagTUFN2QGx
 sBluOvvEALZ06RuC8NLsu6EJWLeO6XubsKgjZWaFe44LwK5VFE7Po+M7fA/ktOs5inD0vdf
 9tqOofTRiRUzkmAqkGXPv8m8n5hPyoeH9dy1cy7NleFv3ELOftCbUhn8Y2n5/D2Mwan8H+T
 E/48idx1SiVqOzYBgTMqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IfjkiAzSd8c=:c3OEM9isi/CPVA2cohZb7C
 vbt1A1qPOjnekZnJI5Wq+0WBatkOUV8O6C4neTtiryyvjoSs/KaPMO8ejCCRkq5SDIUQ4RmQb
 /gmfCez8KqXHdfRx/yuw9wpCYQI/Xcmw+tWipKKLwtNwiRaPxOVefNZCDzyB8JfBzb8xaLhjf
 cAaztU7VYHQNoF51mNwKmmp0glW/21BdiPAlwj/zUTrW+XNlld5X0/F4S8Hi8KoZ1xZpWp7nX
 2PD1oSsved6MnHLCKCQ6fMYu/akrMZqBUTFGWTOpPjeVJgA0RvseDLtba6cGGCsVIN+CHmkRk
 Dl7QUh6xEFoJxrMHcVaMMz64PlwTNV/sRc4w++7NI5XkFItADIIuzLhSk0eKR0QLzGDKKYy21
 nCMxz8crq7PzFzILjjbYj6CIePs+oT2+vRLj/bDX5758YSdhUOcVsb/D6yx/GXqQnFKObrJhz
 j+oBfjbsdKJTu3XpbKv1pIkkVCUrP/Nj3Jf1a1xZSsBaJySsMokS4eoKaC6YvX3vasl6P3+oe
 6VeXNVt2c1szyylpodYTauB1VKXg5gWWM57zuu+Qo0tKAAWUsWo8sRlDqNiiHhl+h5AsB/dch
 WkrKTQRUxXxdzKT5EH4FVnVLLcvz2Fy2w3uD+utOKLEB2EPZbmJlx7v5jpNBFY0xckf7eLR5D
 Rs9+WfCBLCk4WaBy8PacJq19EMC7mFcgu5z9T/nEUs6+Excb5UUf8Snil1w4lU8wO0n8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap lines longer than 80 characters where possible, delete double
newlines, and fix alignment per the kernel coding style guidelines.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 110 ++++++++++--------
 1 file changed, 59 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 3922d0308a81..5f727a7c16fd 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1612,46 +1612,45 @@ static s8 phy_GetChannelIndexOfTxPowerLimit(u8 Band, u8 Channel)
 	return channelIndex;
 }
 
-s8 PHY_GetTxPowerLimit(
-	struct adapter *Adapter,
-	u32 RegPwrTblSel,
-	enum BAND_TYPE Band,
-	enum CHANNEL_WIDTH Bandwidth,
-	u8 RfPath,
-	u8 DataRate,
-	u8 Channel
-)
+s8 PHY_GetTxPowerLimit(struct adapter *Adapter, u32 RegPwrTblSel,
+		       enum BAND_TYPE Band, enum CHANNEL_WIDTH Bandwidth,
+		       u8 RfPath, u8 DataRate, u8 Channel)
 {
-	struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
-	s16	band = -1, regulation = -1, bandwidth = -1, rateSection = -1, channel = -1;
+	s16 band        = -1;
+	s16 regulation  = -1;
+	s16 bandwidth   = -1;
+	s16 rateSection = -1;
+	s16 channel     = -1;
 	s8 powerLimit = MAX_POWER_INDEX;
+	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-	if ((Adapter->registrypriv.RegEnableTxPowerLimit == 2 && pHalData->EEPROMRegulatory != 1) ||
-		   Adapter->registrypriv.RegEnableTxPowerLimit == 0)
+	if (((Adapter->registrypriv.RegEnableTxPowerLimit == 2) &&
+	     (pHalData->EEPROMRegulatory != 1)) ||
+	    (Adapter->registrypriv.RegEnableTxPowerLimit == 0))
 		return MAX_POWER_INDEX;
 
 	switch (Adapter->registrypriv.RegPwrTblSel) {
 	case 1:
-			regulation = TXPWR_LMT_ETSI;
-			break;
+		regulation = TXPWR_LMT_ETSI;
+		break;
 	case 2:
-			regulation = TXPWR_LMT_MKK;
-			break;
+		regulation = TXPWR_LMT_MKK;
+		break;
 	case 3:
-			regulation = TXPWR_LMT_FCC;
-			break;
-
+		regulation = TXPWR_LMT_FCC;
+		break;
 	case 4:
-			regulation = TXPWR_LMT_WW;
-			break;
-
+		regulation = TXPWR_LMT_WW;
+		break;
 	default:
-			regulation = (Band == BAND_ON_2_4G) ? pHalData->Regulation2_4G : pHalData->Regulation5G;
-			break;
+		regulation = (Band == BAND_ON_2_4G) ?
+			pHalData->Regulation2_4G :
+			pHalData->Regulation5G;
+		break;
 	}
 
-	/* DBG_871X("pMgntInfo->RegPwrTblSel %d, final regulation %d\n", Adapter->registrypriv.RegPwrTblSel, regulation); */
-
+	/* DBG_871X("pMgntInfo->RegPwrTblSel %d, final regulation %d\n", */
+	/*         Adapter->registrypriv.RegPwrTblSel, regulation); */
 
 	if (Band == BAND_ON_2_4G)
 		band = 0;
@@ -1730,8 +1729,8 @@ s8 PHY_GetTxPowerLimit(
 		break;
 	}
 
-	if (Band == BAND_ON_5G  && rateSection == 0)
-			DBG_871X("Wrong rate 0x%x: No CCK in 5G Band\n", DataRate);
+	if (Band == BAND_ON_5G && rateSection == 0)
+                DBG_871X("Wrong rate 0x%x: No CCK in 5G Band\n", DataRate);
 
 	/*  workaround for wrong index combination to obtain tx power limit, */
 	/*  OFDM only exists in BW 20M */
@@ -1745,22 +1744,26 @@ s8 PHY_GetTxPowerLimit(
 
 	/*  workaround for wrong indxe combination to obtain tx power limit, */
 	/*  HT on 80M will reference to HT on 40M */
-	if ((rateSection == 2 || rateSection == 3) && Band == BAND_ON_5G && bandwidth == 2) {
+	if ((rateSection == 2 || rateSection == 3) &&
+	    Band == BAND_ON_5G && bandwidth == 2) {
 		bandwidth = 1;
 	}
 
 	if (Band == BAND_ON_2_4G)
-		channel = phy_GetChannelIndexOfTxPowerLimit(BAND_ON_2_4G, Channel);
+		channel = phy_GetChannelIndexOfTxPowerLimit(BAND_ON_2_4G,
+							    Channel);
 	else if (Band == BAND_ON_5G)
-		channel = phy_GetChannelIndexOfTxPowerLimit(BAND_ON_5G, Channel);
+		channel = phy_GetChannelIndexOfTxPowerLimit(BAND_ON_5G,
+							    Channel);
 	else if (Band == BAND_ON_BOTH) {
 		/*  BAND_ON_BOTH don't care temporarily */
 	}
 
 	if (band == -1 || regulation == -1 || bandwidth == -1 ||
-	     rateSection == -1 || channel == -1) {
+	    rateSection == -1 || channel == -1) {
 		/* DBG_871X("Wrong index value to access power limit table [band %d][regulation %d][bandwidth %d][rf_path %d][rate_section %d][chnlGroup %d]\n", */
-		/*	  band, regulation, bandwidth, RfPath, rateSection, channelGroup); */
+		/*         band, regulation, bandwidth, RfPath, */
+		/*         rateSection, channelGroup); */
 
 		return MAX_POWER_INDEX;
 	}
@@ -1768,18 +1771,26 @@ s8 PHY_GetTxPowerLimit(
 	if (Band == BAND_ON_2_4G) {
 		s8 limits[10] = {0}; u8 i = 0;
 		for (i = 0; i < MAX_REGULATION_NUM; i++)
-			limits[i] = pHalData->TxPwrLimit_2_4G[i][bandwidth][rateSection][channel][RfPath];
+			limits[i] = pHalData->TxPwrLimit_2_4G[i][bandwidth]
+							     [rateSection]
+							     [channel][RfPath];
 
-		powerLimit = (regulation == TXPWR_LMT_WW) ? phy_GetWorldWideLimit(limits) :
-			pHalData->TxPwrLimit_2_4G[regulation][bandwidth][rateSection][channel][RfPath];
+		powerLimit = (regulation == TXPWR_LMT_WW) ?
+			phy_GetWorldWideLimit(limits) :
+			pHalData->TxPwrLimit_2_4G[regulation][bandwidth]
+						 [rateSection][channel][RfPath];
 
 	} else if (Band == BAND_ON_5G) {
 		s8 limits[10] = {0}; u8 i = 0;
 		for (i = 0; i < MAX_REGULATION_NUM; ++i)
-			limits[i] = pHalData->TxPwrLimit_5G[i][bandwidth][rateSection][channel][RfPath];
-
-		powerLimit = (regulation == TXPWR_LMT_WW) ? phy_GetWorldWideLimit(limits) :
-			pHalData->TxPwrLimit_5G[regulation][bandwidth][rateSection][channel][RfPath];
+			limits[i] = pHalData->TxPwrLimit_5G[i][bandwidth]
+							   [rateSection]
+							   [channel][RfPath];
+
+		powerLimit = (regulation == TXPWR_LMT_WW) ?
+			phy_GetWorldWideLimit(limits) :
+			pHalData->TxPwrLimit_5G[regulation][bandwidth]
+					       [rateSection][channel][RfPath];
 	} else
 		DBG_871X("No power limit table of the specified band\n");
 
@@ -1789,22 +1800,20 @@ s8 PHY_GetTxPowerLimit(
 	if (Band == BAND_ON_5G && powerLimit == MAX_POWER_INDEX) {
 		if (bandwidth == 0 || bandwidth == 1) {
 			RT_TRACE(COMP_INIT, DBG_LOUD, ("No power limit table of the specified band %d, bandwidth %d, ratesection %d, rf path %d\n",
-					  band, bandwidth, rateSection, RfPath));
+				 band, bandwidth,
+				 rateSection, RfPath));
 			if (rateSection == 2)
-				powerLimit = pHalData->TxPwrLimit_5G[regulation]
-										[bandwidth][4][channelGroup][RfPath];
+				powerLimit = pHalData->TxPwrLimit_5G[regulation][bandwidth][4][channelGroup][RfPath];
 			else if (rateSection == 4)
-				powerLimit = pHalData->TxPwrLimit_5G[regulation]
-										[bandwidth][2][channelGroup][RfPath];
+				powerLimit = pHalData->TxPwrLimit_5G[regulation][bandwidth][2][channelGroup][RfPath];
 			else if (rateSection == 3)
-				powerLimit = pHalData->TxPwrLimit_5G[regulation]
-										[bandwidth][5][channelGroup][RfPath];
+				powerLimit = pHalData->TxPwrLimit_5G[regulation][bandwidth][5][channelGroup][RfPath];
 			else if (rateSection == 5)
-				powerLimit = pHalData->TxPwrLimit_5G[regulation]
-										[bandwidth][3][channelGroup][RfPath];
+				powerLimit = pHalData->TxPwrLimit_5G[regulation][bandwidth][3][channelGroup][RfPath];
 		}
 	}
 	*/
+
 	/* DBG_871X("TxPwrLmt[Regulation %d][Band %d][BW %d][RFPath %d][Rate 0x%x][Chnl %d] = %d\n", */
 	/*		regulation, pHalData->CurrentBandType, Bandwidth, RfPath, DataRate, Channel, powerLimit); */
 	return powerLimit;
@@ -3294,4 +3303,3 @@ void phy_free_filebuf(struct adapter *padapter)
 		vfree(pHalData->rf_tx_pwr_lmt);
 
 }
-
-- 
2.17.1

