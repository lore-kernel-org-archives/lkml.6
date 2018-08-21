Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63251C04E83
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151AE20C0C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="REn0dZjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151AE20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeHUP60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:58:26 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:35576 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeHUP6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:58:25 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] dt-bindings: clock: Add jz4725b-cgu.h header
Date:   Tue, 21 Aug 2018 14:38:18 +0200
Message-Id: <20180821123819.25020-2-paul@crapouillou.net>
In-Reply-To: <20180821123819.25020-1-paul@crapouillou.net>
References: <20180821123819.25020-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534855105; bh=IDxldSwS+o8qimLkrBs9aLUnMrR/dCJ6RyuN7bQmHX0=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=REn0dZjULaciEvfRZR5igAJAohPyUq46HjRKl5lefMeqUqisa0M0v0wb6I5YgMTAcTmN/2ZinOBW3Gmp0QQp7lx/P450o8knqjw8tlI0DhPaIan2iZvTHTCAA53SCGDaaxANaj3OLpYt79hLgxUgSR1Vwx2cVzW2muFSOLM5TVg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used from the devicetree bindings to specify the clocks
that should be obtained from the jz4725b-cgu driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 include/dt-bindings/clock/jz4725b-cgu.h | 35 +++++++++++++++++++++++++
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
2.18.0

