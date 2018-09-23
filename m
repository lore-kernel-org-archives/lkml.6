Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404F4ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8B420870
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="m7GdLYWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8B420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=startmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeIWUbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 16:31:19 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:36308 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIWUbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 16:31:19 -0400
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Sep 2018 16:31:18 EDT
From:   "Marty E. Plummer" <hanetzer@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1537712678;
        bh=zH+KMSsN0O5EfXiMRkWeG7P43YRrD0ht5f7BrQVulDI=;
        h=From:To:Cc:Subject:Date:From;
        b=m7GdLYWXD17D8uCgaQCu+b7XqtWG8zl5xn02eVLF5KZeTHvF28tX8AIIKAWEy6dny
         vQ9MOy2E7xoEnkbvdUklLOS7oPap3E2LxWIsJpQTcinB8LR5O+1mGgaYkF9rhBlqyz
         e+VDQLFZmlDklht/u4j74h185/ZRnDfqtq1BgAQKCpdkRrKerOKiFigFgvDbG1BT1T
         BKyMf1PUOsZT67xDy0mDNsg1KdY95bOVp+VjW4Xqvoo1TaokISoBrVgNokIRTJtBdp
         m4FGnmv/AaqeNRHVDZsYhdJz4T0gWcYgzM9ySDv2O83Nq0/aj27j2bTBUsegyYRz5V
         b3wk6ku3ALPWQ==
To:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Marty E. Plummer" <hanetzer@startmail.com>
Subject: [PATCH] drm/rockchip: typo: selet->select
Date:   Sun, 23 Sep 2018 09:20:05 -0500
Message-Id: <20180923142005.23915-1-hanetzer@startmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
---
 drivers/gpu/drm/rockchip/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 0ccc76217ee4..7d1ccc9efc76 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -23,7 +23,7 @@ config ROCKCHIP_ANALOGIX_DP
 	help
 	  This selects support for Rockchip SoC specific extensions
 	  for the Analogix Core DP driver. If you want to enable DP
-	  on RK3288 based SoC, you should selet this option.
+	  on RK3288 based SoC, you should select this option.
 
 config ROCKCHIP_CDN_DP
         bool "Rockchip cdn DP"
@@ -39,7 +39,7 @@ config ROCKCHIP_DW_HDMI
         help
 	  This selects support for Rockchip SoC specific extensions
 	  for the Synopsys DesignWare HDMI driver. If you want to
-	  enable HDMI on RK3288 based SoC, you should selet this
+	  enable HDMI on RK3288 based SoC, you should select this
 	  option.
 
 config ROCKCHIP_DW_MIPI_DSI
@@ -47,7 +47,7 @@ config ROCKCHIP_DW_MIPI_DSI
 	help
 	 This selects support for Rockchip SoC specific extensions
 	 for the Synopsys DesignWare HDMI driver. If you want to
-	 enable MIPI DSI on RK3288 based SoC, you should selet this
+	 enable MIPI DSI on RK3288 based SoC, you should select this
 	 option.
 
 config ROCKCHIP_INNO_HDMI
-- 
2.19.0

