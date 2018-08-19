Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA27FC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 22:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13ED220BED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 22:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="h2kxhdpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ED220BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeHTB0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 21:26:25 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56070 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeHTB0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 21:26:25 -0400
Received: from avalon.bb.dnainternet.fi (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2BCC8CD;
        Mon, 20 Aug 2018 00:13:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1534716803;
        bh=nSy7EyN1mqC98+ppNycU25gvCY3nT56hhW1n/kSA9eQ=;
        h=From:To:Cc:Subject:Date:From;
        b=h2kxhdpPAu5rRbZxCKve1p2+y/1GZDKdgCCskblRlhBBGYFWHs63BQLEcMPTsRxkP
         GTpTahStUkVi7Wcg/suhg0Cp/BNY3RFc8lI+tt6eB6OZ8xx0iz16/VsBX2PZo4H2Bg
         jG1Pqr43mkuzfg1+115JqbdMiIj1wrjINkSCIEEs=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update tree location for the Renesas DRM drivers
Date:   Mon, 20 Aug 2018 01:14:13 +0300
Message-Id: <20180819221413.1031-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fbdev git tree referenced in the MAINTAINERS file doesn't exist
anymore. Update the location to point to the new git tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b2bf134964e..6a418ce09853 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4782,7 +4782,7 @@ DRM DRIVERS FOR RENESAS
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	dri-devel@lists.freedesktop.org
 L:	linux-renesas-soc@vger.kernel.org
-T:	git git://linuxtv.org/pinchartl/fbdev
+T:	git git://linuxtv.org/pinchartl/media drm/du/next
 S:	Supported
 F:	drivers/gpu/drm/rcar-du/
 F:	drivers/gpu/drm/shmobile/
-- 
Regards,

Laurent Pinchart

