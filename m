Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66EEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754FE2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfAGXLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:11:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52109 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGXLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:11:37 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gge3O-0004o9-Gr; Mon, 07 Jan 2019 23:11:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefano Manni <stefano.manni@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: clean up various indentation and coding style issues
Date:   Mon,  7 Jan 2019 23:11:30 +0000
Message-Id: <20190107231130.13272-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several statements that are indented incorrectly so fix these.
Also remove unnecessary { } braces and clean up a comment.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8712/ieee80211.c       | 2 +-
 drivers/staging/rtl8712/rtl8712_led.c     | 6 +++---
 drivers/staging/rtl8712/rtl871x_mlme.c    | 2 +-
 drivers/staging/rtl8712/rtl871x_recv.c    | 4 ++--
 drivers/staging/rtl8712/rtl871x_sta_mgt.c | 2 +-
 drivers/staging/rtl8712/rtl871x_xmit.c    | 8 ++++----
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index bb4f56a5fb01..2eae11dd6b42 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -408,7 +408,7 @@ int r8712_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 			match = true;
 			break;
 		}
-			cnt += in_ie[cnt + 1] + 2; /* goto next */
+		cnt += in_ie[cnt + 1] + 2; /* goto next */
 	}
 	return match;
 }
diff --git a/drivers/staging/rtl8712/rtl8712_led.c b/drivers/staging/rtl8712/rtl8712_led.c
index 5b1004b2df47..07fcf9b9b811 100644
--- a/drivers/staging/rtl8712/rtl8712_led.c
+++ b/drivers/staging/rtl8712/rtl8712_led.c
@@ -939,7 +939,7 @@ static void SwLedControlMode1(struct _adapter *padapter,
 			}
 			if (pLed->bLedLinkBlinkInProgress) {
 				del_timer(&pLed->BlinkTimer);
-				 pLed->bLedLinkBlinkInProgress = false;
+				pLed->bLedLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
 				del_timer(&pLed->BlinkTimer);
@@ -991,7 +991,7 @@ static void SwLedControlMode1(struct _adapter *padapter,
 			}
 			if (pLed->bLedLinkBlinkInProgress) {
 				del_timer(&pLed->BlinkTimer);
-				 pLed->bLedLinkBlinkInProgress = false;
+				pLed->bLedLinkBlinkInProgress = false;
 			}
 			if (pLed->bLedBlinkInProgress) {
 				del_timer(&pLed->BlinkTimer);
@@ -1018,7 +1018,7 @@ static void SwLedControlMode1(struct _adapter *padapter,
 		}
 		if (pLed->bLedLinkBlinkInProgress) {
 			del_timer(&pLed->BlinkTimer);
-			 pLed->bLedLinkBlinkInProgress = false;
+			pLed->bLedLinkBlinkInProgress = false;
 		}
 		if (pLed->bLedBlinkInProgress) {
 			del_timer(&pLed->BlinkTimer);
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 986a1d526918..3f17ef6f7e39 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -259,7 +259,7 @@ int r8712_is_same_ibss(struct _adapter *adapter, struct wlan_network *pnetwork)
 static int is_same_network(struct wlan_bssid_ex *src,
 			   struct wlan_bssid_ex *dst)
 {
-	 u16 s_cap, d_cap;
+	u16 s_cap, d_cap;
 
 	memcpy((u8 *)&s_cap, r8712_get_capability_from_ie(src->IEs), 2);
 	memcpy((u8 *)&d_cap, r8712_get_capability_from_ie(dst->IEs), 2);
diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index f10896df094b..0271ccf25f25 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -54,7 +54,7 @@ sint _r8712_init_recv_priv(struct recv_priv *precvpriv,
 	sint i;
 	union recv_frame *precvframe;
 
-	 memset((unsigned char *)precvpriv, 0, sizeof(struct  recv_priv));
+	memset((unsigned char *)precvpriv, 0, sizeof(struct  recv_priv));
 	spin_lock_init(&precvpriv->lock);
 	_init_queue(&precvpriv->free_recv_queue);
 	_init_queue(&precvpriv->recv_pending_queue);
@@ -325,7 +325,7 @@ static sint sta2sta_data_frame(struct _adapter *adapter,
 		 */
 		if (memcmp(pattrib->bssid, pattrib->src, ETH_ALEN))
 			return _FAIL;
-	       sta_addr = pattrib->bssid;
+		sta_addr = pattrib->bssid;
 	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		if (bmcast) {
 			/* For AP mode, if DA == MCAST, then BSSID should
diff --git a/drivers/staging/rtl8712/rtl871x_sta_mgt.c b/drivers/staging/rtl8712/rtl871x_sta_mgt.c
index 9648ee15b40e..7c30b9e68e70 100644
--- a/drivers/staging/rtl8712/rtl871x_sta_mgt.c
+++ b/drivers/staging/rtl8712/rtl871x_sta_mgt.c
@@ -25,7 +25,7 @@
 static void _init_stainfo(struct sta_info *psta)
 {
 	memset((u8 *)psta, 0, sizeof(struct sta_info));
-	 spin_lock_init(&psta->lock);
+	spin_lock_init(&psta->lock);
 	INIT_LIST_HEAD(&psta->list);
 	INIT_LIST_HEAD(&psta->hash_list);
 	_r8712_init_sta_xmit_priv(&psta->sta_xmitpriv);
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 5c7dc9c6f76b..7c8857409916 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -193,8 +193,8 @@ sint r8712_update_attrib(struct _adapter *padapter, _pkt *pkt,
 
 	pattrib->ether_type = ntohs(etherhdr.h_proto);
 
-{
-	/*If driver xmit ARP packet, driver can set ps mode to initial
+	/*
+	 * If driver xmit ARP packet, driver can set ps mode to initial
 	 * setting. It stands for getting DHCP or fix IP.
 	 */
 	if (pattrib->ether_type == 0x0806) {
@@ -206,7 +206,7 @@ sint r8712_update_attrib(struct _adapter *padapter, _pkt *pkt,
 					  padapter->registrypriv.smart_ps);
 		}
 	}
-}
+
 	memcpy(pattrib->dst, &etherhdr.h_dest, ETH_ALEN);
 	memcpy(pattrib->src, &etherhdr.h_source, ETH_ALEN);
 	pattrib->pctrl = 0;
@@ -949,7 +949,7 @@ static void alloc_hwxmits(struct _adapter *padapter)
 		pxmitpriv->vo_txqueue.head = 0;
 		hwxmits[1] .phwtxqueue = &pxmitpriv->vo_txqueue;
 		hwxmits[1] .sta_queue = &pxmitpriv->vo_pending;
-	pxmitpriv->vi_txqueue.head = 0;
+		pxmitpriv->vi_txqueue.head = 0;
 		hwxmits[2] .phwtxqueue = &pxmitpriv->vi_txqueue;
 		hwxmits[2] .sta_queue = &pxmitpriv->vi_pending;
 		pxmitpriv->bk_txqueue.head = 0;
-- 
2.19.1

