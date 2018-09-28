Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E351C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F842150D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qHkFdupo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F842150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeI1U3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:29:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55732 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeI1U3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IXFuJ3GgxaNUq8OKzUej1OIw9bED2FHhs/SSS/vlEQI=; b=qHkFdupolP+g
        2rAawknEMe1SA4DjKwD5+uAYh4Vn3b+vnO4Kx3lIg9l7nIoaI/PwVu6KkibcewCe7ha20udnO92+d
        AuqVKgWgYa3Y4kA/94M8s2j2tk1dMm7lkjsRHvXxyTkvzgqx2uArFbcEuK8xlzQAvaLbUtfqpihbg
        nGAB8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5tOQ-000057-1o; Fri, 28 Sep 2018 14:05:18 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8E077440078; Fri, 28 Sep 2018 15:05:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yt.shen@mediatek.com,
        linux-spi@vger.kernel.org
Subject: Applied "spi: mediatek: add bindings for Mediatek MT2712 soc platform" to the spi tree
In-Reply-To:  <1538131985-9471-2-git-send-email-leilk.liu@mediatek.com>
Message-Id: <20180928140517.8E077440078@finisterre.ee.mobilebroadband>
Date:   Fri, 28 Sep 2018 15:05:17 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: mediatek: add bindings for Mediatek MT2712 soc platform

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From c0116e6b30473c7a75d33077bfd60f3b4eec7808 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Fri, 28 Sep 2018 18:53:03 +0800
Subject: [PATCH] spi: mediatek: add bindings for Mediatek MT2712 soc platform

This patch adds a DT binding documentation for the MT2712 soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/spi/spi-slave-mt27xx.txt         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
new file mode 100644
index 000000000000..c37e5a179b21
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
@@ -0,0 +1,32 @@
+Binding for MTK SPI Slave controller
+
+Required properties:
+- compatible: should be one of the following.
+    - mediatek,mt2712-spi-slave: for mt2712 platforms
+- reg: Address and length of the register set for the device.
+- interrupts: Should contain spi interrupt.
+- clocks: phandles to input clocks.
+  It's clock gate, and should be <&infracfg CLK_INFRA_AO_SPI1>.
+- clock-names: should be "spi" for the clock gate.
+
+Optional properties:
+- assigned-clocks: it's mux clock, should be <&topckgen CLK_TOP_SPISLV_SEL>.
+- assigned-clock-parents: parent of mux clock.
+  It's PLL, and should be one of the following.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D2>: specify parent clock 312MHZ.
+				       It's the default one.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D4>: specify parent clock 156MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL2_D4>: specify parent clock 104MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D8>: specify parent clock 78MHZ.
+
+Example:
+- SoC Specific Portion:
+spis1: spi@10013000 {
+	compatible = "mediatek,mt2712-spi-slave";
+	reg = <0 0x10013000 0 0x100>;
+	interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&infracfg CLK_INFRA_AO_SPI1>;
+	clock-names = "spi";
+	assigned-clocks = <&topckgen CLK_TOP_SPISLV_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>;
+};
-- 
2.19.0

