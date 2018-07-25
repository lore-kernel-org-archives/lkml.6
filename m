Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F6FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95465205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IKkAPCme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95465205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeGYGiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 02:38:07 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:45943 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbeGYGiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 02:38:06 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6P5Q1Vc024396;
        Wed, 25 Jul 2018 14:26:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6P5Q1Vc024396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532496362;
        bh=6O9GvOVK2R4FYNjE+jljup77Yii+O/MjJwGvpF2yjJM=;
        h=From:To:Cc:Subject:Date:From;
        b=IKkAPCmejUJlmeimUlLIih38XpZ8wrz7w4Qez7pag2u0dAXsXW9cbLZoyL7ONX17b
         YS5Mzkhu/O6CSzUlu3drZ7yG5k+WIGazZFFqAHSIa+5SJzr+63qDp266iN9uYZnoKr
         /ZejpwZtJVyDvZiMi456DNgypXD9g+R0PT09+KknMtHA6f+9sLoaC69Q5cQ1nYlBdR
         PAljduHfbLEtbw0PRu/cw2fsqYK6qWUsD6WXBU9xPuDxR0fYgOlEYwlwxv3GlMrD1d
         G5qyM+8qssuSAY5MPkSSYzd4PyPUeL37pjWkHLeKMztiAsK8qIek577xevDszrAmaa
         zy67K/k6iTdLA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        David Airlie <airlied@linux.ie>
Subject: [RESEND PATCH] drm/bridge/synopsys: remove commented-out flag in Makefile
Date:   Wed, 25 Jul 2018 14:25:48 +0900
Message-Id: <1532496348-11589-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not comment out unneeded code.  Remove.

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

