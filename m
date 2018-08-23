Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACBFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A882152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Qo4Q1XGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A882152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbeHWQrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:47:43 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:54846 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeHWQrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:47:41 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/4] dt-bindings: clock: Add jz4725b-cgu.h header
Date:   Thu, 23 Aug 2018 15:17:43 +0200
Message-Id: <20180823131744.744-3-paul@crapouillou.net>
In-Reply-To: <20180823131744.744-1-paul@crapouillou.net>
References: <20180823131744.744-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535030279; bh=yAnEUDZWe8v66+ZnAK95/gGykj6eCTOHXFevtT8sF8w=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Qo4Q1XGgAQNMkybIQrtVLoKsaM7TKIQb85xrKz1Snkx49/mvK3vNXtCQXfQo01ar6F95Z4VrPlor/x6J+cMWVdLlBJixmOOwZkZnsPMXJORX9KvOt9ZCP1KA9zheDhJxLmGYxxVXJyGdWs6sMgVfMWpgGGOQTdkzH8bBYowXCjU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used from the devicetree bindings to specify the clocks
that should be obtained from the jz4725b-cgu driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    No change

 include/dt-bindings/clock/jz4725b-cgu.h | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 include/dt-bindings/clock/jz4725b-cgu.h

diff --git a/include/dt-bindings/clock/jz4725b-cgu.h b/include/dt-bindings/clock/jz4725b-cgu.h
new file mode 100644
index 000000000000..460bbeff6ab8
--- /dev/null
+++ b/include/dt-bindings/clock/jz4725b-cgu.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides clock numbers for the ingenic,jz4725b-cgu DT binding.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_JZ4725B_CGU_H__
+#define __DT_BINDINGS_CLOCK_JZ4725B_CGU_H__
+
+#define JZ4725B_CLK_EXT		0
+#define JZ4725B_CLK_OSC32K	1
+#define JZ4725B_CLK_PLL		2
+#define JZ4725B_CLK_PLL_HALF	3
+#define JZ4725B_CLK_CCLK	4
+#define JZ4725B_CLK_HCLK	5
+#define JZ4725B_CLK_PCLK	6
+#define JZ4725B_CLK_MCLK	7
+#define JZ4725B_CLK_IPU		8
+#define JZ4725B_CLK_LCD		9
+#define JZ4725B_CLK_I2S		10
+#define JZ4725B_CLK_SPI		11
+#define JZ4725B_CLK_MMC_MUX	12
+#define JZ4725B_CLK_UDC		13
+#define JZ4725B_CLK_UART	14
+#define JZ4725B_CLK_DMA		15
+#define JZ4725B_CLK_ADC		16
+#define JZ4725B_CLK_I2C		17
+#define JZ4725B_CLK_AIC		18
+#define JZ4725B_CLK_MMC0	19
+#define JZ4725B_CLK_MMC1	20
+#define JZ4725B_CLK_BCH		21
+#define JZ4725B_CLK_TCU		22
+#define JZ4725B_CLK_EXT512	23
+#define JZ4725B_CLK_RTC		24
+
+#endif /* __DT_BINDINGS_CLOCK_JZ4725B_CGU_H__ */
-- 
2.11.0

