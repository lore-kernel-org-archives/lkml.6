Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060A5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E81C24052
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VwZPqqmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E81C24052
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbeGFFN3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:13:29 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:38367 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeGFFN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:13:27 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w665B8LR014667;
        Fri, 6 Jul 2018 14:11:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w665B8LR014667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530853869;
        bh=5F73Psfo/BVj7OZJj1EKxWxvKeVHYAGRamlczv/7Nu4=;
        h=From:To:Cc:Subject:Date:From;
        b=VwZPqqmbcetux9Hs4zt19D1VIr6YZ4rbaeoCQwQXMEq5LKZOIrShoGl6Ry+MXe18W
         zlzFY9Qu9fxFQTY7vBUQ0DqzKw1EpStMy6A/i/KByU8iAmS7gpSjNUIrKtJvstCp1/
         wOLsEk2qrpmE3IeL8TB2oKkgiLfCVbgAenJgPgRAVTJy6Y9RKTuoBXMRaWCsSAi91e
         gZ9gsp1ui1UtmPhHM9oPmpEVZRe4is+of0Ia3x3LT7/tix6A6PcYYIPxuUhAppW+h2
         lm91PtUfd5+ANTct9LokbjvYKujgC1hFWdTYxrQJRvHhht/H7XqnCiH7+zFDa/u1vU
         2KaDIB0YZwmvQ==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: [PATCH] drm/bridge/synopsys: remove commented-out flag in Makefile
Date:   Fri,  6 Jul 2018 14:10:50 +0900
Message-Id: <1530853850-11934-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not comment out unneeded code, but remove it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpu/drm/bridge/synopsys/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/Makefile b/drivers/gpu/drm/bridge/synopsys/Makefile
index 5dad97d..3e1b1e3 100644
--- a/drivers/gpu/drm/bridge/synopsys/Makefile
+++ b/drivers/gpu/drm/bridge/synopsys/Makefile
@@ -1,5 +1,3 @@
-#ccflags-y := -Iinclude/drm
-
 obj-$(CONFIG_DRM_DW_HDMI) += dw-hdmi.o
 obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw-hdmi-ahb-audio.o
 obj-$(CONFIG_DRM_DW_HDMI_I2S_AUDIO) += dw-hdmi-i2s-audio.o
-- 
2.7.4

