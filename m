Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF066C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A86821A57
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pDBZldag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A86821A57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbeHFQse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:48:34 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35500 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFQse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:48:34 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7D4BD1AD2;
        Mon,  6 Aug 2018 16:39:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533566348;
        bh=gebXP2sTlnbmpxh8YER9DxFgU1BjD5NEsaI3ibTzCbI=;
        h=From:To:Cc:Subject:Date:From;
        b=pDBZldag7NZ+iV9M0OQJBdL7N7laTR33ivVGp8fgA94BVXKH/q2RwRslEqYees/Kp
         ewss7Y3kjd3lbNjlo8kZxz9exV7MtZvQTXL6fxk6h179Ul5nXYgaFskx5Ka0hwkF5H
         ZDvqDNvYX2FyPXED/4TNc/JhhfAZKeKXnkNqgAf4=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        kbingham@kernel.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/4] MAINTAINERS: rcar-du: Add co-maintainer
Date:   Mon,  6 Aug 2018 15:39:01 +0100
Message-Id: <20180806143904.4716-1-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Add myself as a co-maintainer for the Renesas DRM drivers.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7cebd5bba8a8..c7cecb9201b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4764,6 +4764,7 @@ F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
 
 DRM DRIVERS FOR RENESAS
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
 L:	dri-devel@lists.freedesktop.org
 L:	linux-renesas-soc@vger.kernel.org
 T:	git git://linuxtv.org/pinchartl/fbdev
-- 
2.17.1

