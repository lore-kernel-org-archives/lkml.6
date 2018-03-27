Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx49sitE7I3nNEmQrK4v5PNYmqcHYBkg2N1/nbk/+OTHdUyXYASfRsKwgqgkcWieFhKow0Woj
ARC-Seal: i=1; a=rsa-sha256; t=1522140100; cv=none;
        d=google.com; s=arc-20160816;
        b=tab7gVAexUKEf3jiNS9awOUNO2DF5ZXBq5HmqxmgGdi9lfnLKZctbtO+VNkGvwbmYJ
         drsvLUD8oTk7gtWruhuQmM+uRwHvM8zMaUNa8XYOZeFMVgszRzvenj3YKnHm/l5rvNIH
         QTEUgkPyqByFPU/KAErrbHEg/kmhIxKhhB2QRmLom3wT3NozCOQQ+ki+/nW6vXOUsdd7
         aTm0xvxrVVxrpibg+LcyFvsFHmURVgUjQwMiiTpqQ0/AIKVambpegzAXgraDNrH2K/+W
         aHmS3aat1s/bO/6AHnKiHH9g65A5bYOLydGSBO0ly4U7cBbJ922Th0mh7qJCiDYX3/db
         fo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=eJkb1DIC/xOdqfBGsB61WWVI4JHn30tVSkQAdDGx2ug=;
        b=0hki5cL/svpF2m36UFODhMVCmH0kz/pIAzH3d5fUuVmqAXYF6Qy6prGTVI7kt4iWpk
         ayjVHK8Pbe05d5EgMOQz6aejXxCtYX4D5z5lRSE3q9dHip5kp6u1hiRds3RMKsFnecwz
         uvnASOTcKURmV/9fmnyLqKdTj0lYuKIsxR4qs0iuRmGESKXGLdVC9ztmO05LW5d3qJwt
         7V+E8P0R3gv9XwTKjsQ98CIXhh5stjPLparRkJsR8AzzC5nbuI3DruAy+V5OPo+gayoQ
         bAECJwPRL6iqcqJXOPv3tDm5w1Kx5tru3MEd2Up0243Gv8raNtkRYvOj2Z+OQY7jl4XS
         tclg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 23/23] staging: rtl8723bs: Remove unecessary newlines from 'odm.h'.
Date: Tue, 27 Mar 2018 01:41:15 -0700
Message-Id: <20180327084115.16129-23-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:TkWKrynEusxOIbc4oiMQ7KdWeJmQn4WXO9ESJD0g39RcFo0m9R5
 qZG4AHpFCj7/in4+yqUYtc7Rijr+PVOM/QOjOz4/EGbMee8FHdvemJT8nxwJsr9dzX/LSNM
 aufDN5a8zWk5Ij1DhwroPAOR0vu5dvFDU9PkM2wgBPGgvf2tkOPfwRD5NBO8ahVM0+DGxZY
 zRpPW5uG/hh23acVXm+Gg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bMBBooU4mqI=:6fq+696XmfmdHhcwqD7Cp/
 Aqr+uikOJVq6R2riIL1lWavUlz0mYGN3eIpulr4cHuQWQFt/i6ebK85pz0j0pmJb1RI/7brsI
 srmT0MkYgzxjzTbYGBjeYDcLWKbsetmjm6jG5t3YVu2qEZe2Skey8JD6R+n3qSplo9TrSRg7N
 hA6QO36Z8toaUyRxnWN+CwyaZntKajL6DFRRhOBGaHozOSQ5K6xmq5rxswrq86tpFEcgx6WJK
 MkJSeReiRnCFEFYEHnInonZ9qzkwt9+vA7QTShctGGHF9VdbkA+koVDfzfF6GqFq+8lqWkD6a
 Ug91Ye7Ey3MJ7jO8G6osEQNZgux8POor27JTH1iswBHAypJgN+XWi8MzLyYK/C/ZhYV2DvVfW
 ceUqH0Xoc7jal6EoH4rqmMuuQjYTS6F5D2GOwyVlLyonkXflnbcdJXuf1GAw+kzvLCIrv1uDz
 I8i7PlXI9rU27xlnoMDOrW2k4A8h/lroqFdGugGL/uWu0HNmmiMPJu/FYvVOLvA8YB2xTaWMo
 tVzx0oTNoHDjiJlgmr7wdxs+wnAp5DDz5E1M3j9HIglcYyRBPt2cvaRc4D9KpgHrc6MOwm4WA
 x+fhmIpcJP82zdAhVUFxTawqIvQZOIz2ABASaV/aTQ/VyuhnjXvUq3dY5qlTxWgta7zUmGdo4
 KojZkiVKVEbRt4sSldO9mz5LMFjzL8qMm4yIBR4DNlgbMYkE7OsXE5s2yEoY5iRM6tdXSw89+
 U8wt2e71uYR2+REgvERhRqYjn3XInGvJc/yzKg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079578465092839?=
X-GMAIL-MSGID: =?utf-8?q?1596079578465092839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove duplicate newlines and newlines before closing braces.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/odm.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 175c77b11bf9..1037b88e8f08 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -17,7 +17,6 @@
 #ifndef	__HALDMOUTSRC_H__
 #define __HALDMOUTSRC_H__
 
-
 #include "odm_EdcaTurboCheck.h"
 #include "odm_DIG.h"
 #include "odm_PathDiv.h"
@@ -32,7 +31,6 @@
 #define	TRAFFIC_HIGH	1
 #define	NONE			0
 
-
 /* 3 Tx Power Tracking */
 /* 3 ============================================================ */
 #define		DPK_DELTA_MAPPING_NUM	13
@@ -81,7 +79,6 @@
 #define		AUX_ANT		2		/* AntB or Ant Aux */
 #define		MAX_ANT		3		/*  3 for AP using */
 
-
 /* Antenna Diversity Type */
 #define	SW_ANTDIV	0
 #define	HW_ANTDIV	1
@@ -200,7 +197,6 @@ typedef struct _ODM_RATE_ADAPTIVE {
 
 } ODM_RATE_ADAPTIVE, *PODM_RATE_ADAPTIVE;
 
-
 #define IQK_MAC_REG_NUM		4
 #define IQK_ADDA_REG_NUM		16
 #define IQK_BB_REG_NUM_MAX	10
@@ -229,7 +225,6 @@ typedef struct _ODM_RATE_ADAPTIVE {
 #define MAX_PATH_NUM_8814A		4
 #define MAX_PATH_NUM_8822B		2
 
-
 #define IQK_THRESHOLD			8
 #define DPK_THRESHOLD			4
 
@@ -266,7 +261,6 @@ struct odm_phy_info {
 	u8 bt_coex_pwr_adjust;
 };
 
-
 struct odm_packet_info {
 	u8 data_rate;
 	u8 station_id;
@@ -275,7 +269,6 @@ struct odm_packet_info {
 	bool is_beacon;
 };
 
-
 typedef struct _ODM_Phy_Dbg_Info_ {
 	/* ODM Write, debug info */
 	s8 RxSNRdB[4];
@@ -288,12 +281,10 @@ typedef struct _ODM_Phy_Dbg_Info_ {
 
 } ODM_PHY_DBG_INFO_T;
 
-
 typedef struct _ODM_Mac_Status_Info_ {
 	u8 test;
 } ODM_MAC_INFO;
 
-
 typedef enum tag_Dynamic_ODM_Support_Ability_Type {
 	/*  BB Team */
 	ODM_DIG				= 0x00000001,
@@ -372,7 +363,6 @@ typedef enum _ODM_Common_Info_Definition {
 	ODM_CMNINFO_SMART_CONCURRENT,
 	/* HOOK BEFORE REG INIT----------- */
 
-
 	/*  Dynamic value: */
 /*  POINTER REFERENCE----------- */
 	ODM_CMNINFO_MAC_PHY_MODE,	/*  ODM_MAC_PHY_MODE_E */
@@ -430,8 +420,6 @@ typedef enum _ODM_Common_Info_Definition {
 	ODM_CMNINFO_MAC_STATUS,
 
 	ODM_CMNINFO_MAX,
-
-
 } ODM_CMNINFO_E;
 
 /*  2011/10/20 MH Define ODM support ability.  ODM_CMNINFO_ABILITY */
@@ -512,7 +500,6 @@ typedef enum tag_ODM_RF_Path_Bit_Definition {
 	ODM_RF_RX_D	=	BIT7,
 } ODM_RF_PATH_E;
 
-
 typedef enum tag_ODM_RF_Type_Definition {
 	ODM_1T1R	=	0,
 	ODM_1T2R	=	1,
@@ -524,7 +511,6 @@ typedef enum tag_ODM_RF_Type_Definition {
 	ODM_4T4R	=	7,
 } ODM_RF_TYPE_E;
 
-
 /*  */
 /*  ODM Dynamic common info value definition */
 /*  */
@@ -541,7 +527,6 @@ typedef enum tag_ODM_MAC_PHY_Mode_Definition {
 	ODM_DMDP	= 2,
 } ODM_MAC_PHY_MODE_E;
 
-
 typedef enum tag_BT_Coexist_Definition {
 	ODM_BT_BUSY		= 1,
 	ODM_BT_ON		= 2,
@@ -610,7 +595,6 @@ typedef enum tag_Bandwidth_Definition {
 	ODM_BW10M		= 4,
 } ODM_BW_E;
 
-
 /*  ODM_CMNINFO_BOARD_TYPE */
 /*  For non-AC-series IC , ODM_BOARD_5G_EXT_PA and ODM_BOARD_5G_EXT_LNA are ignored */
 /*  For AC-series IC, external PA & LNA can be indivisuallly added on 2.4G and/or 5G */
@@ -664,7 +648,6 @@ typedef enum tag_CCA_Path {
 	ODM_CCA_1R_B		= 2,
 } ODM_CCA_PATH_E;
 
-
 typedef struct _ODM_RA_Info_ {
 	u8 RateID;
 	u32 RateMask;
@@ -703,7 +686,6 @@ typedef struct _IQK_MATRIX_REGS_SETTING {
 	bool bBWIqkResultSaved[3];
 } IQK_MATRIX_REGS_SETTING, *PIQK_MATRIX_REGS_SETTING;
 
-
 /* Remove PATHDIV_PARA struct to odm_PathDiv.h */
 
 typedef struct ODM_RF_Calibration_Structure {
@@ -739,7 +721,6 @@ typedef struct ODM_RF_Calibration_Structure {
 	u8 bRfPiEnable;
 	u32 TXPowerTrackingCallbackCnt; /* cosa add for debug */
 
-
 	/*  Tx power Tracking ------------------------- */
 	u8 bCCKinCH14;
 	u8 CCK_index;
@@ -794,7 +775,6 @@ typedef struct ODM_RF_Calibration_Structure {
 	u32 TxIQC_8723B[2][3][2]; /*  { {S1: 0xc94, 0xc80, 0xc4c} , {S0: 0xc9c, 0xc88, 0xc4c}} */
 	u32 RxIQC_8723B[2][2][2]; /*  { {S1: 0xc14, 0xca0} ,           {S0: 0xc14, 0xca0}} */
 
-
 	/* for APK */
 	u32 APKoutput[2][2]; /* path A/B; output1_1a/output1_2a */
 	u8 bAPKdone;
@@ -842,7 +822,6 @@ typedef struct _FAST_ANTENNA_TRAINNING_ {
 	u32 OFDM_counter_main;
 	u32 OFDM_counter_aux;
 
-
 	u32 CCK_CtrlFrame_Cnt_main;
 	u32 CCK_CtrlFrame_Cnt_aux;
 	u32 OFDM_CtrlFrame_Cnt_main;
@@ -878,13 +857,11 @@ typedef struct _ODM_PATH_DIVERSITY_ {
 	u32 PathB_Cnt[ODM_ASSOCIATE_ENTRY_NUM];
 } PATHDIV_T, *pPATHDIV_T;
 
-
 typedef enum _BASEBAND_CONFIG_PHY_REG_PG_VALUE_TYPE{
 	PHY_REG_PG_RELATIVE_VALUE = 0,
 	PHY_REG_PG_EXACT_VALUE = 1
 } PHY_REG_PG_TYPE;
 
-
 /*  */
 /*  Antenna detection information from single tone mechanism, added by Roger, 2012.11.27. */
 /*  */
@@ -936,7 +913,6 @@ typedef  struct DM_Out_Source_Dynamic_Mechanism_Structure {
 	/* bool			bSlaveOfDMSP; */
 /* REMOVED COMMON INFO---------- */
 
-
 /* 1  COMMON INFORMATION */
 
 	/*  */
@@ -1108,7 +1084,6 @@ typedef  struct DM_Out_Source_Dynamic_Mechanism_Structure {
 	u8 Adaptivity_IGI_upper;
 	u8 NHM_cnt_0;
 
-
 	ODM_NOISE_MONITOR noise_level;/* ODM_MAX_CHANNEL_NUM]; */
 	/*  */
 	/* 2 Define STA info. */
@@ -1370,7 +1345,6 @@ typedef enum tag_SW_Antenna_Switch_Definition {
 	Antenna_MAX = 3,
 } DM_SWAS_E;
 
-
 /*  Maximal number of antenna detection mechanism needs to perform, added by Roger, 2011.12.28. */
 #define	MAX_ANTENNA_DETECTION_CNT	10
 
@@ -1403,7 +1377,6 @@ extern  u32 TxScalingTable_Jaguar[TXSCALE_TABLE_SIZE];
 
 void ODM_SetAntenna(PDM_ODM_T pDM_Odm, u8 Antenna);
 
-
 /* Remove BB power saving by Yuchen */
 
 #define dm_CheckTXPowerTracking ODM_TXPowerTrackingCheck
-- 
2.16.3
