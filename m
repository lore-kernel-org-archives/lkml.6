Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELtLcejJ7/LRbDeltJHpVr/7FrXxf0j8GwrggfswYz7/5ixo/ZGp7s8fPRWcIRRA0brycPA6
ARC-Seal: i=1; a=rsa-sha256; t=1522140100; cv=none;
        d=google.com; s=arc-20160816;
        b=zwlX/y7wGZWpDcZtr/X2Y9kBcD4yD4uVAdOO5ZorcJFaCgZd5QrbFOw7PEKR4iI6jU
         L3T/u0XFJ1lhUUqmwem0PKXYX5ZaBx3nxLXUXxBXCxEMkDw9rlOgh5ceiyJwtrTu1KjL
         1Krl2HVDlAdKPeDah6WJ70nDzO/kpR3IIhKJYdGEpbFipC8E+IVXl2cR2K7lIy3cntqJ
         VX4hURJ9sHUDOeXAEu4ETM9VgeC4juJWNI4xLRW54GQCacCbTWgJ+ArkExgxQk+T83AC
         Px1f3nR/isOY4xYOzE5Uy5wKs5wv73PzVYiAn6iSyCusCwrfPgjD/WxpgNxEx6Q2v7l8
         fCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=gQsTmV/wzxNo1f34YP6Hsd9m+6qcPwN8tGWoS6OzqPE=;
        b=0LwMF/4G9C+WZwiPnWcrDoWsRYotZFNQPckjviDf2FKLcbHRFMHkDp/HxaehCv7GJi
         KvRuPaNruRG4VL0bfw4nGnfq0HIj16VdDNQtTzBY4YOnzIiWbZEaHYANQNLBn7r/mRLG
         hYpnpxll486zLqkDVdnVJMwI0Weo2lmdABRBlyStFk7ThWhjMo8Em2pxaXaTAbzggOrg
         V9paf9Kya+qnGdQi5wEd4P/EWopHb0gb7X5mZvnjgreEKiuR/273lUwRWCvPqguLCCky
         vyPEqRqY78WpQ8A0jyfZpcOBsL6U9wiMfn6S165gDL6DolkjAwlfJtVus1A6kQH0VNtX
         hzCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 22/23] staging: rtl8723bs: Rework 'struct _ODM_Phy_Status_Info_' coding style.
Date: Tue, 27 Mar 2018 01:41:14 -0700
Message-Id: <20180327084115.16129-22-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:8jdEaFX9nS6OxMgu4XtBva6Vz244FtixJ/sl6Cp+hVn5RlFuiV2
 T8SWnMfycoqKxquDShthgHHUEdt/HqDYPku537hmXubH1DPz0cYKgEe7yqOm/inL9e8xpU/
 nOU2/7UYwiJHfwbG4hY9+OiHNPMBLqpyZGve6+2/rl/oULn7TMJWa8/dZRq2Ch5OJMWrOVQ
 NBcGKO9WjSTFmZ9fMiTvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vE3Ni9I79Ps=:PuT5ofWd3H0QJB8p5tvJ2Y
 hyaoTXhQ+BCOKMeLYtn/V16ptKxW8bNbCN5Kk01uxXMf7zENt8Efq0eZkIRZffHAdGx4XwBpI
 /IFLWYenoMLKWSE/wG1QTYE2j8WOVjni4VP0pLymwp6muCsWxxCosVFgGx5sEZnFgs/pxgf8U
 OsYd/Pud6gFHu0zb9iwB3UUcG2gvbDDNYqM33ztzz4g8Syf9anPPwvQGjxkxUPfVJV45O7qdj
 EQEmDif/1CecQh6/uBoMsnIJWUcsGRlgGZpbtly+JOPGxLHrCmtbR9i3ldC6MPCxqaf249VWq
 n94knHiTd09Hm22D5cW/b/OrKKmjnmaSlZZC1fLGvl8qxTtZICvz5OavYe2KoIhakj4ydD/Eb
 yJINbnlfYy8zT/Vjs9En+Zh1a26ELYxkRuRL9FEaaIPS411e6h10kkSA6vb58nwFNioyEMvsZ
 fWzvp3z7qQsOkb8CBcVjQfLCt0k9KQlqs0mrnJ5qHV7Ny5gxd0DbglaiM2lmTpM+96ATFcN8P
 4qqSndlg5+rE/eAU1LjYAg39RHDOe92lA1cn9jpCCcmfH3WfY1AFYUOb0vRwzYx3Br/hf5YbB
 I1tvUxXaLigDGQ57AwKCntrpjbcC+SVGKEtG+y9tK1MZPSkA5VshP6YBaMnbLKQMDpiA55Jui
 eSMum9wU4N4PCY2hGeu08/SKLaaEcpnOGg8PEa/7+HlO9vQjLfvBVooQV+bQpouCf9vFKg/OE
 GXE4BxjnPuaKiOiNPNvNaGcCqjRVocg/r4+vmg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079577812010129?=
X-GMAIL-MSGID: =?utf-8?q?1596079577812010129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Change the typedef'd 'struct _ODM_Phy_Status_Info_' into
'struct odm_phy_info' and change the members to snake case in
order to meet the coding style guidelines.
Members:
* u8 RxPWDBAll            -> rx_pwd_ba11
* u8 SignalQuality        -> signal_quality
* s8 RxMIMOSignalQuality  -> rx_mimo_signal_quality
* u8 RxMIMOEVMdbm         -> rx_mimo_evm_dbm
* u8 RxMIMOSignalStrength -> rx_mimo_signal_strength
* u16 Cfo_short           -> cfo_short
* u16 Cfo_tail            -> cfo_tail
* s8 RxPower              -> rx_power
* s8 RecvSignalPower      -> recv_signal_power
* u8 BTRxRSSIPercentage   -> bt_rx_rssi_percentage
* u8 SignalStrength       -> signal_strength
* s8 RxPwr                -> rx_pwr
* u8 RxSNR                -> rx_snr
* u8 BandWidth            => band_width
* u8 btCoexPwrAdjust      -> bt_coex_pwr_adjust

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/hal_com.c        | 10 +--
 drivers/staging/rtl8723bs/hal/odm.h            | 49 +++++++------
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c   | 98 +++++++++++++-------------
 drivers/staging/rtl8723bs/hal/odm_HWConfig.h   |  2 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c |  3 +-
 drivers/staging/rtl8723bs/include/rtw_mlme.h   |  2 +-
 drivers/staging/rtl8723bs/include/rtw_recv.h   | 10 +--
 7 files changed, 90 insertions(+), 84 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index dec887a5b338..1cef1d77977c 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -1680,18 +1680,18 @@ void rtw_store_phy_info(struct adapter *padapter, union recv_frame *prframe)
 	struct hal_com_data *pHalData =  GET_HAL_DATA(padapter);
 	struct rx_pkt_attrib *pattrib = &prframe->u.hdr.attrib;
 
-	PODM_PHY_INFO_T pPhyInfo  = (PODM_PHY_INFO_T)(&pattrib->phy_info);
+	struct odm_phy_info *pPhyInfo  = (PODM_PHY_INFO_T)(&pattrib->phy_info);
 	struct rx_raw_rssi *psample_pkt_rssi = &padapter->recvpriv.raw_rssi_info;
 
 	psample_pkt_rssi->data_rate = pattrib->data_rate;
 	isCCKrate = pattrib->data_rate <= DESC_RATE11M;
 
-	psample_pkt_rssi->pwdball = pPhyInfo->RxPWDBAll;
-	psample_pkt_rssi->pwr_all = pPhyInfo->RecvSignalPower;
+	psample_pkt_rssi->pwdball = pPhyInfo->rx_pwd_ba11;
+	psample_pkt_rssi->pwr_all = pPhyInfo->recv_signal_power;
 
 	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
-		psample_pkt_rssi->mimo_singal_strength[rf_path] = pPhyInfo->RxMIMOSignalStrength[rf_path];
-		psample_pkt_rssi->mimo_singal_quality[rf_path] = pPhyInfo->RxMIMOSignalQuality[rf_path];
+		psample_pkt_rssi->mimo_singal_strength[rf_path] = pPhyInfo->rx_mimo_signal_strength[rf_path];
+		psample_pkt_rssi->mimo_singal_quality[rf_path] = pPhyInfo->rx_mimo_signal_quality[rf_path];
 		if (!isCCKrate) {
 			psample_pkt_rssi->ofdm_pwr[rf_path] = pPhyInfo->RxPwr[rf_path];
 			psample_pkt_rssi->ofdm_snr[rf_path] = pPhyInfo->RxSNR[rf_path];
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 7c13a9314a22..175c77b11bf9 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -233,33 +233,38 @@ typedef struct _ODM_RATE_ADAPTIVE {
 #define IQK_THRESHOLD			8
 #define DPK_THRESHOLD			4
 
-typedef struct _ODM_Phy_Status_Info_ {
-	/*  */
-	/*  Be care, if you want to add any element please insert between */
-	/*  RxPWDBAll & SignalStrength. */
-	/*  */
-	u8 RxPWDBAll;
+struct odm_phy_info {
+	/*
+	 *  Be care, if you want to add any element, please insert it between
+	 *  rx_pwd_ball and signal_strength.
+	 */
+	u8 rx_pwd_ba11;
 
-	u8 SignalQuality;			/*  in 0-100 index. */
-	s8 RxMIMOSignalQuality[4];	/* per-path's EVM */
-	u8 RxMIMOEVMdbm[4];		/* per-path's EVM dbm */
+	u8 signal_quality;             /* in 0-100 index. */
+	s8 rx_mimo_signal_quality[4];  /* per-path's EVM */
+	u8 rx_mimo_evm_dbm[4];         /* per-path's EVM dbm */
 
-	u8 RxMIMOSignalStrength[4];/*  in 0~100 index */
+	u8 rx_mimo_signal_strength[4]; /* in 0~100 index */
 
-	u16 Cfo_short[4];			/*  per-path's Cfo_short */
-	u16 Cfo_tail[4];			/*  per-path's Cfo_tail */
+	u16 cfo_short[4];              /* per-path's Cfo_short */
+	u16 cfo_tail[4];               /* per-path's Cfo_tail */
 
-	s8 RxPower;				/*  in dBm Translate from PWdB */
-	s8 RecvSignalPower;		/*  Real power in dBm for this packet, no beautification and aggregation. Keep this raw info to be used for the other procedures. */
-	u8 BTRxRSSIPercentage;
-	u8 SignalStrength;			/*  in 0-100 index. */
+	s8 rx_power;                   /* in dBm Translate from PWdB */
 
-	s8 RxPwr[4];				/* per-path's pwdb */
+	/*
+	 * Real power in dBm for this packet, no beautification and
+	 * aggregation. Keep this raw info to be used for the other procedures.
+	 */
+	s8 recv_signal_power;
+	u8 bt_rx_rssi_percentage;
+	u8 signal_strength;	       /* in 0-100 index. */
 
-	u8 RxSNR[4];				/* per-path's SNR */
-	u8 BandWidth;
-	u8 btCoexPwrAdjust;
-} ODM_PHY_INFO_T, *PODM_PHY_INFO_T;
+	s8 rx_pwr[4];                  /* per-path's pwdb */
+
+	u8 rx_snr[4];                  /* per-path's SNR */
+	u8 band_width;
+	u8 bt_coex_pwr_adjust;
+};
 
 
 struct odm_packet_info {
@@ -1415,7 +1420,7 @@ bool ODM_RAStateCheck(
 void ODM_SwAntDivChkPerPktRssi(
 	PDM_ODM_T pDM_Odm,
 	u8 StationID,
-	PODM_PHY_INFO_T pPhyInfo
+	struct odm_phy_info *pPhyInfo
 );
 
 u32 ODM_Get_Rate_Bitmap(
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index b3f4c237e903..9e161f080c57 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -91,7 +91,7 @@ static u8 odm_EVMdbToPercentage(s8 Value)
 
 static void odm_RxPhyStatus92CSeries_Parsing(
 	PDM_ODM_T pDM_Odm,
-	PODM_PHY_INFO_T pPhyInfo,
+	struct odm_phy_info *pPhyInfo,
 	u8 *pPhyStatus,
 	struct odm_packet_info *pPktinfo
 )
@@ -107,8 +107,8 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 	PPHY_STATUS_RPT_8192CD_T pPhyStaRpt = (PPHY_STATUS_RPT_8192CD_T)pPhyStatus;
 
 	isCCKrate = pPktinfo->data_rate <= DESC_RATE11M;
-	pPhyInfo->RxMIMOSignalQuality[ODM_RF_PATH_A] = -1;
-	pPhyInfo->RxMIMOSignalQuality[ODM_RF_PATH_B] = -1;
+	pPhyInfo->rx_mimo_signal_quality[ODM_RF_PATH_A] = -1;
+	pPhyInfo->rx_mimo_signal_quality[ODM_RF_PATH_B] = -1;
 
 
 	if (isCCKrate) {
@@ -137,9 +137,9 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 		if (PWDB_ALL > 100)
 			PWDB_ALL = 100;
 
-		pPhyInfo->RxPWDBAll = PWDB_ALL;
-		pPhyInfo->BTRxRSSIPercentage = PWDB_ALL;
-		pPhyInfo->RecvSignalPower = rx_pwr_all;
+		pPhyInfo->rx_pwd_ba11 = PWDB_ALL;
+		pPhyInfo->bt_rx_rssi_percentage = PWDB_ALL;
+		pPhyInfo->recv_signal_power = rx_pwr_all;
 		/*  */
 		/*  (3) Get Signal Quality (EVM) */
 		/*  */
@@ -147,7 +147,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 		{
 			u8 SQ, SQ_rpt;
 
-			if (pPhyInfo->RxPWDBAll > 40 && !pDM_Odm->bInHctTest)
+			if (pPhyInfo->rx_pwd_ba11 > 40 && !pDM_Odm->bInHctTest)
 				SQ = 100;
 			else {
 				SQ_rpt = pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all;
@@ -162,9 +162,9 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 			}
 
 			/* DbgPrint("cck SQ = %d\n", SQ); */
-			pPhyInfo->SignalQuality = SQ;
-			pPhyInfo->RxMIMOSignalQuality[ODM_RF_PATH_A] = SQ;
-			pPhyInfo->RxMIMOSignalQuality[ODM_RF_PATH_B] = -1;
+			pPhyInfo->signal_quality = SQ;
+			pPhyInfo->rx_mimo_signal_quality[ODM_RF_PATH_A] = SQ;
+			pPhyInfo->rx_mimo_signal_quality[ODM_RF_PATH_B] = -1;
 		}
 	} else { /* is OFDM rate */
 		pDM_Odm->PhyDbgInfo.NumQryPhyStatusOFDM++;
@@ -183,17 +183,17 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 			rx_pwr[i] = ((pPhyStaRpt->path_agc[i].gain&0x3F)*2) - 110;
 
 
-			pPhyInfo->RxPwr[i] = rx_pwr[i];
+			pPhyInfo->rx_pwr[i] = rx_pwr[i];
 
 			/* Translate DBM to percentage. */
 			RSSI = odm_QueryRxPwrPercentage(rx_pwr[i]);
 			total_rssi += RSSI;
 			/* RT_DISP(FRX, RX_PHY_SS, ("RF-%d RXPWR =%x RSSI =%d\n", i, rx_pwr[i], RSSI)); */
 
-			pPhyInfo->RxMIMOSignalStrength[i] = (u8) RSSI;
+			pPhyInfo->rx_mimo_signal_strength[i] = (u8) RSSI;
 
 			/* Get Rx snr value in DB */
-			pPhyInfo->RxSNR[i] = pDM_Odm->PhyDbgInfo.RxSNRdB[i] = (s32)(pPhyStaRpt->path_rxsnr[i]/2);
+			pPhyInfo->rx_snr[i] = pDM_Odm->PhyDbgInfo.RxSNRdB[i] = (s32)(pPhyStaRpt->path_rxsnr[i]/2);
 		}
 
 
@@ -205,11 +205,11 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 		PWDB_ALL_BT = PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
 		/* RT_DISP(FRX, RX_PHY_SS, ("PWDB_ALL =%d\n", PWDB_ALL)); */
 
-		pPhyInfo->RxPWDBAll = PWDB_ALL;
-		/* ODM_RT_TRACE(pDM_Odm, ODM_COMP_RSSI_MONITOR, ODM_DBG_LOUD, ("ODM OFDM RSSI =%d\n", pPhyInfo->RxPWDBAll)); */
-		pPhyInfo->BTRxRSSIPercentage = PWDB_ALL_BT;
-		pPhyInfo->RxPower = rx_pwr_all;
-		pPhyInfo->RecvSignalPower = rx_pwr_all;
+		pPhyInfo->rx_pwd_ba11 = PWDB_ALL;
+		/* ODM_RT_TRACE(pDM_Odm, ODM_COMP_RSSI_MONITOR, ODM_DBG_LOUD, ("ODM OFDM RSSI =%d\n", pPhyInfo->rx_pwd_ba11)); */
+		pPhyInfo->bt_rx_rssi_percentage = PWDB_ALL_BT;
+		pPhyInfo->rx_power = rx_pwr_all;
+		pPhyInfo->recv_signal_power = rx_pwr_all;
 
 		{/* pMgntInfo->CustomerID != RT_CID_819x_Lenovo */
 			/*  */
@@ -232,9 +232,9 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 				/* if (pPktinfo->bPacketMatchBSSID) */
 				{
 					if (i == ODM_RF_PATH_A) /*  Fill value in RFD, Get the first spatial stream only */
-						pPhyInfo->SignalQuality = (u8)(EVM & 0xff);
+						pPhyInfo->signal_quality = (u8)(EVM & 0xff);
 
-					pPhyInfo->RxMIMOSignalQuality[i] = (u8)(EVM & 0xff);
+					pPhyInfo->rx_mimo_signal_quality[i] = (u8)(EVM & 0xff);
 				}
 			}
 		}
@@ -249,25 +249,25 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 #ifdef CONFIG_SKIP_SIGNAL_SCALE_MAPPING
 		pPhyInfo->SignalStrength = (u8)PWDB_ALL;
 #else
-		pPhyInfo->SignalStrength = (u8)(odm_SignalScaleMapping(pDM_Odm, PWDB_ALL));/* PWDB_ALL; */
+		pPhyInfo->signal_strength = (u8)(odm_SignalScaleMapping(pDM_Odm, PWDB_ALL));/* PWDB_ALL; */
 #endif
 	} else {
 		if (rf_rx_num != 0) {
 #ifdef CONFIG_SKIP_SIGNAL_SCALE_MAPPING
 			total_rssi /= rf_rx_num;
-			pPhyInfo->SignalStrength = (u8)total_rssi;
+			pPhyInfo->signal_strength = (u8)total_rssi;
 #else
-			pPhyInfo->SignalStrength = (u8)(odm_SignalScaleMapping(pDM_Odm, total_rssi /= rf_rx_num));
+			pPhyInfo->signal_strength = (u8)(odm_SignalScaleMapping(pDM_Odm, total_rssi /= rf_rx_num));
 #endif
 		}
 	}
 
-	/* DbgPrint("isCCKrate = %d, pPhyInfo->RxPWDBAll = %d, pPhyStaRpt->cck_agc_rpt_ofdm_cfosho_a = 0x%x\n", */
-		/* isCCKrate, pPhyInfo->RxPWDBAll, pPhyStaRpt->cck_agc_rpt_ofdm_cfosho_a); */
+	/* DbgPrint("isCCKrate = %d, pPhyInfo->rx_pwd_ba11 = %d, pPhyStaRpt->cck_agc_rpt_ofdm_cfosho_a = 0x%x\n", */
+		/* isCCKrate, pPhyInfo->rx_pwd_ba11, pPhyStaRpt->cck_agc_rpt_ofdm_cfosho_a); */
 }
 
 static void odm_Process_RSSIForDM(
-	PDM_ODM_T pDM_Odm, PODM_PHY_INFO_T pPhyInfo, struct odm_packet_info *pPktinfo
+	PDM_ODM_T pDM_Odm, struct odm_phy_info *pPhyInfo, struct odm_packet_info *pPktinfo
 )
 {
 
@@ -310,25 +310,25 @@ static void odm_Process_RSSIForDM(
 	if (pPktinfo->to_self || pPktinfo->is_beacon) {
 
 		if (!isCCKrate) { /* ofdm rate */
-			if (pPhyInfo->RxMIMOSignalStrength[ODM_RF_PATH_B] == 0) {
-				RSSI_Ave = pPhyInfo->RxMIMOSignalStrength[ODM_RF_PATH_A];
-				pDM_Odm->RSSI_A = pPhyInfo->RxMIMOSignalStrength[ODM_RF_PATH_A];
+			if (pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_B] == 0) {
+				RSSI_Ave = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A];
+				pDM_Odm->RSSI_A = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A];
 				pDM_Odm->RSSI_B = 0;
 			} else {
-				/* DbgPrint("pRfd->Status.RxMIMOSignalStrength[0] = %d, pRfd->Status.RxMIMOSignalStrength[1] = %d\n", */
-					/* pRfd->Status.RxMIMOSignalStrength[0], pRfd->Status.RxMIMOSignalStrength[1]); */
-				pDM_Odm->RSSI_A =  pPhyInfo->RxMIMOSignalStrength[ODM_RF_PATH_A];
-				pDM_Odm->RSSI_B = pPhyInfo->RxMIMOSignalStrength[ODM_RF_PATH_B];
+				/* DbgPrint("pRfd->Status.rx_mimo_signal_strength[0] = %d, pRfd->Status.rx_mimo_signal_strength[1] = %d\n", */
+					/* pRfd->Status.rx_mimo_signal_strength[0], pRfd->Status.rx_mimo_signal_strength[1]); */
+				pDM_Odm->RSSI_A =  pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A];
+				pDM_Odm->RSSI_B = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_B];
 
 				if (
-					pPhyInfo->RxMIMOSignalStrength[ODM_RF_PATH_A] >
-					pPhyInfo->RxMIMOSignalStrength[ODM_RF_PATH_B]
+					pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A] >
+					pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_B]
 				) {
-					RSSI_max = pPhyInfo->RxMIMOSignalStrength[ODM_RF_PATH_A];
-					RSSI_min = pPhyInfo->RxMIMOSignalStrength[ODM_RF_PATH_B];
+					RSSI_max = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A];
+					RSSI_min = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_B];
 				} else {
-					RSSI_max = pPhyInfo->RxMIMOSignalStrength[ODM_RF_PATH_B];
-					RSSI_min = pPhyInfo->RxMIMOSignalStrength[ODM_RF_PATH_A];
+					RSSI_max = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_B];
+					RSSI_min = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A];
 				}
 
 				if ((RSSI_max-RSSI_min) < 3)
@@ -343,9 +343,9 @@ static void odm_Process_RSSIForDM(
 
 			/* 1 Process OFDM RSSI */
 			if (UndecoratedSmoothedOFDM <= 0)	/*  initialize */
-				UndecoratedSmoothedOFDM = pPhyInfo->RxPWDBAll;
+				UndecoratedSmoothedOFDM = pPhyInfo->rx_pwd_ba11;
 			else {
-				if (pPhyInfo->RxPWDBAll > (u32)UndecoratedSmoothedOFDM) {
+				if (pPhyInfo->rx_pwd_ba11 > (u32)UndecoratedSmoothedOFDM) {
 					UndecoratedSmoothedOFDM =
 							((UndecoratedSmoothedOFDM*(Rx_Smooth_Factor-1)) +
 							RSSI_Ave)/Rx_Smooth_Factor;
@@ -360,23 +360,23 @@ static void odm_Process_RSSIForDM(
 			pEntry->rssi_stat.PacketMap = (pEntry->rssi_stat.PacketMap<<1) | BIT0;
 
 		} else {
-			RSSI_Ave = pPhyInfo->RxPWDBAll;
-			pDM_Odm->RSSI_A = (u8) pPhyInfo->RxPWDBAll;
+			RSSI_Ave = pPhyInfo->rx_pwd_ba11;
+			pDM_Odm->RSSI_A = (u8) pPhyInfo->rx_pwd_ba11;
 			pDM_Odm->RSSI_B = 0;
 
 			/* 1 Process CCK RSSI */
 			if (UndecoratedSmoothedCCK <= 0)	/*  initialize */
-				UndecoratedSmoothedCCK = pPhyInfo->RxPWDBAll;
+				UndecoratedSmoothedCCK = pPhyInfo->rx_pwd_ba11;
 			else {
-				if (pPhyInfo->RxPWDBAll > (u32)UndecoratedSmoothedCCK) {
+				if (pPhyInfo->rx_pwd_ba11 > (u32)UndecoratedSmoothedCCK) {
 					UndecoratedSmoothedCCK =
 							((UndecoratedSmoothedCCK*(Rx_Smooth_Factor-1)) +
-							pPhyInfo->RxPWDBAll)/Rx_Smooth_Factor;
+							pPhyInfo->rx_pwd_ba11)/Rx_Smooth_Factor;
 					UndecoratedSmoothedCCK = UndecoratedSmoothedCCK + 1;
 				} else {
 					UndecoratedSmoothedCCK =
 							((UndecoratedSmoothedCCK*(Rx_Smooth_Factor-1)) +
-							pPhyInfo->RxPWDBAll)/Rx_Smooth_Factor;
+							pPhyInfo->rx_pwd_ba11)/Rx_Smooth_Factor;
 				}
 			}
 			pEntry->rssi_stat.PacketMap = pEntry->rssi_stat.PacketMap<<1;
@@ -422,7 +422,7 @@ static void odm_Process_RSSIForDM(
 /*  */
 static void ODM_PhyStatusQuery_92CSeries(
 	PDM_ODM_T pDM_Odm,
-	PODM_PHY_INFO_T pPhyInfo,
+	struct odm_phy_info *pPhyInfo,
 	u8 *pPhyStatus,
 	struct odm_packet_info *pPktinfo
 )
@@ -436,7 +436,7 @@ static void ODM_PhyStatusQuery_92CSeries(
 
 void ODM_PhyStatusQuery(
 	PDM_ODM_T pDM_Odm,
-	PODM_PHY_INFO_T pPhyInfo,
+	struct odm_phy_info *pPhyInfo,
 	u8 *pPhyStatus,
 	struct odm_packet_info *pPktinfo
 )
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.h b/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
index ff0373eba495..fdb4f8579ff9 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
@@ -131,7 +131,7 @@ typedef struct _Phy_Status_Rpt_8812 {
 
 void ODM_PhyStatusQuery(
 	PDM_ODM_T pDM_Odm,
-	PODM_PHY_INFO_T pPhyInfo,
+	struct odm_phy_info *pPhyInfo,
 	u8 *pPhyStatus,
 	struct odm_packet_info *pPktinfo
 );
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 6280a2e21dc2..5d5cd4d01156 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -90,7 +90,8 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	struct adapter *padapter = precvframe->u.hdr.adapter;
 	struct rx_pkt_attrib *pattrib = &precvframe->u.hdr.attrib;
 	struct hal_com_data *p_hal_data = GET_HAL_DATA(padapter);
-	PODM_PHY_INFO_T p_phy_info = (PODM_PHY_INFO_T)(&pattrib->phy_info);
+	struct odm_phy_info *p_phy_info =
+		(struct odm_phy_info *)(&pattrib->phy_info);
 
 	u8 *wlanhdr;
 	u8 *my_bssid;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index 00b3d92c9f51..2e4f12b54929 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -299,7 +299,7 @@ struct wifidirect_info{
 
 struct tdls_ss_record{	/* signal strength record */
 	u8 macaddr[ETH_ALEN];
-	u8 RxPWDBAll;
+	u8 rx_pwd_ba11;
 	u8 is_tdls_sta;	/*  true: direct link sta, false: else */
 };
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index 71039ca79e4b..d4986f5685c5 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -99,20 +99,20 @@ struct signal_stat {
 };
 
 struct phy_info {
-	u8 RxPWDBAll;
+	u8 rx_pwd_ba11;
 
 	u8 SignalQuality;	 /*  in 0-100 index. */
-	s8		RxMIMOSignalQuality[4];	/* per-path's EVM */
+	s8		rx_mimo_signal_quality[4];	/* per-path's EVM */
 	u8 RxMIMOEVMdbm[4];		/* per-path's EVM dbm */
 
-	u8 RxMIMOSignalStrength[4];/*  in 0~100 index */
+	u8 rx_mimo_signal_strength[4];/*  in 0~100 index */
 
 	u16 	Cfo_short[4];			/*  per-path's Cfo_short */
 	u16 	Cfo_tail[4];			/*  per-path's Cfo_tail */
 
 	s8		RxPower; /*  in dBm Translate from PWdB */
 	s8		RecvSignalPower;/*  Real power in dBm for this packet, no beautification and aggregation. Keep this raw info to be used for the other procedures. */
-	u8 BTRxRSSIPercentage;
+	u8 bt_rx_rssi_percentage;
 	u8 SignalStrength; /*  in 0-100 index. */
 
 	s8		RxPwr[4];				/* per-path's pwdb */
@@ -187,7 +187,7 @@ struct rx_pkt_attrib	{
 	u8 signal_qual;
 	s8	rx_mimo_signal_qual[2];
 	u8 signal_strength;
-	u32 RxPWDBAll;
+	u32 rx_pwd_ba11;
 	s32	RecvSignalPower;
 */
 	struct phy_info phy_info;
-- 
2.16.3
