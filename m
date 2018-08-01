Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE84BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE5120894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE5120894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbeHAKcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:32:48 -0400
Received: from regular1.263xmail.com ([211.150.99.139]:57758 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbeHAKcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:32:47 -0400
Received: from cl?rock-chips.com (unknown [192.168.167.233])
        by regular1.263xmail.com (Postfix) with ESMTP id A222329C;
        Wed,  1 Aug 2018 16:48:04 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 2CF843AC;
        Wed,  1 Aug 2018 16:47:41 +0800 (CST)
X-RL-SENDER: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: cl@rock-chips.com
X-UNIQUE-TAG: <ec864df6a5e5f4e6c33b03249ae66676>
X-ATTACHMENT-NUM: 0
X-SENDER: cl@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 28987SLF7MZ;
        Wed, 01 Aug 2018 16:47:56 +0800 (CST)
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        klaus.goger@theobroma-systems.com, hjc@rock-chips.com,
        jagan@amarulasolutions.com, djw@t-chip.com.cn,
        jacob-chen@iotwrt.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com, arnd@arndb.de,
        zhangqing@rock-chips.com, shawn.lin@rock-chips.com,
        kever.yang@rock-chips.com, david.wu@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com,
        sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com,
        william.wu@rock-chips.com, sandy.huang@rock-chips.com,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH v3 1/4] dt-bindings: usb: dwc2: add description for px30
Date:   Wed,  1 Aug 2018 16:45:13 +0800
Message-Id: <1533113116-8820-2-git-send-email-cl@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533113116-8820-1-git-send-email-cl@rock-chips.com>
References: <1533113116-8820-1-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

This patch adds the compatible of dwc2 for PX30 SoCs.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 46da5f1..6dc3c4a 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -6,6 +6,7 @@ Required properties:
   - brcm,bcm2835-usb: The DWC2 USB controller instance in the BCM2835 SoC.
   - hisilicon,hi6220-usb: The DWC2 USB controller instance in the hi6220 SoC.
   - rockchip,rk3066-usb: The DWC2 USB controller instance in the rk3066 Soc;
+  - "rockchip,px30-usb", "rockchip,rk3066-usb", "snps,dwc2": for px30 Soc;
   - "rockchip,rk3188-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3188 Soc;
   - "rockchip,rk3288-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3288 Soc;
   - "lantiq,arx100-usb": The DWC2 USB controller instance in Lantiq ARX SoCs;
-- 
1.9.1


