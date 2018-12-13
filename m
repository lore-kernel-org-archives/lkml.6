Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACFEC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A708208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544724709;
	bh=1ftag+sECaWuf02CpqkGu6L99bfngDK3H5LpoxsUxSs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yJLtscGMoZR19GkByMBEEa98TD0nRE5+O1b5JZ9u8wQ7o/LRwNPbS4EUD5l3lw+5U
	 A6zEOpHq4n96gbiV9RzvN759kFLIoldrQPApecUORBjRJqmmYmXXhQG/Tc0UBq2Npu
	 Rh4cJ4flrn4EGrxVfnzuHbUZvcCyIwwmRtOmjvnA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A708208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeLMSLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:11:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37680 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbeLMSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=uUr/PnqWG16Zr3Bfe/x5zle1W8SD/NaBAUXcXJpYKDI=; b=klf/3Ca/XOlE
        Xlfyaomn1baqVbq14qJS45hd8l5w/Ki5C/qEwxSEbIlJRpQ+BHOWiX2kuVbqOG5629LltVRBE9BCn
        I/bJTGFqGOlpKXK7bniTyFaygTpB2RlGy1Kj9OKimOwc/dohU8u9O4xf0vkUnk2MvIgLJdQmMflMJ
        wFOPk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVSX-0002RU-AX; Thu, 13 Dec 2018 18:11:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0462A11254D1; Thu, 13 Dec 2018 18:11:41 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Priit Laes <plaes@plaes.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "dt-bindings: mfd: axp20x: add support for regulator-ramp-delay for AXP209" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181213181141.0462A11254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 18:11:41 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: mfd: axp20x: add support for regulator-ramp-delay for AXP209

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

From fdb0436c35b86759da6d7fce27323e3cdced0e13 Mon Sep 17 00:00:00 2001
From: Olliver Schinagl <oliver@schinagl.nl>
Date: Tue, 11 Dec 2018 17:17:07 +0200
Subject: [PATCH] dt-bindings: mfd: axp20x: add support for
 regulator-ramp-delay for AXP209

The AXP209 supports ramping up voltages on several regulators such as
DCDC2 and LDO3, therefore we can use the standard 'regulator-ramp-delay'
property for those 2 regulators.

Note that the voltage ramp only works when the regulator is already
enabled. E.g. when going from say 0.7 V to 3.6 V.

When turning on the regulator, no voltage ramp is performed in hardware.

What this means, is that if the bootloader brings up the voltage at 0.7 V,
the ramp delay property is properly applied. If however, the bootloader
leaves the power off, no ramp delay is applied when the power is
enabled by the regulator framework.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 188f0373d441..c6266052d23f 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -32,6 +32,12 @@ Required properties:
 - interrupt-controller: The PMIC has its own internal IRQs
 - #interrupt-cells: Should be set to 1
 
+Supported common regulator properties, see ../regulator/regulator.txt for
+more information:
+- regulator-ramp-delay: sets the ramp up delay in uV/us
+			AXP20x/DCDC2: 1600, 800
+			AXP20x/LDO3:  1600, 800
+
 Optional properties:
 - x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
 		      AXP152/20X: range:  750-1875, Default: 1.5 MHz
-- 
2.19.0.rc2

