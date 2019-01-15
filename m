Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6358BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1455120657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbfAOQQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:16:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:59015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbfAOQQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:16:40 -0500
Received: from Workstation ([79.231.49.194]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6O1v-1hTakm2oTT-00yPYr; Tue, 15
 Jan 2019 17:16:23 +0100
Date:   Tue, 15 Jan 2019 17:16:19 +0100
From:   Florian =?utf-8?B?QsO8c3RnZW5z?= <flbue@gmx.de>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtl8188eu: Refactoring struct ndis_802_11_ssid from
 CamelCase to correct code style.
Message-ID: <20190115161619.n7g3toisphbxd35e@Workstation.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716
X-Provags-ID: V03:K1:So1MYCcEaibspg92qi+nmO6HYZe+ymp/zaJH+d3P1VZf8REXYJB
 /bVTVjEhQh5Em8i30s8wwulSYNKvLlAnl/FAIZoYfSdTXObLw7hY5q+gehA1R9uq+8Mgd2O
 30xZYNkIPV+aHoNBzQQK798RfkyBgm3hAuUP+0q7F/EpBRaTMkjUwM6FqWWxHtJFIxj6iHr
 vZKN5gZZkpMo4ZUitAeYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aK6Uiwr42Bo=:S9MD9wKvryFDj9nHrgDSBq
 enpi+9ckOk4ozoOAZbcKEKKdxV3A+ixEj6WjE0BbK93RWwq+313QgBFiHCS5KRudK4kBIV5V4
 uydD/PIZPO/GertPthLJ1r79UfuX3+nOgcUMtqb7NqLICdaJU97nC5x0bHj12z4mjfYBNSkpT
 A4WckbX/ILal5d3EaC/EsBSXQ7lwQxVY7MUtOalF9Fe1LQ+G1hPFpiHfmyG+CtiGSBjEnKbS5
 AkhvweQE45IdZM58OMoqpNYj59IE/U98Jt4bV8SMhuZ5WXB0uQzq/9wWa0m3pwBoV+6xn1P7T
 SuEuufcoISNBbiCydOZbkl3McHdRq5rRCajUof8ptBSlzaTbgO6Y2oxX6TOeHiyjVAcqsye08
 GZoaX6TTWJwSg9Z/8seD141NgJM8lG3GRh+O/u52gfBSSECV/OY/pOIM/PbGYm8xAkfC/KZPL
 W7bV0tT6neMNnAsCVC3B+oGenFJdWA/RNiWtYsRp0kV3RSsCnJL8dfgD+cN/XCPY5OdPsUarM
 eRlQd/xW7EWUPlGHNtbY6P35Q1iso51WG8KFwltCnwlvD49AKMhb/7jH3uYjxQSEfjktSA4Jr
 K5kGAuS442QKrFd0hU2r4ptOrfKs1r/H1kWt8iO7TjLl5Qnepj7A/Db4ipRmrsvbEUJ2R0uI2
 zSvOKhd8TZp81LGizdcTfIvb5wbNRwJrPVaBPeeKuwGsAznj3aPG1h6ypAEOfltTf8JrMLcc4
 RZcIKM7IWrjlmDmmJksdfGdaKLe95suBAg/ld6lmbwrk5E36LtLFuIiotmhZJ+0tUwCHxTKh/
 YQViaOMpmvZjt3BQhs5CFaFElufPznxIBjKZGUgjpl9lrC0iQ76rvEQl3fwqI1Zqxwl0nXX4I
 Va2wqlzqcmBVOzMrJ7HoU9Xcn7ofgpsuieKV1WpCE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtl8188eu uses CamelCase for many struct members.
Refactors the ndis_802_11_ssid members Ssid and SsidLength to keep correct code style.
Issue found by checkpatch.

Signed-off-by: Florian Büstgens <flbue@gmx.de>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c       |  8 ++--
 drivers/staging/rtl8188eu/core/rtw_cmd.c      | 12 ++---
 .../staging/rtl8188eu/core/rtw_ieee80211.c    |  6 +--
 .../staging/rtl8188eu/core/rtw_ioctl_set.c    | 12 ++---
 drivers/staging/rtl8188eu/core/rtw_mlme.c     | 44 +++++++++----------
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 38 ++++++++--------
 .../staging/rtl8188eu/core/rtw_wlan_util.c    | 18 ++++----
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c  |  2 +-
 .../staging/rtl8188eu/include/wlan_bssdef.h   |  6 +--
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 34 +++++++-------
 drivers/staging/rtl8188eu/os_dep/os_intfs.c   |  4 +-
 .../staging/rtl8188eu/os_dep/rtw_android.c    |  2 +-
 drivers/staging/rtl8188eu/os_dep/usb_intf.c   |  6 +--
 13 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 1f232ba6651c..94c9d9f8ee5c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -82,7 +82,7 @@ static void update_BCNTIM(struct adapter *padapter)
 
 		/* calculate head_len */
 		offset = _FIXED_IE_LENGTH_;
-		offset += pnetwork_mlmeext->Ssid.SsidLength + 2;
+		offset += pnetwork_mlmeext->ssid.ssid_length + 2;
 
 		/*  get supported rates len */
 		p = rtw_get_ie(pie + _BEACON_IE_OFFSET_, _SUPPORTEDRATES_IE_,
@@ -785,9 +785,9 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/* SSID */
 	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _SSID_IE_, &ie_len, (pbss_network->ie_length - _BEACON_IE_OFFSET_));
 	if (p && ie_len > 0) {
-		memset(&pbss_network->Ssid, 0, sizeof(struct ndis_802_11_ssid));
-		memcpy(pbss_network->Ssid.Ssid, (p + 2), ie_len);
-		pbss_network->Ssid.SsidLength = ie_len;
+		memset(&pbss_network->ssid, 0, sizeof(struct ndis_802_11_ssid));
+		memcpy(pbss_network->ssid.ssid, (p + 2), ie_len);
+		pbss_network->ssid.ssid_length = ie_len;
 	}
 
 	/* channel */
diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 407f65cf7150..83a2e58aef53 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -263,7 +263,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 		int i;
 
 		for (i = 0; i < ssid_num && i < RTW_SSID_SCAN_AMOUNT; i++) {
-			if (ssid[i].SsidLength) {
+			if (ssid[i].ssid_length) {
 				memcpy(&psurveyPara->ssid[i], &ssid[i], sizeof(struct ndis_802_11_ssid));
 				psurveyPara->ssid_num++;
 			}
@@ -316,10 +316,10 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 
 	led_control_8188eu(padapter, LED_CTL_START_TO_LINK);
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0)
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for Any SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
+	if (pmlmepriv->assoc_ssid.ssid_length == 0)
+		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for Any SSid:%s\n", pmlmepriv->assoc_ssid.ssid));
 	else
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
+		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for SSid:%s\n", pmlmepriv->assoc_ssid.ssid));
 
 	pcmd = kzalloc(sizeof(*pcmd), GFP_ATOMIC);
 	if (!pcmd) {
@@ -358,10 +358,10 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	led_control_8188eu(padapter, LED_CTL_START_TO_LINK);
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0)
+	if (pmlmepriv->assoc_ssid.ssid_length == 0)
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("+Join cmd: Any SSid\n"));
 	else
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+Join cmd: SSid =[%s]\n", pmlmepriv->assoc_ssid.Ssid));
+		RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+Join cmd: SSid =[%s]\n", pmlmepriv->assoc_ssid.ssid));
 
 	pcmd = kzalloc(sizeof(*pcmd), GFP_ATOMIC);
 	if (!pcmd) {
diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 5c4ff81987bd..6ef67c25fdb7 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -234,7 +234,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	ie += 2;
 
 	/* SSID */
-	ie = rtw_set_ie(ie, _SSID_IE_, pdev_network->Ssid.SsidLength, pdev_network->Ssid.Ssid, &sz);
+	ie = rtw_set_ie(ie, _SSID_IE_, pdev_network->ssid.ssid_length, pdev_network->ssid.ssid, &sz);
 
 	/* supported rates */
 	if (pregistrypriv->wireless_mode == WIRELESS_11ABGN) {
@@ -975,9 +975,9 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
 	}
 	rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.ie_length, NULL, &rsn_len, NULL, &wpa_len);
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: ssid =%s\n", __func__, pnetwork->network.Ssid.Ssid));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: ssid =%s\n", __func__, pnetwork->network.ssid.ssid));
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: wpa_len =%d rsn_len =%d\n", __func__, wpa_len, rsn_len));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: ssid =%s\n", __func__, pnetwork->network.Ssid.Ssid));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: ssid =%s\n", __func__, pnetwork->network.ssid.ssid));
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: wpa_len =%d rsn_len =%d\n", __func__, wpa_len, rsn_len));
 
 	if (rsn_len > 0) {
diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index 0b3eb0b40975..7d56767cdff6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -77,7 +77,7 @@ u8 rtw_do_join(struct adapter *padapter)
 
 				pibss = padapter->registrypriv.dev_network.MacAddress;
 
-				memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
+				memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 				rtw_update_registrypriv_dev_network(padapter);
 
@@ -208,7 +208,7 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	struct wlan_network *pnetwork = &pmlmepriv->cur_network;
 
 	DBG_88E_LEVEL(_drv_info_, "set ssid [%s] fw_state=0x%08x\n",
-		      ssid->Ssid, get_fwstate(pmlmepriv));
+		      ssid->ssid, get_fwstate(pmlmepriv));
 
 	if (!padapter->hw_init_completed) {
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
@@ -229,8 +229,8 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
 			 ("set_ssid: _FW_LINKED||WIFI_ADHOC_MASTER_STATE\n"));
 
-		if (pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength &&
-		    !memcmp(&pmlmepriv->assoc_ssid.Ssid, ssid->Ssid, ssid->SsidLength)) {
+		if (pmlmepriv->assoc_ssid.ssid_length == ssid->ssid_length &&
+		    !memcmp(&pmlmepriv->assoc_ssid.ssid, ssid->ssid, ssid->ssid_length)) {
 			if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
 					 ("Set SSID is the same ssid, fw_state = 0x%08x\n",
@@ -257,8 +257,8 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 			}
 		} else {
 			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("Set SSID not the same ssid\n"));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_ssid =[%s] len = 0x%x\n", ssid->Ssid, (unsigned int)ssid->SsidLength));
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("assoc_ssid =[%s] len = 0x%x\n", pmlmepriv->assoc_ssid.Ssid, (unsigned int)pmlmepriv->assoc_ssid.SsidLength));
+			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("set_ssid =[%s] len = 0x%x\n", ssid->ssid, (unsigned int)ssid->ssid_length));
+			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("assoc_ssid =[%s] len = 0x%x\n", pmlmepriv->assoc_ssid.ssid, (unsigned int)pmlmepriv->assoc_ssid.ssid_length));
 
 			rtw_disassoc_cmd(padapter, 0, true);
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 714f7a70ed64..ca0cf8a86671 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -300,8 +300,8 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 
 static int is_same_ess(struct wlan_bssid_ex *a, struct wlan_bssid_ex *b)
 {
-	return (a->Ssid.SsidLength == b->Ssid.SsidLength) &&
-	       !memcmp(a->Ssid.Ssid, b->Ssid.Ssid, a->Ssid.SsidLength);
+	return (a->ssid.ssid_length == b->ssid.ssid_length) &&
+	       !memcmp(a->ssid.ssid, b->ssid.ssid, a->ssid.ssid_length);
 }
 
 int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst)
@@ -315,9 +315,9 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst)
 	s_cap = le16_to_cpu(le_scap);
 	d_cap = le16_to_cpu(le_dcap);
 
-	return ((src->Ssid.SsidLength == dst->Ssid.SsidLength) &&
+	return ((src->ssid.ssid_length == dst->ssid.ssid_length) &&
 		(!memcmp(src->MacAddress, dst->MacAddress, ETH_ALEN)) &&
-		(!memcmp(src->Ssid.Ssid, dst->Ssid.Ssid, src->Ssid.SsidLength)) &&
+		(!memcmp(src->ssid.ssid, dst->ssid.ssid, src->ssid.ssid_length)) &&
 		((s_cap & WLAN_CAPABILITY_IBSS) ==
 		(d_cap & WLAN_CAPABILITY_IBSS)) &&
 		((s_cap & WLAN_CAPABILITY_ESS) ==
@@ -558,7 +558,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 	pnetwork = (struct wlan_bssid_ex *)pbuf;
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("%s, ssid=%s\n", __func__, pnetwork->Ssid.Ssid));
+		 ("%s, ssid=%s\n", __func__, pnetwork->ssid.ssid));
 
 	len = get_wlan_bssid_ex_sz(pnetwork);
 	if (len > (sizeof(struct wlan_bssid_ex))) {
@@ -587,8 +587,8 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	/*  lock pmlmepriv->lock when you accessing network_q */
 	if (!check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
-		if (pnetwork->Ssid.Ssid[0] == 0)
-			pnetwork->Ssid.SsidLength = 0;
+		if (pnetwork->ssid.ssid[0] == 0)
+			pnetwork->ssid.ssid_length = 0;
 		rtw_add_network(adapter, pnetwork);
 	}
 
@@ -636,7 +636,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("switching to adhoc master\n"));
 
-					memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
+					memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 					rtw_update_registrypriv_dev_network(adapter);
 					rtw_generate_random_ibss(pibss);
@@ -741,7 +741,7 @@ void rtw_free_assoc_resources_locked(struct adapter *adapter)
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+rtw_free_assoc_resources\n"));
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
 		 ("tgt_network->network.MacAddress=%pM ssid=%s\n",
-		 tgt_network->network.MacAddress, tgt_network->network.Ssid.Ssid));
+		 tgt_network->network.MacAddress, tgt_network->network.ssid.ssid));
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_AP_STATE)) {
 		struct sta_info *psta;
@@ -975,10 +975,10 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 
 	rtw_get_encrypt_decrypt_from_registrypriv(adapter);
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0)
+	if (pmlmepriv->assoc_ssid.ssid_length == 0)
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   joinbss event call back  for Any SSid\n"));
 	else
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   rtw_joinbss_event_callback for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
+		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("@@@@@   rtw_joinbss_event_callback for SSid:%s\n", pmlmepriv->assoc_ssid.ssid));
 
 	the_same_macaddr = !memcmp(pnetwork->network.MacAddress, cur_network->network.MacAddress, ETH_ALEN);
 
@@ -1279,7 +1279,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 
 			memcpy(pdev_network, &tgt_network->network, get_wlan_bssid_ex_sz(&tgt_network->network));
 
-			memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
+			memcpy(&pdev_network->ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 			rtw_update_registrypriv_dev_network(adapter);
 
@@ -1422,9 +1422,9 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 	}
 
 	/* check ssid, if needed */
-	if (pmlmepriv->assoc_ssid.SsidLength) {
-		if (competitor->network.Ssid.SsidLength != pmlmepriv->assoc_ssid.SsidLength ||
-		    memcmp(competitor->network.Ssid.Ssid, pmlmepriv->assoc_ssid.Ssid, pmlmepriv->assoc_ssid.SsidLength))
+	if (pmlmepriv->assoc_ssid.ssid_length) {
+		if (competitor->network.ssid.ssid_length != pmlmepriv->assoc_ssid.ssid_length ||
+		    memcmp(competitor->network.ssid.ssid, pmlmepriv->assoc_ssid.ssid, pmlmepriv->assoc_ssid.ssid_length))
 			goto exit;
 	}
 
@@ -1445,8 +1445,8 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 	if (updated) {
 		DBG_88E("[by_bssid:%u][assoc_ssid:%s]new candidate: %s(%pM rssi:%d\n",
 			pmlmepriv->assoc_by_bssid,
-			pmlmepriv->assoc_ssid.Ssid,
-			(*candidate)->network.Ssid.Ssid,
+			pmlmepriv->assoc_ssid.ssid,
+			(*candidate)->network.ssid.ssid,
 			(*candidate)->network.MacAddress,
 			(int)(*candidate)->network.Rssi);
 		DBG_88E("[to_roaming:%u]\n", pmlmepriv->to_roaming);
@@ -1493,7 +1493,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 		goto exit;
 	} else {
 		DBG_88E("%s: candidate: %s(%pM ch:%u)\n", __func__,
-			candidate->network.Ssid.Ssid, candidate->network.MacAddress,
+			candidate->network.ssid.ssid, candidate->network.MacAddress,
 			candidate->network.Configuration.DSConfig);
 	}
 
@@ -1772,7 +1772,7 @@ void rtw_init_registrypriv_dev_network(struct adapter *adapter)
 
 	memcpy(pdev_network->MacAddress, myhwaddr, ETH_ALEN);
 
-	memcpy(&pdev_network->Ssid, &pregistrypriv->ssid, sizeof(struct ndis_802_11_ssid));
+	memcpy(&pdev_network->ssid, &pregistrypriv->ssid, sizeof(struct ndis_802_11_ssid));
 
 	pdev_network->Configuration.Length = sizeof(struct ndis_802_11_config);
 	pdev_network->Configuration.BeaconPeriod = 100;
@@ -2049,9 +2049,9 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 
 	if (pmlmepriv->to_roaming > 0) {
 		DBG_88E("roaming from %s(%pM length:%d\n",
-			pnetwork->network.Ssid.Ssid, pnetwork->network.MacAddress,
-			pnetwork->network.Ssid.SsidLength);
-		memcpy(&pmlmepriv->assoc_ssid, &pnetwork->network.Ssid, sizeof(struct ndis_802_11_ssid));
+			pnetwork->network.ssid.ssid, pnetwork->network.MacAddress,
+			pnetwork->network.ssid.ssid_length);
+		memcpy(&pmlmepriv->assoc_ssid, &pnetwork->network.ssid, sizeof(struct ndis_802_11_ssid));
 
 		pmlmepriv->assoc_by_bssid = false;
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 7a36661ebbed..8f28aefbe6f9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -402,7 +402,7 @@ static void issue_beacon(struct adapter *padapter, int timeout_ms)
 	pattrib->pktlen += 2;
 
 	/*  SSID */
-	pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pattrib->pktlen);
+	pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->ssid.ssid_length, cur_network->ssid.ssid, &pattrib->pktlen);
 
 	/*  supported rates... */
 	rate_len = rtw_get_rateset_len(cur_network->SupportedRates);
@@ -562,7 +562,7 @@ static void issue_probersp(struct adapter *padapter, unsigned char *da)
 		/* below for ad-hoc mode */
 
 		/*  SSID */
-		pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->ssid.ssid_length, cur_network->ssid.ssid, &pattrib->pktlen);
 
 		/*  supported rates... */
 		rate_len = rtw_get_rateset_len(cur_network->SupportedRates);
@@ -652,7 +652,7 @@ static int issue_probereq(struct adapter *padapter,
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	if (pssid)
-		pframe = rtw_set_ie(pframe, _SSID_IE_, pssid->SsidLength, pssid->Ssid, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, _SSID_IE_, pssid->ssid_length, pssid->ssid, &pattrib->pktlen);
 	else
 		pframe = rtw_set_ie(pframe, _SSID_IE_, 0, NULL, &pattrib->pktlen);
 
@@ -1059,7 +1059,7 @@ static void issue_assocreq(struct adapter *padapter)
 	pattrib->pktlen += 2;
 
 	/* SSID */
-	pframe = rtw_set_ie(pframe, _SSID_IE_,  pmlmeinfo->network.Ssid.SsidLength, pmlmeinfo->network.Ssid.Ssid, &pattrib->pktlen);
+	pframe = rtw_set_ie(pframe, _SSID_IE_,  pmlmeinfo->network.ssid.ssid_length, pmlmeinfo->network.ssid.ssid, &pattrib->pktlen);
 
 	/* supported rate & extended supported rate */
 
@@ -1929,7 +1929,7 @@ static void site_survey(struct adapter *padapter)
 			int i;
 
 			for (i = 0; i < RTW_SSID_SCAN_AMOUNT; i++) {
-				if (pmlmeext->sitesurvey_res.ssid[i].SsidLength) {
+				if (pmlmeext->sitesurvey_res.ssid[i].ssid_length) {
 					/* todo: to issue two probe req??? */
 					issue_probereq(padapter,
 					&(pmlmeext->sitesurvey_res.ssid[i]),
@@ -2071,10 +2071,10 @@ static u8 collect_bss_info(struct adapter *padapter,
 			DBG_88E("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
 			return _FAIL;
 		}
-		memcpy(bssid->Ssid.Ssid, (p + 2), len);
-		bssid->Ssid.SsidLength = len;
+		memcpy(bssid->ssid.ssid, (p + 2), len);
+		bssid->ssid.ssid_length = len;
 	} else {
-		bssid->Ssid.SsidLength = 0;
+		bssid->ssid.ssid_length = 0;
 	}
 
 	memset(bssid->SupportedRates, 0, NDIS_802_11_LENGTH_RATES_EX);
@@ -2526,7 +2526,7 @@ static unsigned int OnProbeReq(struct adapter *padapter,
 
 	/* check (wildcard) SSID */
 	if (p) {
-		if ((ielen != 0 && memcmp((void *)(p+2), (void *)cur->Ssid.Ssid, cur->Ssid.SsidLength)) ||
+		if ((ielen != 0 && memcmp((void *)(p+2), (void *)cur->ssid.ssid, cur->ssid.ssid_length)) ||
 		    (ielen == 0 && pmlmeinfo->hidden_ssid_mode))
 			return _SUCCESS;
 
@@ -2975,10 +2975,10 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 		goto OnAssocReqFail;
 	} else {
 		/*  check if ssid match */
-		if (memcmp((void *)(p+2), cur->Ssid.Ssid, cur->Ssid.SsidLength))
+		if (memcmp((void *)(p+2), cur->ssid.ssid, cur->ssid.ssid_length))
 			status = _STATS_FAILURE_;
 
-		if (ie_len != cur->Ssid.SsidLength)
+		if (ie_len != cur->ssid.ssid_length)
 			status = _STATS_FAILURE_;
 	}
 
@@ -4658,7 +4658,7 @@ void linked_status_chk(struct adapter *padapter)
 				}
 
 				if (rx_chk != _SUCCESS)
-					issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, psta->hwaddr, 3, 1);
+					issue_probereq_ex(padapter, &pmlmeinfo->network.ssid, psta->hwaddr, 3, 1);
 
 				if ((tx_chk != _SUCCESS && pmlmeinfo->link_count++ == 0xf) || rx_chk != _SUCCESS) {
 					tx_chk = issue_nulldata(padapter, psta->hwaddr, 0, 3, 1);
@@ -4674,15 +4674,15 @@ void linked_status_chk(struct adapter *padapter)
 				if (rx_chk != _SUCCESS) {
 					if (pmlmeext->retry == 0) {
 						issue_probereq(padapter,
-						&pmlmeinfo->network.Ssid,
+						&pmlmeinfo->network.ssid,
 						pmlmeinfo->network.MacAddress,
 									false);
 						issue_probereq(padapter,
-						&pmlmeinfo->network.Ssid,
+						&pmlmeinfo->network.ssid,
 						pmlmeinfo->network.MacAddress,
 									false);
 						issue_probereq(padapter,
-						&pmlmeinfo->network.Ssid,
+						&pmlmeinfo->network.ssid,
 						pmlmeinfo->network.MacAddress,
 									false);
 					}
@@ -5136,11 +5136,11 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 		pmlmeext->sitesurvey_res.channel_idx = 0;
 
 		for (i = 0; i < RTW_SSID_SCAN_AMOUNT; i++) {
-			if (pparm->ssid[i].SsidLength) {
-				memcpy(pmlmeext->sitesurvey_res.ssid[i].Ssid, pparm->ssid[i].Ssid, IW_ESSID_MAX_SIZE);
-				pmlmeext->sitesurvey_res.ssid[i].SsidLength = pparm->ssid[i].SsidLength;
+			if (pparm->ssid[i].ssid_length) {
+				memcpy(pmlmeext->sitesurvey_res.ssid[i].ssid, pparm->ssid[i].ssid, IW_ESSID_MAX_SIZE);
+				pmlmeext->sitesurvey_res.ssid[i].ssid_length = pparm->ssid[i].ssid_length;
 			} else {
-				pmlmeext->sitesurvey_res.ssid[i].SsidLength = 0;
+				pmlmeext->sitesurvey_res.ssid[i].ssid_length = 0;
 			}
 		}
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 5f9c9de1f1da..4480deef95a1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -935,17 +935,17 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 		if (ssid_len > NDIS_802_11_LENGTH_SSID)
 			ssid_len = 0;
 	}
-	memcpy(bssid->Ssid.Ssid, (p + 2), ssid_len);
-	bssid->Ssid.SsidLength = ssid_len;
+	memcpy(bssid->ssid.ssid, (p + 2), ssid_len);
+	bssid->ssid.ssid_length = ssid_len;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s bssid.Ssid.Ssid:%s bssid.Ssid.SsidLength:%d "
-				"cur_network->network.Ssid.Ssid:%s len:%d\n", __func__, bssid->Ssid.Ssid,
-				bssid->Ssid.SsidLength, cur_network->network.Ssid.Ssid,
-				cur_network->network.Ssid.SsidLength));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s bssid.ssid.ssid:%s bssid.ssid.ssid_length:%d "
+				"cur_network->network.ssid.ssid:%s len:%d\n", __func__, bssid->ssid.ssid,
+				bssid->ssid.ssid_length, cur_network->network.ssid.ssid,
+				cur_network->network.ssid.ssid_length));
 
-	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
-	    bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength) {
-		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) { /* not hidden ssid */
+	if (memcmp(bssid->ssid.ssid, cur_network->network.ssid.ssid, 32) ||
+	    bssid->ssid.ssid_length != cur_network->network.ssid.ssid_length) {
+		if (bssid->ssid.ssid[0] != '\0' && bssid->ssid.ssid_length != 0) { /* not hidden ssid */
 			DBG_88E("%s(), SSID is not match return FAIL\n", __func__);
 			goto _mismatch;
 		}
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
index 7022221136f6..491d948e9f2a 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
@@ -257,7 +257,7 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	/* below for ad-hoc mode */
 
 	/*  SSID */
-	pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pktlen);
+	pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->ssid.ssid_length, cur_network->ssid.ssid, &pktlen);
 
 	/*  supported rates... */
 	rate_len = rtw_get_rateset_len(cur_network->SupportedRates);
diff --git a/drivers/staging/rtl8188eu/include/wlan_bssdef.h b/drivers/staging/rtl8188eu/include/wlan_bssdef.h
index 5e13a6ddf083..8462c9c2fd39 100644
--- a/drivers/staging/rtl8188eu/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8188eu/include/wlan_bssdef.h
@@ -17,8 +17,8 @@
 #define NDIS_802_11_RSSI long           /*  in dBm */
 
 struct ndis_802_11_ssid {
-	u32  SsidLength;
-	u8  Ssid[32];
+	u32  ssid_length;
+	u8  ssid[32];
 };
 
 enum NDIS_802_11_NETWORK_TYPE {
@@ -180,7 +180,7 @@ struct wlan_bssid_ex {
 	u32  Length;
 	unsigned char MacAddress[ETH_ALEN];
 	u8  Reserved[2];/* 0]: IS beacon frame */
-	struct ndis_802_11_ssid  Ssid;
+	struct ndis_802_11_ssid  ssid;
 	u32  Privacy;
 	NDIS_802_11_RSSI  Rssi;/* in dBM,raw data ,get from PHY) */
 	enum  NDIS_802_11_NETWORK_TYPE  NetworkTypeInUse;
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index efaa1c779f4b..eaa4adb32a0d 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -116,8 +116,8 @@ static char *translate_scan(struct adapter *padapter,
 	/* Add the ESSID */
 	iwe.cmd = SIOCGIWESSID;
 	iwe.u.data.flags = 1;
-	iwe.u.data.length = min_t(u16, pnetwork->network.Ssid.SsidLength, 32);
-	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.Ssid.Ssid);
+	iwe.u.data.length = min_t(u16, pnetwork->network.ssid.ssid_length, 32);
+	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.ssid.ssid);
 
 	/* parsing HT_CAP_IE */
 	p = rtw_get_ie(&pnetwork->network.ies[12], _HT_CAPABILITY_IE_, &ht_ielen, pnetwork->network.ie_length-12);
@@ -195,7 +195,7 @@ static char *translate_scan(struct adapter *padapter,
 	else
 		iwe.u.data.flags = IW_ENCODE_DISABLED;
 	iwe.u.data.length = 0;
-	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.Ssid.Ssid);
+	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.ssid.ssid);
 
 	/*Add basic and extended rates */
 	max_rate = 0;
@@ -235,7 +235,7 @@ static char *translate_scan(struct adapter *padapter,
 		u8 *p;
 
 		rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.ie_length, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.Ssid.Ssid));
+		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.ssid.ssid));
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 
 		if (wpa_len > 0) {
@@ -1124,8 +1124,8 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 			int len = min_t(int, req->essid_len,
 					IW_ESSID_MAX_SIZE);
 
-			memcpy(ssid[0].Ssid, req->essid, len);
-			ssid[0].SsidLength = len;
+			memcpy(ssid[0].ssid, req->essid, len);
+			ssid[0].ssid_length = len;
 
 			DBG_88E("IW_SCAN_THIS_ESSID, ssid =%s, len =%d\n", req->essid, req->essid_len);
 
@@ -1158,8 +1158,8 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 					}
 					sec_len = *(pos++); len -= 1;
 					if (sec_len > 0 && sec_len <= len) {
-						ssid[ssid_index].SsidLength = sec_len;
-						memcpy(ssid[ssid_index].Ssid, pos, ssid[ssid_index].SsidLength);
+						ssid[ssid_index].ssid_length = sec_len;
+						memcpy(ssid[ssid_index].ssid, pos, ssid[ssid_index].ssid_length);
 						ssid_index++;
 					}
 					pos += sec_len;
@@ -1310,9 +1310,9 @@ static int rtw_wx_set_essid(struct net_device *dev,
 			DBG_88E("ssid =%s, len =%d\n", extra, wrqu->essid.length);
 
 		memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
-		ndis_ssid.SsidLength = len;
-		memcpy(ndis_ssid.Ssid, extra, len);
-		src_ssid = ndis_ssid.Ssid;
+		ndis_ssid.ssid_length = len;
+		memcpy(ndis_ssid.ssid, extra, len);
+		src_ssid = ndis_ssid.ssid;
 
 		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("rtw_wx_set_essid: ssid =[%s]\n", src_ssid));
 		spin_lock_bh(&queue->lock);
@@ -1324,14 +1324,14 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 			pmlmepriv->pscanned = pmlmepriv->pscanned->next;
 
-			dst_ssid = pnetwork->network.Ssid.Ssid;
+			dst_ssid = pnetwork->network.ssid.ssid;
 
 			RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
 				 ("rtw_wx_set_essid: dst_ssid =%s\n",
-				  pnetwork->network.Ssid.Ssid));
+				  pnetwork->network.ssid.ssid));
 
-			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength)) &&
-			    (pnetwork->network.Ssid.SsidLength == ndis_ssid.SsidLength)) {
+			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.ssid_length)) &&
+			    (pnetwork->network.ssid.ssid_length == ndis_ssid.ssid_length)) {
 				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
 					 ("rtw_wx_set_essid: find match, set infra mode\n"));
 
@@ -1378,8 +1378,8 @@ static int rtw_wx_get_essid(struct net_device *dev,
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED)) ||
 	    (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))) {
-		len = pcur_bss->Ssid.SsidLength;
-		memcpy(extra, pcur_bss->Ssid.Ssid, len);
+		len = pcur_bss->ssid.ssid_length;
+		memcpy(extra, pcur_bss->ssid.ssid, len);
 	} else {
 		len = 0;
 		*extra = 0;
diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index abcce2240f15..5389b67bf340 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -141,8 +141,8 @@ static void loadparam(struct adapter *padapter, struct net_device *pnetdev)
 
 	GlobalDebugLevel = rtw_debug;
 
-	memcpy(registry_par->ssid.Ssid, "ANY", 3);
-	registry_par->ssid.SsidLength = 3;
+	memcpy(registry_par->ssid.ssid, "ANY", 3);
+	registry_par->ssid.ssid_length = 3;
 
 	registry_par->channel = (u8)rtw_channel;
 	registry_par->wireless_mode = (u8)rtw_wireless_mode;
diff --git a/drivers/staging/rtl8188eu/os_dep/rtw_android.c b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
index 2ea2af3286bc..7a090615dcbc 100644
--- a/drivers/staging/rtl8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
@@ -84,7 +84,7 @@ static int rtw_android_get_rssi(struct net_device *net, char *command,
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 		bytes_written += snprintf(&command[bytes_written], total_len,
 					  "%s rssi %d",
-					  pcur_network->network.Ssid.Ssid,
+					  pcur_network->network.ssid.ssid,
 					  padapter->recvpriv.rssi);
 	}
 	return bytes_written;
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index 28cbd6b3d26c..1859ec3281e8 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -227,10 +227,10 @@ static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 	    check_fwstate(pmlmepriv, _FW_LINKED)) {
 		pr_debug("%s:%d %s(%pM), length:%d assoc_ssid.length:%d\n",
 			__func__, __LINE__,
-			pmlmepriv->cur_network.network.Ssid.Ssid,
+			pmlmepriv->cur_network.network.ssid.ssid,
 			pmlmepriv->cur_network.network.MacAddress,
-			pmlmepriv->cur_network.network.Ssid.SsidLength,
-			pmlmepriv->assoc_ssid.SsidLength);
+			pmlmepriv->cur_network.network.ssid.ssid_length,
+			pmlmepriv->assoc_ssid.ssid_length);
 
 		pmlmepriv->to_roaming = 1;
 	}
-- 
2.19.2

