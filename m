Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9BCC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A4020866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeL3Qaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:30:30 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52542
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726499AbeL3QaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:30:03 -0500
X-IronPort-AV: E=Sophos;i="5.56,417,1539640800"; 
   d="scan'208";a="290435982"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 30 Dec 2018 17:29:58 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: rtl8192e: reduce indentation
Date:   Sun, 30 Dec 2018 16:53:12 +0100
Message-Id: <1546185195-25676-6-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete tab aligning a statement with the right hand side of a
preceding assignment rather than the left hand side.

Found with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 843e874b8a06..b798cde0ce47 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -1049,9 +1049,9 @@ static int _rtl92e_wx_set_promisc_mode(struct net_device *dev,
 					(bPromiscuousOn) ? (true) : (false);
 		ieee->IntelPromiscuousModeInfo.bFilterSourceStationFrame =
 			(bFilterSourceStationFrame) ? (true) : (false);
-			(bPromiscuousOn) ?
-			(rtllib_EnableIntelPromiscuousMode(dev, false)) :
-			(rtllib_DisableIntelPromiscuousMode(dev, false));
+		(bPromiscuousOn) ?
+		(rtllib_EnableIntelPromiscuousMode(dev, false)) :
+		(rtllib_DisableIntelPromiscuousMode(dev, false));
 
 		netdev_info(dev,
 			    "=======>%s(), on = %d, filter src sta = %d\n",

