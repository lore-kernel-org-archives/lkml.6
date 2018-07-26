Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8CEC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5272720899
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5272720899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbeGZIZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:25:47 -0400
Received: from mx.socionext.com ([202.248.49.38]:12191 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729013AbeGZIZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:25:47 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 26 Jul 2018 16:10:20 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 4C92660035;
        Thu, 26 Jul 2018 16:10:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 26 Jul 2018 16:10:20 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id D3D961A120D;
        Thu, 26 Jul 2018 16:10:19 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 1/3] ARM: dts: uniphier: add SPI pin-mux node
Date:   Thu, 26 Jul 2018 16:09:58 +0900
Message-Id: <1532589000-19602-2-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532589000-19602-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1532589000-19602-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

This commit adds pin-mux nodes for SPI controller.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index 51f0e69..5dc4cf7 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -126,6 +126,26 @@
 		function = "sd1";
 	};
 
+	pinctrl_spi0: spi0 {
+		groups = "spi0";
+		function = "spi0";
+	};
+
+	pinctrl_spi1: spi1 {
+		groups = "spi1";
+		function = "spi1";
+	};
+
+	pinctrl_spi2: spi2 {
+		groups = "spi2";
+		function = "spi2";
+	};
+
+	pinctrl_spi3: spi3 {
+		groups = "spi3";
+		function = "spi3";
+	};
+
 	pinctrl_system_bus: system-bus {
 		groups = "system_bus", "system_bus_cs1";
 		function = "system_bus";
-- 
2.7.4

