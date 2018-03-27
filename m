Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELtQnXJdBtOJSzU/ic+Ci90lp+F20X38wuYFtaRrWRk7qtOOxWbGMBTu7bAv6I1fUdCcIKc5
ARC-Seal: i=1; a=rsa-sha256; t=1522140095; cv=none;
        d=google.com; s=arc-20160816;
        b=gUXu7MfypNmV+vnKscbo+Fv76o5I2GGBfNot5/zGGlUZQtO1sIh4lpxG1HCRZW0CUi
         iK+/YJC4sha7I2gE4X9kmGNWWmGJUNJbaq1GkhdVBGpNtv9DieQw/+Zvo8inpMf1+vhn
         H07EWuwKHOB04ja16hsPEaps137LhWzBH9IoFvideYzQ8aYmHV2gsCg20EwaBvUHBTzX
         86CDxyVaAJhRK3Ato5lJvG2gMTwvxFnSQ35zUb2Xql4RssLrP3nV3be/kMSo/6VauPdG
         3G7obikNV+zybOqpkmlb+PnkEitcTyUkWZWAZ30VLMF7WfCsdFbNcZnG6wn8obziiSyi
         6mWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=bOamjmrWFvtO4rEoSuELxQY79+smt1JRQkFyGADBQFc=;
        b=zaqHRnzTBTrsAVgf9LatMEDOtbg6IHQNzJpgY+JML8xR+q2fpfQEat/Cosjbj6EqCR
         jtVgV26bNFpu8CUUIT/DM2+uJQ/51JDq8iiVbZdqSqyWSpf49MIkyFPGI23czP+wDAbP
         /eBzi2O7DkkyivDXUfizmoaFXKmcPrJis1UrGsqePxhLNfRmecwlzcMO9UkWq9Yn2m6E
         p01F7NI2tcuZ9w+jTDTOLD8FrPZi5S3AjXSIR/VeiXxtjjUiCUoFPsPKdiGZUAOLIpPO
         FaYsRKa4OSU1LN2MtK1/W1YEZGxeL9G+y+gppZNvEbzTlDdWEWqHqkZmTXAUSc4VhzMg
         X09Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 15/23] staging: rtl8723bs: Change camel case to snake case in 'rtl8723bs_recv.c'.
Date: Tue, 27 Mar 2018 01:41:07 -0700
Message-Id: <20180327084115.16129-15-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327084115.16129-1-quytelda@tamalin.org>
References: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
 <20180327084115.16129-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:d4vN4LWMolL+A8icMgfXQJ278FRMwR8cepp01pGZckwU+Qdul1N
 3UpED3Z2mpwAHQCVIPAOr4dUe+ubhYiOAdLHwqiJlXpJ5Rg8ysttjuA+z9KgND8jXojAlH9
 MHkLwgAx+yXAexmBoNn+v4r6OXEa9gnbkB7EKfCAzAZ3MzjFPj9jS2b7pUY8dEmhBNlRenK
 shQFugAqJsqTaMFZ201hA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mw4923hjBZs=:U7gmokDgJap3UA0mChkUW8
 it+GAZOanE283wGgULjgqHwYrCAq7V4oaAyC1OZ/k+z1TJk6iZBk+mGBXDkDuuS8UVREZ7wIQ
 z192j6h1SeKXZ8UvclvDCooEeoNLAQQCCRBmr+l86+CsGm4gRoPo77bQbbC3QX9TXkCeQtrsC
 HBLOPPyJJCfJP4MulTG12zvb0lm8g7npA1NfHu1t9fgaItFsFqHiqW3W/+E6Hm/aHoKfutrUi
 cCnoJSGvrbpjy7pB/0PYKtYG3cARGGJhcjxNC2snGfNoXMQkXLEOFg4t7BQji6ElmGSsN7X2w
 EP9UnBUIfiN9/mBP/ArScSiVs08lLC/fwI48rfkV8wwPZCfBefaksTkZzlrmqRf/vbBq4R41I
 6iMJCjvQnn53NVTGSP79s+vmBYnVJ5wge296FIN4GuVCRylcpAgK3ornH7deH7BdHOGMa7HKN
 ZWk6QEwCrPaIJNfSMBWyVtO091FYilGvewvawoTAgJ5qsyFAOAuS+oxoQe120Y/X9e7qxWlb9
 9ebxr9PHffgS+sXNoBeR4++FLSo7u5mXYx3Eg5m/ETQpCySg3ZrQLMbEl/+2dulRYEAfTVpHe
 DexifhBfLk5uEJMcLnl+w1qgvqwaSb33XlPf21IunAU3cn19uBv4oPVeoZc09ha+CbhH82vSS
 KgNVMMGV6cXPyV+TkgQCYC2PvVrD27l5mN3JcjWyxXBZ3VbJZe5vRzPGA5SlNuP28PjtAS04U
 TscQcoHeBzgqg6aP5LcH7yLuw7Qv4eWKPnBoSA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596079573211806188?=
X-GMAIL-MSGID: =?utf-8?q?1596079573211806188?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Linux kernel coding style dictates the use of snake case for variable
naming.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 32 +++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 4ba315f1daaf..8afac615a42b 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -90,8 +90,8 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 {
 	struct adapter *padapter = precvframe->u.hdr.adapter;
 	struct rx_pkt_attrib *pattrib = &precvframe->u.hdr.attrib;
-	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
-	PODM_PHY_INFO_T pPHYInfo = (PODM_PHY_INFO_T)(&pattrib->phy_info);
+	struct hal_com_data *p_hal_data = GET_HAL_DATA(padapter);
+	PODM_PHY_INFO_T p_phy_info = (PODM_PHY_INFO_T)(&pattrib->phy_info);
 
 	u8 *wlanhdr;
 	ODM_PACKET_INFO_T pkt_info;
@@ -128,11 +128,11 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	pkt_info.DataRate = pattrib->data_rate;
 
 	/* rtl8723b_query_rx_phy_status(precvframe, pphy_status); */
-	/* spin_lock_bh(&pHalData->odm_stainfo_lock); */
-	ODM_PhyStatusQuery(&pHalData->odmpriv, pPHYInfo, (u8 *)pphy_status, &(pkt_info));
+	/* spin_lock_bh(&p_hal_data->odm_stainfo_lock); */
+	ODM_PhyStatusQuery(&p_hal_data->odmpriv, p_phy_info, (u8 *)pphy_status, &(pkt_info));
 	if (psta)
 		psta->rssi = pattrib->phy_info.RecvSignalPower;
-	/* spin_unlock_bh(&pHalData->odm_stainfo_lock); */
+	/* spin_unlock_bh(&p_hal_data->odm_stainfo_lock); */
 	precvframe->u.hdr.psta = NULL;
 	if (
 		pkt_info.bPacketMatchBSSID &&
@@ -152,7 +152,7 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 
 static void rtl8723bs_c2h_packet_handler(struct adapter *padapter, u8 *pbuf, u16 length)
 {
-	u8 *tmpBuf = NULL;
+	u8 *tmp = NULL;
 	u8 res = false;
 
 	if (length == 0)
@@ -160,16 +160,16 @@ static void rtl8723bs_c2h_packet_handler(struct adapter *padapter, u8 *pbuf, u16
 
 	/* DBG_871X("+%s() length =%d\n", __func__, length); */
 
-	tmpBuf = rtw_zmalloc(length);
-	if (tmpBuf == NULL)
+	tmp = rtw_zmalloc(length);
+	if (tmp == NULL)
 		return;
 
-	memcpy(tmpBuf, pbuf, length);
+	memcpy(tmp, pbuf, length);
 
-	res = rtw_c2h_packet_wk_cmd(padapter, tmpBuf, length);
+	res = rtw_c2h_packet_wk_cmd(padapter, tmp, length);
 
 	if (res == false)
-		kfree(tmpBuf);
+		kfree(tmp);
 
 	/* DBG_871X("-%s res(%d)\n", __func__, res); */
 
@@ -179,7 +179,7 @@ static void rtl8723bs_c2h_packet_handler(struct adapter *padapter, u8 *pbuf, u16
 static void rtl8723bs_recv_tasklet(void *priv)
 {
 	struct adapter *padapter;
-	struct hal_com_data *pHalData;
+	struct hal_com_data *p_hal_data;
 	struct recv_priv *precvpriv;
 	struct recv_buf *precvbuf;
 	union recv_frame *precvframe;
@@ -191,7 +191,7 @@ static void rtl8723bs_recv_tasklet(void *priv)
 
 
 	padapter = priv;
-	pHalData = GET_HAL_DATA(padapter);
+	p_hal_data = GET_HAL_DATA(padapter);
 	precvpriv = &padapter->recvpriv;
 
 	do {
@@ -219,7 +219,7 @@ static void rtl8723bs_recv_tasklet(void *priv)
 			pattrib = &precvframe->u.hdr.attrib;
 
 			/*  fix Hardware RX data error, drop whole recv_buffer */
-			if ((!(pHalData->ReceiveConfig & RCR_ACRC32)) && pattrib->crc_err) {
+			if ((!(p_hal_data->ReceiveConfig & RCR_ACRC32)) && pattrib->crc_err) {
 				DBG_8192C("%s()-%d: RX Warning! rx CRC ERROR !!\n", __func__, __LINE__);
 				rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
 				break;
@@ -300,14 +300,14 @@ static void rtl8723bs_recv_tasklet(void *priv)
 				recvframe_put(precvframe, skb_len);
 				/* recvframe_pull(precvframe, drvinfo_sz + RXDESC_SIZE); */
 
-				if (pHalData->ReceiveConfig & RCR_APPFCS)
+				if (p_hal_data->ReceiveConfig & RCR_APPFCS)
 					recvframe_pull_tail(precvframe, IEEE80211_FCS_LEN);
 
 				/*  move to drv info position */
 				ptr += RXDESC_SIZE;
 
 				/*  update drv info */
-				if (pHalData->ReceiveConfig & RCR_APP_BA_SSN) {
+				if (p_hal_data->ReceiveConfig & RCR_APP_BA_SSN) {
 					/* rtl8723s_update_bassn(padapter, pdrvinfo); */
 					ptr += 4;
 				}
-- 
2.16.3
