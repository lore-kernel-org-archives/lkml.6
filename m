Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9894EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5FD20867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5FD20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeH1Lfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:35:37 -0400
Received: from regular1.263xmail.com ([211.150.99.130]:43562 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbeH1Lfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:35:36 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.243])
        by regular1.263xmail.com (Postfix) with ESMTP id 68AA1386;
        Tue, 28 Aug 2018 15:45:06 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id A6D533B5;
        Tue, 28 Aug 2018 15:45:04 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <e5a0c8f78753285eb91e55a52e5d8304>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 529471UGQS;
        Tue, 28 Aug 2018 15:45:05 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     hjc@rock-chips.com, heiko@sntech.de, eballetbo@gmail.com,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/rockchip: fix coding style and incorrect description
Date:   Tue, 28 Aug 2018 15:44:55 +0800
Message-Id: <1535442295-4007-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align with other drivers, tab + 2 space key for description.
and edp/hdmi/dsi can be used on both rk3288 and rk3399.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/rockchip/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 0ccc762..0534dc1 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -23,7 +23,7 @@ config ROCKCHIP_ANALOGIX_DP
 	help
 	  This selects support for Rockchip SoC specific extensions
 	  for the Analogix Core DP driver. If you want to enable DP
-	  on RK3288 based SoC, you should selet this option.
+	  on RK3288 or RK3399 based SoC, you should select this option.
 
 config ROCKCHIP_CDN_DP
         bool "Rockchip cdn DP"
@@ -39,16 +39,16 @@ config ROCKCHIP_DW_HDMI
         help
 	  This selects support for Rockchip SoC specific extensions
 	  for the Synopsys DesignWare HDMI driver. If you want to
-	  enable HDMI on RK3288 based SoC, you should selet this
-	  option.
+	  enable HDMI on RK3288 or RK3399 based SoC, you should select
+	  this option.
 
 config ROCKCHIP_DW_MIPI_DSI
 	bool "Rockchip specific extensions for Synopsys DW MIPI DSI"
 	help
-	 This selects support for Rockchip SoC specific extensions
-	 for the Synopsys DesignWare HDMI driver. If you want to
-	 enable MIPI DSI on RK3288 based SoC, you should selet this
-	 option.
+	  This selects support for Rockchip SoC specific extensions
+	  for the Synopsys DesignWare HDMI driver. If you want to
+	  enable MIPI DSI on RK3288 or RK3399 based SoC, you should
+	  select this option.
 
 config ROCKCHIP_INNO_HDMI
 	bool "Rockchip specific extensions for Innosilicon HDMI"
-- 
2.7.4


