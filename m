Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13008C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB3F20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbfAPIl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:41:27 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:35603 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbfAPIl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:41:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C7570FB04;
        Wed, 16 Jan 2019 09:41:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qnWayuKMLxYH; Wed, 16 Jan 2019 09:41:22 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 451EB475EF; Wed, 16 Jan 2019 09:41:22 +0100 (CET)
Date:   Wed, 16 Jan 2019 09:41:22 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: imx8mq: Number clocks consecutively
Message-ID: <20190116084122.GA19712@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a duplicate use of 232 and numbers the clocks without holes.

Fixes: 1cf3817bf1f5 ("dt-bindings: Add binding for i.MX8MQ CCM")

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 include/dt-bindings/clock/imx8mq-clock.h | 26 ++++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings/clock/imx8mq-clock.h
index b53be41929be..04f7ac345984 100644
--- a/include/dt-bindings/clock/imx8mq-clock.h
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -350,7 +350,7 @@
 #define IMX8MQ_CLK_VPU_G2_ROOT			241
 
 /* SCCG PLL GATE */
-#define IMX8MQ_SYS1_PLL_OUT			232
+#define IMX8MQ_SYS1_PLL_OUT			242
 #define IMX8MQ_SYS2_PLL_OUT			243
 #define IMX8MQ_SYS3_PLL_OUT			244
 #define IMX8MQ_DRAM_PLL_OUT			245
@@ -372,24 +372,24 @@
 /* txesc clock */
 #define IMX8MQ_CLK_DSI_IPG_DIV                  256
 
-#define IMX8MQ_CLK_TMU_ROOT			265
+#define IMX8MQ_CLK_TMU_ROOT			257
 
 /* Display root clocks */
-#define IMX8MQ_CLK_DISP_AXI_ROOT		266
-#define IMX8MQ_CLK_DISP_APB_ROOT		267
-#define IMX8MQ_CLK_DISP_RTRM_ROOT		268
+#define IMX8MQ_CLK_DISP_AXI_ROOT		258
+#define IMX8MQ_CLK_DISP_APB_ROOT		259
+#define IMX8MQ_CLK_DISP_RTRM_ROOT		260
 
-#define IMX8MQ_CLK_OCOTP_ROOT			269
+#define IMX8MQ_CLK_OCOTP_ROOT			261
 
-#define IMX8MQ_CLK_DRAM_ALT_ROOT		270
-#define IMX8MQ_CLK_DRAM_CORE			271
+#define IMX8MQ_CLK_DRAM_ALT_ROOT		262
+#define IMX8MQ_CLK_DRAM_CORE			263
 
-#define IMX8MQ_CLK_MU_ROOT			272
-#define IMX8MQ_VIDEO2_PLL_OUT			273
+#define IMX8MQ_CLK_MU_ROOT			264
+#define IMX8MQ_VIDEO2_PLL_OUT			265
 
-#define IMX8MQ_CLK_CLKO2			274
+#define IMX8MQ_CLK_CLKO2			266
 
-#define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	275
+#define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	267
 
-#define IMX8MQ_CLK_END				276
+#define IMX8MQ_CLK_END				268
 #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
-- 
2.20.1
