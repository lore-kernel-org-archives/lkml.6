Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647F0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F14222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550061129;
	bh=x/nWmipnAVSXp+Bn4F6Z8ByPTf/rOp5QHWHyDMH6g90=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ZXCT7XDw+UO0ButaS3U+8F5itiKiSSKluM4a8UzHA5LeJBGZmUkxqwfO6cAEBNAKk
	 yDp/63Hn0sEFP8o+tZWAAWjGU/tonaXPdqBGdWek+liV+HzRdob+dc8HTK6fKDT6cv
	 TJVRWU+KA9mMchnrVmry9rXGElwJlxYMwKCpKgSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404147AbfBMMcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:32:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57794 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404104AbfBMMcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GdUp/FX2y5ub4uJLSnF7rDP7Hv9t/8aUaO7+malV/g8=; b=PJWKE9tI2FGj
        VFLKa1R0OoVnWc38sm4fv7q4o+ilanCQ1E3eJFDg2bUQMZqtkC9b8tTZ8eGaNC5uZoErsUTAZgatK
        ZdgqILR19IQjZhEthijXQ8LLKxr6TIR1bIXZJcXZ+7fwgd1V+oiyhngQYdfJ570028Dh+bVsKbH/9
        Bt8ss=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtthi-0004JT-R1; Wed, 13 Feb 2019 12:31:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6E51D1128159; Wed, 13 Feb 2019 12:31:54 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Lanqing Liu <lanqing.liu@unisoc.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "dt-bindings: spi: Add the DMA properties for the SPI dma mode" to the spi tree
In-Reply-To:  <2be9d6de92507e5886433fb2cd55117c63b63d72.1550043082.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190213123154.6E51D1128159@debutante.sirena.org.uk>
Date:   Wed, 13 Feb 2019 12:31:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: spi: Add the DMA properties for the SPI dma mode

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

From 6dcb144f7da634e4a0f8837e5076ef48e4d6ac12 Mon Sep 17 00:00:00 2001
From: Lanqing Liu <lanqing.liu@unisoc.com>
Date: Wed, 13 Feb 2019 15:36:10 +0800
Subject: [PATCH] dt-bindings: spi: Add the DMA properties for the SPI dma mode

Add the DMA properties for the SPI dma mode.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-sprd.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
index bad211a19da4..3c7eacce0ee3 100644
--- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
@@ -14,6 +14,11 @@ Required properties:
 	address on the SPI bus. Should be set to 1.
 - #size-cells: Should be set to 0.
 
+Optional properties:
+dma-names: Should contain names of the SPI used DMA channel.
+dmas: Should contain DMA channels and DMA slave ids which the SPI used
+	sorted in the same order as the dma-names property.
+
 Example:
 spi0: spi@70a00000{
 	compatible = "sprd,sc9860-spi";
@@ -21,6 +26,8 @@ spi0: spi@70a00000{
 	interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	clock-names = "spi", "source","enable";
 	clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
+	dma-names = "rx_chn", "tx_chn";
+	dmas = <&apdma 11 11>, <&apdma 12 12>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 };
-- 
2.20.1

