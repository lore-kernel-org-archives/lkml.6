Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A046C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2108A21528
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xu7O2+dJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2108A21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeI1U3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:29:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54742 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbeI1U3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Y+9zkskDve/jrGOmfdBCervcKwhjkavOyD/oe0AgQkI=; b=xu7O2+dJemCR
        5kqAyCGhbAPk+GZM+1uYW1+5l9lOF7TZjgGAdJ7XW6suFV56/8Zf4l5V+76W/GiNqW6/n9fJL17L8
        IZnSuSWMn2JeXj/wfKxCYVn9D3LNCrshfkbBV0H5A/yIfR2551hTGA1ldO0H5dI5wfQwyjLr8i3yf
        hxgjs=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5tOA-0008WO-8o; Fri, 28 Sep 2018 14:05:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C92DC440078; Fri, 28 Sep 2018 15:05:01 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "mfd: dt bindings: add BD71847 device-tree binding documentation" to the regulator tree
In-Reply-To: 
Message-Id: <20180928140501.C92DC440078@finisterre.ee.mobilebroadband>
Date:   Fri, 28 Sep 2018 15:05:01 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   mfd: dt bindings: add BD71847 device-tree binding documentation

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

From 01e17e5d8004f53044c6c9062e04ca118c420512 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Fri, 14 Sep 2018 11:30:58 +0300
Subject: [PATCH] mfd: dt bindings: add BD71847 device-tree binding
 documentation

Add ROHM BD71847 Power Management IC MFD binding information to
device-tree binding documents.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/mfd/rohm,bd71837-pmic.txt          | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
index 3ca56fdb5ffe..a4b056761eaa 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
@@ -1,16 +1,17 @@
-* ROHM BD71837 Power Management Integrated Circuit bindings
+* ROHM BD71837 and BD71847 Power Management Integrated Circuit bindings
 
-BD71837MWV is a programmable Power Management IC for powering single-core,
-dual-core, and quad-core SoCs such as NXP-i.MX 8M. It is optimized for
-low BOM cost and compact solution footprint. It integrates 8 Buck
-egulators and 7 LDOs to provide all the power rails required by the SoC and
-the commonly used peripherals.
+BD71837MWV and BD71847MWV are programmable Power Management ICs for powering
+single-core, dual-core, and quad-core SoCs such as NXP-i.MX 8M. They are
+optimized for low BOM cost and compact solution footprint. BD71837MWV
+integrates 8 Buck regulators and 7 LDOs. BD71847MWV contains 6 Buck regulators
+and 6 LDOs.
 
-Datasheet for PMIC is available at:
+Datasheet for BD71837 is available at:
 https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
 
 Required properties:
- - compatible		: Should be "rohm,bd71837".
+ - compatible		: Should be "rohm,bd71837" for bd71837
+				    "rohm,bd71847" for bd71847.
  - reg			: I2C slave address.
  - interrupt-parent	: Phandle to the parent interrupt controller.
  - interrupts		: The interrupt line the device is connected to.
-- 
2.19.0

