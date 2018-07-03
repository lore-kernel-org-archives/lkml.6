Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E714AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A153F24180
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A153F24180
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kollasch.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeGCNdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:33:44 -0400
Received: from poghril.kollasch.net ([71.19.157.95]:65204 "EHLO
        poghril.kollasch.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753200AbeGCNdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:33:42 -0400
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2018 09:33:42 EDT
Received: from mail.kollasch.net (q.kollasch.net [168.103.54.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.kollasch.net", Issuer "kollasch.net postmaster CA" (not verified))
        by poghril.kollasch.net (Postfix) with ESMTPS id 3C177300;
        Tue,  3 Jul 2018 13:27:08 +0000 (UTC)
        (envelope-from jakllsch@kollasch.net)
Received: from terminus.kollasch.net (terminus.kollasch.net [IPv6:2001:470:c003:410:3697:f6ff:fe00:7027])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jakllsch@KOLLASCH.NET)
        by mail.kollasch.net (Postfix) with ESMTPSA id 7396F1DC8F;
        Tue,  3 Jul 2018 13:27:05 +0000 (UTC)
        (envelope-from jakllsch@kollasch.net)
From:   "Jonathan A. Kollasch" <jakllsch@kollasch.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc:     "Jonathan A. Kollasch" <jakllsch@kollasch.net>
Subject: [PATCH] dts: fix status gpioleds on nanopi-neo-plus2
Date:   Tue,  3 Jul 2018 08:26:36 -0500
Message-Id: <20180703132636.21587-1-jakllsch@kollasch.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan A. Kollasch <jakllsch@kollasch.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index 506e25ba028a..b8eb43a0d007 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -71,8 +71,8 @@
 		};
 
 		status {
-			label = "nanopi:red:status";
-			gpios = <&pio 0 20 GPIO_ACTIVE_HIGH>;
+			label = "nanopi:blue:status";
+			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
-- 
2.11.0

