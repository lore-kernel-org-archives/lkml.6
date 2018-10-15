Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2475C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717792089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717792089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeJPGVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:21:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48635 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeJPGVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:21:52 -0400
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gCBRa-0006qM-JG; Mon, 15 Oct 2018 22:34:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: staging: rtl*: fix spelling mistake "Orginial" -> "Original"
Date:   Mon, 15 Oct 2018 23:34:33 +0100
Message-Id: <20181015223433.27972-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to common spelling mistakes in some rtl* drivers

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8188eu/hal/odm.c                  | 8 ++++----
 drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c   | 8 ++++----
 drivers/staging/rtlwifi/phydm/phydm_edcaturbocheck.c | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index 5a0c38ecb15e..9c8fa61c92ac 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -1025,10 +1025,10 @@ void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm)
 	pDM_Odm->DM_EDCA_Table.bIsCurRDLState = false;
 	Adapter->recvpriv.bIsAnyNonBEPkts = false;
 
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Orginial VO PARAM: 0x%x\n", usb_read32(Adapter, ODM_EDCA_VO_PARAM)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Orginial VI PARAM: 0x%x\n", usb_read32(Adapter, ODM_EDCA_VI_PARAM)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Orginial BE PARAM: 0x%x\n", usb_read32(Adapter, ODM_EDCA_BE_PARAM)));
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Orginial BK PARAM: 0x%x\n", usb_read32(Adapter, ODM_EDCA_BK_PARAM)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Original VO PARAM: 0x%x\n", usb_read32(Adapter, ODM_EDCA_VO_PARAM)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Original VI PARAM: 0x%x\n", usb_read32(Adapter, ODM_EDCA_VI_PARAM)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Original BE PARAM: 0x%x\n", usb_read32(Adapter, ODM_EDCA_BE_PARAM)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Original BK PARAM: 0x%x\n", usb_read32(Adapter, ODM_EDCA_BK_PARAM)));
 }	/*  ODM_InitEdcaTurbo */
 
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
diff --git a/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c b/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c
index 0e674f39ef03..b7ebce7a6ff9 100644
--- a/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c
+++ b/drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c
@@ -39,16 +39,16 @@ void ODM_EdcaTurboInit(void *pDM_VOID)
 	Adapter->recvpriv.bIsAnyNonBEPkts = false;
 
 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD,
-		     ("Orginial VO PARAM: 0x%x\n",
+		     ("Original VO PARAM: 0x%x\n",
 		      rtw_read32(pDM_Odm->Adapter, ODM_EDCA_VO_PARAM)));
 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD,
-		     ("Orginial VI PARAM: 0x%x\n",
+		     ("Original VI PARAM: 0x%x\n",
 		      rtw_read32(pDM_Odm->Adapter, ODM_EDCA_VI_PARAM)));
 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD,
-		     ("Orginial BE PARAM: 0x%x\n",
+		     ("Original BE PARAM: 0x%x\n",
 		      rtw_read32(pDM_Odm->Adapter, ODM_EDCA_BE_PARAM)));
 	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD,
-		     ("Orginial BK PARAM: 0x%x\n",
+		     ("Original BK PARAM: 0x%x\n",
 		      rtw_read32(pDM_Odm->Adapter, ODM_EDCA_BK_PARAM)));
 }	/*  ODM_InitEdcaTurbo */
 
diff --git a/drivers/staging/rtlwifi/phydm/phydm_edcaturbocheck.c b/drivers/staging/rtlwifi/phydm/phydm_edcaturbocheck.c
index cd12512628c0..b5bd4fb20c90 100644
--- a/drivers/staging/rtlwifi/phydm/phydm_edcaturbocheck.c
+++ b/drivers/staging/rtlwifi/phydm/phydm_edcaturbocheck.c
@@ -25,13 +25,13 @@ void odm_edca_turbo_init(void *dm_void)
 	dm->dm_edca_table.is_current_turbo_edca = false;
 	dm->dm_edca_table.is_cur_rdl_state = false;
 
-	ODM_RT_TRACE(dm, ODM_COMP_EDCA_TURBO, "Orginial VO PARAM: 0x%x\n",
+	ODM_RT_TRACE(dm, ODM_COMP_EDCA_TURBO, "Original VO PARAM: 0x%x\n",
 		     odm_read_4byte(dm, ODM_EDCA_VO_PARAM));
-	ODM_RT_TRACE(dm, ODM_COMP_EDCA_TURBO, "Orginial VI PARAM: 0x%x\n",
+	ODM_RT_TRACE(dm, ODM_COMP_EDCA_TURBO, "Original VI PARAM: 0x%x\n",
 		     odm_read_4byte(dm, ODM_EDCA_VI_PARAM));
-	ODM_RT_TRACE(dm, ODM_COMP_EDCA_TURBO, "Orginial BE PARAM: 0x%x\n",
+	ODM_RT_TRACE(dm, ODM_COMP_EDCA_TURBO, "Original BE PARAM: 0x%x\n",
 		     odm_read_4byte(dm, ODM_EDCA_BE_PARAM));
-	ODM_RT_TRACE(dm, ODM_COMP_EDCA_TURBO, "Orginial BK PARAM: 0x%x\n",
+	ODM_RT_TRACE(dm, ODM_COMP_EDCA_TURBO, "Original BK PARAM: 0x%x\n",
 		     odm_read_4byte(dm, ODM_EDCA_BK_PARAM));
 
 } /* ODM_InitEdcaTurbo */
-- 
2.19.1

