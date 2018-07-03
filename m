Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80958C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C90D23E80
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="pRMJRuTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C90D23E80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933039AbeGCPd6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:33:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37124 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932273AbeGCPd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NIK7yQcyPSF8j9tgWUWBxEfBv4XJDRQx4Oq8D+yBUJ8=; b=pRMJRuTlsJBF
        ec89WGDPePhP5zK8GrHfeYjXhSCa+ZQbC9+0YuwkAJWHg3CZQQmlL+iP/Q4D9SrvxvMytMHnCoPMK
        wwllyBmRxdm3Ds4G6m0Jc2//V7Gvu8naiifyvqzReU/FHsC/ku7Hdd6kt69VOWnMFeVzEZ9nUtc5B
        a+OiU=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJT-00069o-JZ; Tue, 03 Jul 2018 15:33:55 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJT-0003di-5D; Tue, 03 Jul 2018 16:33:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com,
        robh+dt@kernel.org, broonie@kernel.org, quentin.schulz@bootlin.com,
        Cristian.Birsan@microchip.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: atmel-i2s: dt-bindings: Remove unnecessary phandle to aclk" to the asoc tree
In-Reply-To:  <20180703145631.15246-3-codrin.ciubotariu@microchip.com>
Message-Id: <E1faNJT-0003di-5D@debutante>
Date:   Tue, 03 Jul 2018 16:33:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: atmel-i2s: dt-bindings: Remove unnecessary phandle to aclk

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 2bd368d7bf21028f37a123041a138922254d4840 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Tue, 3 Jul 2018 17:56:31 +0300
Subject: [PATCH] ASoC: atmel-i2s: dt-bindings: Remove unnecessary phandle to
 aclk

The optional clock phandle to aclk (Audio PLL clock) is no longer needed
by the driver.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/atmel-i2s.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/atmel-i2s.txt b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
index 735368b8a73f..40549f496a81 100644
--- a/Documentation/devicetree/bindings/sound/atmel-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
@@ -15,7 +15,6 @@ Required properties:
 - clock-names:    Should be one of each entry matching the clocks phandles list:
                   - "pclk" (peripheral clock) Required.
                   - "gclk" (generated clock) Optional (1).
-                  - "aclk" (Audio PLL clock) Optional (1).
                   - "muxclk" (I2S mux clock) Optional (1).
 
 Optional properties:
@@ -23,9 +22,9 @@ Optional properties:
 - princtrl-names: Should contain only one value - "default".
 
 
-(1) : Only the peripheral clock is required. The generated clock, the Audio
-      PLL clock adn the I2S mux clock are optional and should only be set
-      together, when Master Mode is required.
+(1) : Only the peripheral clock is required. The generated clock and the I2S
+      mux clock are optional and should only be set together, when Master Mode
+      is required.
 
 Example:
 
@@ -40,8 +39,8 @@ Example:
 			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 			 AT91_XDMAC_DT_PERID(32))>;
 		dma-names = "tx", "rx";
-		clocks = <&i2s0_clk>, <&i2s0_gclk>, <&audio_pll_pmc>, <&i2s0muxck>;
-		clock-names = "pclk", "gclk", "aclk", "muxclk";
+		clocks = <&i2s0_clk>, <&i2s0_gclk>, <&i2s0muxck>;
+		clock-names = "pclk", "gclk", "muxclk";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2s0_default>;
 	};
-- 
2.18.0.rc2

