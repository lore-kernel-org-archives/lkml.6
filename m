Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C0CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4745820863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4745820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeK2WFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:05:19 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:56476 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeK2WFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:05:18 -0500
Received: from droid15-sz.amlogic.com (10.28.8.25) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 29 Nov 2018
 19:00:31 +0800
From:   Jian Hu <jian.hu@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: i2c: meson: add Meson G12A SoC i2c compatible string
Date:   Thu, 29 Nov 2018 18:59:55 +0800
Message-ID: <1543489197-183181-2-git-send-email-jian.hu@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.25]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Meson G12A SoC i2c controller compatible string

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
---
 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
index 13d410d..795bc12 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
@@ -5,6 +5,7 @@ Required properties:
 	"amlogic,meson6-i2c" for Meson8 and compatible SoCs
 	"amlogic,meson-gxbb-i2c" for GXBB and compatible SoCs
 	"amlogic,meson-axg-i2c"for AXG and compatible SoCs
+	"amlogic,meson-g12a-i2c" for G12A and compatible SoCs
 
  - reg: physical address and length of the device registers
  - interrupts: a single interrupt specifier
-- 
1.9.1

