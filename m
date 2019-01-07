Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F376C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E122147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864240;
	bh=+6DKjwObnc5/utsvJ6n+umZHvj5BRGqPHo5N+0BvrMs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=D6Zt9oooYYOcbIRUDP7/Fg2RD2+1kYkMyKXFjPKsHtc58EfmexdniIt+aScCatSF3
	 fsZ020hQuuB+HXAga3KZ9B1vQZYUUksVZsURu5Z/sZ9hVtQlXOpzfGTvHwa8gA9VH6
	 hNSVWyPDKXgI0Vw3/iGbG1YOay4MHBeuWbTE1E3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfAGMaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:30:39 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38854 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfAGMag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SDa7b9dmQ73qDj1iiHK6aDCEUZBXmn2g7pn2XRH6/9E=; b=sZLlf94SPzpz
        pPNfbkEfBMSpuJzaJWL1bKFNLUOwH7EVk1gXG2SnBrECMcd1rlcqLz0sb/SBy9LDhSNkNDaFX15xC
        al53f1+5KpZUMRNDMUfhuwnyCS1CjHaeCnDzc6HFKro2kdV4E0uTYeCHjY1FsX1g/Ac7tsN3/pawc
        Lk+5k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggU36-0006jA-8A; Mon, 07 Jan 2019 12:30:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DA2661127490; Mon,  7 Jan 2019 12:30:31 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        jsarha@ti.com, robh+dt@kernel.org, misael.lopez@ti.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: davinci-mcasp: Document GPIO support" to the asoc tree
In-Reply-To:  <20190103140552.29809-3-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107123031.DA2661127490@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 12:30:31 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: davinci-mcasp: Document GPIO support

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

From 4664b94c98b4f9fdd3845da41d5c65288e59c66c Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 3 Jan 2019 16:05:51 +0200
Subject: [PATCH] ASoC: davinci-mcasp: Document GPIO support

McASP pins can be used as GPIO, add optional section to enable GPIO support
for McASP.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/davinci-mcasp-audio.txt      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index b279b6072bd5..a58f79f5345c 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -45,6 +45,23 @@ Optional properties:
 - fck_parent : Should contain a valid clock name which will be used as parent
 	       for the McASP fck
 
+Optional GPIO support:
+If any McASP pin need to be used as GPIO then the McASP node must have:
+...
+  gpio-controller
+  #gpio-cells = <2>;
+...
+
+When requesting a GPIO, the first parameter is the PIN index in McASP_P*
+registers.
+For example to request the AXR2 pin of mcasp8:
+function-gpios = <&mcasp8 2 0>;
+
+Or to request the ACLKR pin of mcasp8:
+function-gpios = <&mcasp8 29 0>;
+
+For generic gpio information, please refer to bindings/gpio/gpio.txt
+
 Example:
 
 mcasp0: mcasp0@1d00000 {
-- 
2.20.1

