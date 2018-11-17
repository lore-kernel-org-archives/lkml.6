Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D118C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC822089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="nhe/AgyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC822089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbeKQNoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:44:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59034 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbeKQNoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=OCQTO4cijsj9LyFuHE58QXbHlam08yMGrvBqBmoJgaY=; b=nhe/AgyJ6NXU
        98fJsNgymSDiVOvTuAlJjQ2Cxy8WEcMqWJvBBcVhpv+v2zLPaxWFeSk0fcKwfZpUA6BOmUF27ubNz
        sBuowp7eCmalw1Rwbw8RWaKxbi5LZwalrZ9tU2CjSlPFYlhkiNIZquuZ17jSfbOKaKabUqYBIlW+R
        /4bkI=;
Received: from [204.239.253.216] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNrIF-0008My-M8; Sat, 17 Nov 2018 03:29:11 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0E505440079; Sat, 17 Nov 2018 03:29:08 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        oder_chiou@realtek.com, alsa-devel@alsa-project.org,
        tzungbi@chromium.org, Mark Brown <broonie@kernel.org>,
        dgreid@chromium.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rt5663: Add documentation for power supply support" to the asoc tree
In-Reply-To:  <20181116021243.179183-1-cychiang@chromium.org>
Message-Id: <20181117032908.0E505440079@finisterre.ee.mobilebroadband>
Date:   Sat, 17 Nov 2018 03:29:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5663: Add documentation for power supply support

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

From 276aa6d38e619d2bd61fbac71388a4da680e7ed5 Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Fri, 16 Nov 2018 10:12:43 +0800
Subject: [PATCH] ASoC: rt5663: Add documentation for power supply support

rt5663 codec driver will support setting CPVDD and AVDD power supply
from device tree.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5663.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5663.txt b/Documentation/devicetree/bindings/sound/rt5663.txt
index 23386446c63d..2a55e9133408 100644
--- a/Documentation/devicetree/bindings/sound/rt5663.txt
+++ b/Documentation/devicetree/bindings/sound/rt5663.txt
@@ -10,6 +10,10 @@ Required properties:
 
 - interrupts : The CODEC's interrupt output.
 
+- avdd-supply: Power supply for AVDD, providing 1.8V.
+
+- cpvdd-supply: Power supply for CPVDD, providing 3.5V.
+
 Optional properties:
 
 - "realtek,dc_offset_l_manual"
@@ -51,4 +55,6 @@ rt5663: codec@12 {
 	compatible = "realtek,rt5663";
 	reg = <0x12>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+	avdd-supply = <&pp1800_a_alc5662>;
+	cpvdd-supply = <&pp3500_a_alc5662>;
 };
-- 
2.19.1

