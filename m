Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A0DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EBB20C51
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EBB20C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeH0KVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:21:48 -0400
Received: from regular1.263xmail.com ([211.150.99.135]:50212 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbeH0KVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:21:48 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Aug 2018 06:21:21 EDT
Received: from hjc?rock-chips.com (unknown [192.168.167.190])
        by regular1.263xmail.com (Postfix) with ESMTP id 086BD327;
        Mon, 27 Aug 2018 14:30:01 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 6F9133D9;
        Mon, 27 Aug 2018 14:29:59 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <03f3bf580d79db24b8806a5e315dcc54>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 2678RDZM5D;
        Mon, 27 Aug 2018 14:30:00 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     hjc@rock-chips.com, heiko@sntech.de,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: fix coding style and incorrect description
Date:   Mon, 27 Aug 2018 14:29:38 +0800
Message-Id: <1535351378-128643-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align with other drivers, tab + 2 space key for description.
and this option should be enabled on both rk3288 and rk3399.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/rockchip/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 0ccc762..601234b 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -45,10 +45,10 @@ config ROCKCHIP_DW_HDMI
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
+	  selet this option.
 
 config ROCKCHIP_INNO_HDMI
 	bool "Rockchip specific extensions for Innosilicon HDMI"
-- 
2.7.4


