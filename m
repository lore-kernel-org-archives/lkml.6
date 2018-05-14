Return-Path: <johnfwhitmore@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526313256; cv=none;
        d=google.com; s=arc-20160816;
        b=w00hiGpiAUDXrrybhtnXlXnLymSYRxmbMbFptfHvTvO63INj5UUTDhbjN7pjmB33Ic
         rX24RcnlKYnqR7hsk9lPRerOPuEyodpP5/ZFxZs7PiZMjtMPdlnV5nvfZ4feV0xjdrqN
         DpGpvGEEGZDxN1LoOJCMt8pX6Y/AQv8OnG/Hw6/ox7LlTr+nAlm3cNElvkHGEuE12eTT
         VH/ppnQnq7hp+rX+Ue/312NFqeyuHnbKGhCrTY/nkpSLL+dlv2c5Eg+2rt/Da0kJzLIx
         WcYF3jWn4aOGBEGpto0Cus9KMXkDaRRc1MNcFnOccXrZ2mO0Oq8miaYdNNtjkOCjpobM
         Zlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=pBxXNE71z9tRd5qlAgMZjRMwBTBGOP+cc4FdCwO8yLE=;
        b=IF4gVhLG4dXj5JU061hEH9ctGySF2EkvMLYXK9H1dmpe865mTzW8P633qinT4SXQp0
         iQy1lmzbETLbQn4WV/Pk2yPDeKLjKB2ATCB61NiMed7qm+vkGSnsbCaRTFhRy7r3qSgg
         lhJP2yUFdZF7UiY9SZXFRNPO75i6Y1vKqGWrwLA4pe/R4ytYZMZ6HhHiRFxleYRP/zZs
         5Nzg4QcryPkyqWVni8+fs0NvAjbjSifcGqzZRLK6prdOk6R68p/enGR23Hs8l61CCE9g
         gx6kzI9zhlKgBfAS8wTABGGi9fCfSPbJ99yeRkEawtLPssi7JqRAJpiZRNpSrGNQzAy8
         89Vg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bH5J9I7k;
       spf=pass (google.com: domain of johnfwhitmore@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=johnfwhitmore@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bH5J9I7k;
       spf=pass (google.com: domain of johnfwhitmore@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=johnfwhitmore@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrYpKDRb+8jKsFCs8d8XNiwf9WqTlVb3w2XMMCbnjU+tjh3ZzrEjMeVQS4thcFo8u0fScZ+Xg==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kstewart@linuxfoundation.org,
	colin.king@canonical.com,
	tglx@linutronix.de,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	johnfwhitmore@gmail.com
Subject: [PATCH 08/13] Coding style, added blank line after declarations.
Date: Mon, 14 May 2018 16:53:13 +0100
Message-Id: <20180514155318.32195-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180514155318.32195-1-johnfwhitmore@gmail.com>
References: <20180514155318.32195-1-johnfwhitmore@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600455448713990134?=
X-GMAIL-MSGID: =?utf-8?q?1600455448713990134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 56cc1192cf9f..254d536c21d8 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -331,6 +331,7 @@ bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee)
 {
 	bool			retValue = false;
 	struct ieee80211_network *net = &ieee->current_network;
+
 	if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
 	    (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
 	    (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
@@ -364,6 +365,7 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
 	struct ieee80211_network *net = &ieee->current_network;
+
 	if (net->bssht.bdRT2RTAggregation)
 		pHTInfo->IOTPeer = HT_IOT_PEER_REALTEK;
 	else if (net->broadcom_cap_exist)
@@ -389,6 +391,7 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 
 	IEEE80211_DEBUG(IEEE80211_DL_IOT, "Joseph debug!! IOTPEER: %x\n", pHTInfo->IOTPeer);
 }
+
 /*******************************************************************************
  *function:  Check whether driver should declare received rate up to MCS13 only
  *           since some chipset is not good at receiving MCS14~15 frame from
@@ -503,6 +506,7 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 static u8 HTIOTActIsCCDFsync(u8 *PeerMacAddr)
 {
 	u8	retValue = 0;
+
 	if ((memcmp(PeerMacAddr, UNKNOWN_BORADCOM, 3) == 0) ||
 	    (memcmp(PeerMacAddr, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) == 0) ||
 	    (memcmp(PeerMacAddr, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) == 0))
@@ -541,6 +545,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	memset(posHTCap, 0, *len);
 	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
+
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
 		pCapELE = (PHT_CAPABILITY_ELE) & posHTCap[4];
 	} else {
@@ -596,6 +601,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	// For RTL819X, if pairwisekey = wep/tkip, ap is ralink, we support only MCS0~7.
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
 		int i;
+
 		for(i = 1; i < 16; i++)
 			pCapELE->MCS[i] = 0;
 	}
@@ -636,7 +642,8 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *len, u8 IsEncrypt)
 {
 	PRT_HIGH_THROUGHPUT	pHT = ieee->pHTInfo;
-	PHT_INFORMATION_ELE		pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
+	PHT_INFORMATION_ELE	pHTInfoEle = (PHT_INFORMATION_ELE)posHTInfo;
+
 	if ((posHTInfo == NULL) || (pHTInfoEle == NULL)) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "posHTInfo or pHTInfoEle can't be null in HTConstructInfoElement()\n");
 		return;
@@ -750,6 +757,7 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
 	u8					i;
+
 	if (pOperateMCS == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
 		return false;
@@ -813,6 +821,7 @@ u8 HTGetHighestMCSRate(struct ieee80211_device *ieee, u8 *pMCSRateSet, u8 *pMCSF
 	u8		bitMap;
 	u8		mcsRate = 0;
 	u8		availableMcsRate[16];
+
 	if (pMCSRateSet == NULL || pMCSFilter == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pMCSRateSet or pMCSFilter can't be null in HTGetHighestMCSRate()\n");
 		return false;
@@ -886,6 +895,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 
 	return true;
 }
+
 void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidth, HT_EXTCHNL_OFFSET	Offset);
 void HTOnAssocRsp(struct ieee80211_device *ieee)
 {
@@ -1120,6 +1130,7 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	//MCS rate initialized here
 	{
 		u8 *RegHTSuppRateSets = &ieee->RegHTSuppRateSet[0];
+
 		RegHTSuppRateSets[0] = 0xFF;	//support MCS 0~7
 		RegHTSuppRateSets[1] = 0xFF;	//support MCS 8~15
 		RegHTSuppRateSets[4] = 0x01;	//support MCS 32
-- 
2.16.3
