Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66476C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A90F20891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A90F20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeFQVL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 17:11:29 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:45960 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751340AbeFQVLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 17:11:04 -0400
Received: from faui49man9 (faui49man9.informatik.uni-erlangen.de [131.188.42.54])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 9CEBB58C4C4;
        Sun, 17 Jun 2018 23:02:39 +0200 (CEST)
Received: by faui49man9 (sSMTP sendmail emulation); Sun, 17 Jun 2018 23:02:39 +0200
From:   =?UTF-8?q?Fabian=20Bl=C3=A4se?= <fabian.blaese@fau.de>
To:     gregkh@linuxfoundation.org
Cc:     maximilian.o.ott@fau.de, linux-kernel@i4.cs.fau.de,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        julia.lawall@lip6.fr, georgiana.chelu93@gmail.com,
        dafna3@gmail.com, keescook@chromium.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Fabian=20Bl=C3=A4se?= <fabian.blaese@fau.de>
Subject: [PATCH 1/2] rtl8192u/rtl819x_Qos.h: Adjust spaces to coding guidelines
Date:   Sun, 17 Jun 2018 23:02:30 +0200
Message-Id: <1529269351-21941-2-git-send-email-fabian.blaese@fau.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529269351-21941-1-git-send-email-fabian.blaese@fau.de>
References: <1529269351-21941-1-git-send-email-fabian.blaese@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves spacing according to the coding guidelines,
mainly around braces.

This patch fixes errors reported by checkpatch.

Signed-off-by: Fabian Bläse <fabian.blaese@fau.de>
Signed-off-by: Maximilian Ott <maximilian.o.ott@fau.de>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 94 ++++++++++++------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 71df9d9..96e9621 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -31,7 +31,7 @@ typedef u32 QOS_MODE, *PQOS_MODE;
 // QoS ACK Policy Field Values
 // Ref: WMM spec 2.1.6: QoS Control Field, p.10.
 //
-typedef	enum _ACK_POLICY{
+typedef	enum _ACK_POLICY {
 	eAckPlc0_ACK		= 0x00,
 	eAckPlc1_NoACK		= 0x01,
 } ACK_POLICY, *PACK_POLICY;
@@ -44,7 +44,7 @@ typedef	enum _ACK_POLICY{
 //	1. WMM spec 2.1.6: QoS Control Field, p.9.
 //	2. 802.11e/D13.0 7.1.3.5, p.26.
 //
-typedef	union _QOS_CTRL_FIELD{
+typedef	union _QOS_CTRL_FIELD {
 	u8	charData[2];
 	u16	shortData;
 
@@ -56,7 +56,7 @@ typedef	union _QOS_CTRL_FIELD{
 		u8		AckPolicy:2;
 		u8		usRsvd2:1;
 		u8		ucRsvdByte;
-	}WMM;
+	} WMM;
 
 	// 802.11e: QoS data type frame sent by non-AP QSTAs.
 	struct {
@@ -65,7 +65,7 @@ typedef	union _QOS_CTRL_FIELD{
 		u8		AckPolicy:2;
 		u8		usRsvd:1;
 		u8		TxopOrQsize;	// (BIT4=0)TXOP Duration Requested or (BIT4=1)Queue Size.
-	}BySta;
+	} BySta;
 
 	// 802.11e: QoS data, QoS Null, and QoS Data+CF-Ack frames sent by HC.
 	struct {
@@ -74,7 +74,7 @@ typedef	union _QOS_CTRL_FIELD{
 		u8		AckPolicy:2;
 		u8		usRsvd:1;
 		u8		PSBufState;		// QAP PS Buffer State.
-	}ByHc_Data;
+	} ByHc_Data;
 
 	// 802.11e: QoS (+) CF-Poll frames sent by HC.
 	struct {
@@ -83,9 +83,9 @@ typedef	union _QOS_CTRL_FIELD{
 		u8		AckPolicy:2;
 		u8		usRsvd:1;
 		u8		TxopLimit;		// TXOP Limit.
-	}ByHc_CFP;
+	} ByHc_CFP;
 
-}QOS_CTRL_FIELD, *PQOS_CTRL_FIELD;
+} QOS_CTRL_FIELD, *PQOS_CTRL_FIELD;
 
 
 //
@@ -94,13 +94,13 @@ typedef	union _QOS_CTRL_FIELD{
 //	1. WMM spec 2.2.1: WME Information Element, p.11.
 //	2. 8185 QoS code: QOS_INFO [def. in QoS_mp.h]
 //
-typedef	union _QOS_INFO_FIELD{
+typedef	union _QOS_INFO_FIELD {
 	u8	charData;
 
 	struct {
 		u8		ucParameterSetCount:4;
 		u8		ucReserved:4;
-	}WMM;
+	} WMM;
 
 	struct {
 		//Ref WMM_Specification_1-1.pdf, 2006-06-13 Isaiah
@@ -112,14 +112,14 @@ typedef	union _QOS_INFO_FIELD{
 		u8		ucMaxSPLen:2;
 		u8		ucReserved2:1;
 
-	}ByWmmPsSta;
+	} ByWmmPsSta;
 
 	struct {
 		//Ref WMM_Specification_1-1.pdf, 2006-06-13 Isaiah
 		u8		ucParameterSetCount:4;
 		u8		ucReserved:3;
 		u8		ucApUapsd:1;
-	}ByWmmPsAp;
+	} ByWmmPsAp;
 
 	struct {
 		u8		ucAC3_UAPSD:1;
@@ -172,7 +172,7 @@ typedef	union _QOS_INFO_FIELD{
 		u8		ucApUapsd:1;
 	} ByAllAp;
 
-}QOS_INFO_FIELD, *PQOS_INFO_FIELD;
+} QOS_INFO_FIELD, *PQOS_INFO_FIELD;
 
 //
 // ACI to AC coding.
@@ -198,7 +198,7 @@ typedef u32 AC_CODING;
 // ACI/AIFSN Field.
 // Ref: WMM spec 2.2.2: WME Parameter Element, p.12.
 //
-typedef	union _ACI_AIFSN{
+typedef	union _ACI_AIFSN {
 	u8	charData;
 
 	struct {
@@ -206,26 +206,26 @@ typedef	union _ACI_AIFSN{
 		u8	ACM:1;
 		u8	ACI:2;
 		u8	Reserved:1;
-	}f;	// Field
-}ACI_AIFSN, *PACI_AIFSN;
+	} f;	// Field
+} ACI_AIFSN, *PACI_AIFSN;
 
 //
 // ECWmin/ECWmax field.
 // Ref: WMM spec 2.2.2: WME Parameter Element, p.13.
 //
-typedef	union _ECW{
+typedef	union _ECW {
 	u8	charData;
 	struct {
 		u8	ECWmin:4;
 		u8	ECWmax:4;
-	}f;	// Field
-}ECW, *PECW;
+	} f;	// Field
+} ECW, *PECW;
 
 //
 // AC Parameters Record Format.
 // Ref: WMM spec 2.2.2: WME Parameter Element, p.12.
 //
-typedef	union _AC_PARAM{
+typedef	union _AC_PARAM {
 	u32	longData;
 	u8	charData[4];
 
@@ -233,15 +233,15 @@ typedef	union _AC_PARAM{
 		ACI_AIFSN	AciAifsn;
 		ECW		Ecw;
 		u16		TXOPLimit;
-	}f;	// Field
-}AC_PARAM, *PAC_PARAM;
+	} f;	// Field
+} AC_PARAM, *PAC_PARAM;
 
 
 
 //
 // QoS element subtype
 //
-typedef	enum _QOS_ELE_SUBTYPE{
+typedef	enum _QOS_ELE_SUBTYPE {
 	QOSELE_TYPE_INFO	= 0x00,		// 0x00: Information element
 	QOSELE_TYPE_PARAM	= 0x01,		// 0x01: parameter element
 } QOS_ELE_SUBTYPE, *PQOS_ELE_SUBTYPE;
@@ -251,7 +251,7 @@ typedef	enum _QOS_ELE_SUBTYPE{
 // Direction Field Values.
 // Ref: WMM spec 2.2.11: WME TSPEC Element, p.18.
 //
-typedef	enum _DIRECTION_VALUE{
+typedef	enum _DIRECTION_VALUE {
 	DIR_UP			= 0,		// 0x00	// UpLink
 	DIR_DOWN		= 1,		// 0x01	// DownLink
 	DIR_DIRECT		= 2,		// 0x10	// DirectLink
@@ -265,7 +265,7 @@ typedef	enum _DIRECTION_VALUE{
 //	1. WMM spec 2.2.11: WME TSPEC Element, p.18.
 //	2. 8185 QoS code: QOS_TSINFO [def. in QoS_mp.h]
 //
-typedef union _QOS_TSINFO{
+typedef union _QOS_TSINFO {
 	u8		charData[3];
 	struct {
 		u8		ucTrafficType:1;			//WMM is reserved
@@ -278,14 +278,14 @@ typedef union _QOS_TSINFO{
 		u8		ucTSInfoAckPolicy:2;		//WMM is reserved
 		u8		ucSchedule:1;			//WMM is reserved
 		u8		ucReserved:7;
-	}field;
-}QOS_TSINFO, *PQOS_TSINFO;
+	} field;
+} QOS_TSINFO, *PQOS_TSINFO;
 
 //
 // WMM TSPEC Body.
 // Ref: WMM spec 2.2.11: WME TSPEC Element, p.16.
 //
-typedef union _TSPEC_BODY{
+typedef union _TSPEC_BODY {
 	u8		charData[55];
 
 	struct {
@@ -306,14 +306,14 @@ typedef union _TSPEC_BODY{
 		u16	SurplusBandwidthAllowance;
 		u16	MediumTime;
 	} f;	// Field
-}TSPEC_BODY, *PTSPEC_BODY;
+} TSPEC_BODY, *PTSPEC_BODY;
 
 
 //
 // WMM TSPEC Element.
 // Ref: WMM spec 2.2.11: WME TSPEC Element, p.16.
 //
-typedef struct _WMM_TSPEC{
+typedef struct _WMM_TSPEC {
 	u8		ID;
 	u8		Length;
 	u8		OUI[3];
@@ -327,19 +327,19 @@ typedef struct _WMM_TSPEC{
 // ACM implementation method.
 // Annie, 2005-12-13.
 //
-typedef	enum _ACM_METHOD{
+typedef	enum _ACM_METHOD {
 	eAcmWay0_SwAndHw		= 0,		// By SW and HW.
 	eAcmWay1_HW			= 1,		// By HW.
 	eAcmWay2_SW			= 2,		// By SW.
 } ACM_METHOD, *PACM_METHOD;
 
 
-typedef struct _ACM{
+typedef struct _ACM {
 //	u8		RegEnableACM;
 	u64		UsedTime;
 	u64		MediumTime;
 	u8		HwAcmCtl;	// TRUE: UsedTime exceed => Do NOT USE this AC. It wll be written to ACM_CONTROL(0xBF BIT 0/1/2 in 8185B).
-}ACM, *PACM;
+} ACM, *PACM;
 
 typedef	u8		AC_UAPSD, *PAC_UAPSD;
 
@@ -359,15 +359,15 @@ typedef	u8		AC_UAPSD, *PAC_UAPSD;
 //typedef struct _TCLASS{
 // TODO
 //} TCLASS, *PTCLASS;
-typedef union _QOS_TCLAS{
+typedef union _QOS_TCLAS {
 
-	struct _TYPE_GENERAL{
+	struct _TYPE_GENERAL {
 		u8		Priority;
 		u8		ClassifierType;
 		u8		Mask;
 	} TYPE_GENERAL;
 
-	struct _TYPE0_ETH{
+	struct _TYPE0_ETH {
 		u8		Priority;
 		u8		ClassifierType;
 		u8		Mask;
@@ -376,7 +376,7 @@ typedef union _QOS_TCLAS{
 		u16		Type;
 	} TYPE0_ETH;
 
-	struct _TYPE1_IPV4{
+	struct _TYPE1_IPV4 {
 		u8		Priority;
 		u8		ClassifierType;
 		u8		Mask;
@@ -390,7 +390,7 @@ typedef union _QOS_TCLAS{
 		u8		Reserved;
 	} TYPE1_IPV4;
 
-	struct _TYPE1_IPV6{
+	struct _TYPE1_IPV6 {
 		u8		Priority;
 		u8		ClassifierType;
 		u8		Mask;
@@ -402,7 +402,7 @@ typedef union _QOS_TCLAS{
 		u8		FlowLabel[3];
 	} TYPE1_IPV6;
 
-	struct _TYPE2_8021Q{
+	struct _TYPE2_8021Q {
 		u8		Priority;
 		u8		ClassifierType;
 		u8		Mask;
@@ -415,7 +415,7 @@ typedef union _QOS_TCLAS{
 //- TSPEC
 //- AC (which to mapping)
 //} WMM_TSTREAM, *PWMM_TSTREAM;
-typedef struct _QOS_TSTREAM{
+typedef struct _QOS_TSTREAM {
 	u8			AC;
 	WMM_TSPEC		TSpec;
 	QOS_TCLAS		TClass;
@@ -439,16 +439,16 @@ typedef struct _QOS_TSTREAM{
 //----------------------------------------------------------------------------
 //      802.11 Management frame Status Code field
 //----------------------------------------------------------------------------
-typedef struct _OCTET_STRING{
+typedef struct _OCTET_STRING {
 	u8		*Octet;
 	u16             Length;
-}OCTET_STRING, *POCTET_STRING;
+} OCTET_STRING, *POCTET_STRING;
 
 //
 // STA QoS data.
 // Ref: DOT11_QOS in 8185 code. [def. in QoS_mp.h]
 //
-typedef struct _STA_QOS{
+typedef struct _STA_QOS {
 	//DECLARE_RT_OBJECT(STA_QOS);
 	u8				WMMIEBuf[MAX_WMMELE_LENGTH];
 	u8				*WMMIE;
@@ -495,13 +495,13 @@ typedef struct _STA_QOS{
 	// Enable/Disable Rx immediate BA capability.
 	u8				bEnableRxImmBA;
 
-}STA_QOS, *PSTA_QOS;
+} STA_QOS, *PSTA_QOS;
 
 //
 // BSS QOS data.
 // Ref: BssDscr in 8185 code. [def. in BssDscr.h]
 //
-typedef struct _BSS_QOS{
+typedef struct _BSS_QOS {
 	QOS_MODE		bdQoSMode;
 
 	u8			bdWMMIEBuf[MAX_WMMELE_LENGTH];
@@ -514,7 +514,7 @@ typedef struct _BSS_QOS{
 
 	QOS_INFO_FIELD		QosInfoField;
 	AC_PARAM		AcParameter[4];
-}BSS_QOS, *PBSS_QOS;
+} BSS_QOS, *PBSS_QOS;
 
 
 //
@@ -522,12 +522,12 @@ typedef struct _BSS_QOS{
 //#define QoSCtl   ((	(Adapter->bRegQoS) && (Adapter->dot11QoS.QoSMode &(QOS_EDCA|QOS_HCCA))	  )  ?sQoSCtlLng:0)
 //
 #define sQoSCtlLng			2
-#define	QOS_CTRL_LEN(_QosMode)		((_QosMode > QOS_DISABLE)? sQoSCtlLng : 0)
+#define	QOS_CTRL_LEN(_QosMode)		((_QosMode > QOS_DISABLE) ? sQoSCtlLng : 0)
 
 
 //Added by joseph
 //UP Mapping to AC, using in MgntQuery_SequenceNumber() and maybe for DSCP
 //#define UP2AC(up)			((up<3)?((up==0)?1:0):(up>>1))
-#define IsACValid(ac)			((ac<=7 )?true:false )
+#define IsACValid(ac)			((ac <= 7) ? true : false)
 
 #endif // #ifndef __INC_QOS_TYPE_H
-- 
2.7.4

