Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6B5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177FD208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hJN7nw9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177FD208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbeGKJgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:36:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37952 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbeGKJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=CpsNn/DmwFHd3LZJuuS7y51aL6tXoi44MlnQ0jK8TgY=; b=hJN7nw9cFhZa
        HxQzac1TnPqNQE1WWBVCtJtfKUyjOKMVCGGK8JW6rXddTolBKV48dDQLitr6drLXgFSoYUhMVFl3f
        9DTwOlVaH3RF9B5oey2LUiQgmR/uWwlH3hEvVjIhJ8Vg8Pi8UWN2zSUyckoO14NXKlWadMJMLeNOu
        gxCfc=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdBUg-0002lZ-B6; Wed, 11 Jul 2018 09:33:06 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdBUf-00033y-UF; Wed, 11 Jul 2018 10:33:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "dt-bindings: regulator: add DT bindings for UniPhier regulator" to the regulator tree
In-Reply-To:  <1531186037-16630-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-Id: <E1fdBUf-00033y-UF@debutante>
Date:   Wed, 11 Jul 2018 10:33:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: regulator: add DT bindings for UniPhier regulator

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 64a7b80ba6ee80f64d36e59331d14b1d25cf7006 Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Wed, 11 Jul 2018 13:30:51 +0900
Subject: [PATCH] dt-bindings: regulator: add DT bindings for UniPhier
 regulator

Add DT bindings for regulators implemented in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/uniphier-regulator.txt | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/uniphier-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt b/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
new file mode 100644
index 000000000000..c9919f4b92d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
@@ -0,0 +1,57 @@
+Socionext UniPhier Regulator Controller
+
+This describes the devicetree bindings for regulator controller implemented
+on Socionext UniPhier SoCs.
+
+USB3 Controller
+---------------
+
+This regulator controls VBUS and belongs to USB3 glue layer. Before using
+the regulator, it is necessary to control the clocks and resets to enable
+this layer. These clocks and resets should be described in each property.
+
+Required properties:
+- compatible: Should be
+    "socionext,uniphier-pro4-usb3-regulator" - for Pro4 SoC
+    "socionext,uniphier-pxs2-usb3-regulator" - for PXs2 SoC
+    "socionext,uniphier-ld20-usb3-regulator" - for LD20 SoC
+    "socionext,uniphier-pxs3-usb3-regulator" - for PXs3 SoC
+- reg: Specifies offset and length of the register set for the device.
+- clocks: A list of phandles to the clock gate for USB3 glue layer.
+	According to the clock-names, appropriate clocks are required.
+- clock-names: Should contain
+    "gio", "link" - for Pro4 SoC
+    "link"        - for others
+- resets: A list of phandles to the reset control for USB3 glue layer.
+	According to the reset-names, appropriate resets are required.
+- reset-names: Should contain
+    "gio", "link" - for Pro4 SoC
+    "link"        - for others
+
+See Documentation/devicetree/bindings/regulator/regulator.txt
+for more details about the regulator properties.
+
+Example:
+
+	usb-glue@65b00000 {
+		compatible = "socionext,uniphier-ld20-dwc3-glue",
+			     "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x65b00000 0x400>;
+
+		usb_vbus0: regulators@100 {
+			compatible = "socionext,uniphier-ld20-usb3-regulator";
+			reg = <0x100 0x10>;
+			clock-names = "link";
+			clocks = <&sys_clk 14>;
+			reset-names = "link";
+			resets = <&sys_rst 14>;
+		};
+
+		phy {
+			...
+			phy-supply = <&usb_vbus0>;
+		};
+		...
+	};
-- 
2.18.0.rc2

