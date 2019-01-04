Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB4CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090E7218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546621730;
	bh=+6DKjwObnc5/utsvJ6n+umZHvj5BRGqPHo5N+0BvrMs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=SxcG0YWpAz7yHpBhJddWaPk4cF+gNhpJebNJkO7sOkpnZ9ezUUlBbOyX5uor34hwa
	 IbukUuq7A6g6LScDRAW0uI4bAsZpcwctKBrIYOP+wOI2FxBdjTinThO4UbN40f7iGa
	 znTVxO8bcYqzEjfA236BvTC8fRVBj07a9jdq3XJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfADRIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:08:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57800 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfADRIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SDa7b9dmQ73qDj1iiHK6aDCEUZBXmn2g7pn2XRH6/9E=; b=DQFO+ie8mgND
        yfLgvmo8U3cBQ1NnkB17O2fC+8C9qHbF/ig6sTnBOQvqQkbRYzjUhzCxTjp683R8GVdv+fo/P1+Iz
        tSF2fWGBqSOMPYpD6Xal2vamQw3ywGrkUOnnu/tRQ3R0AVz4UbEnqU6CiyoYIPsK9PvV1e5q28yzW
        H9prU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gfSxX-0001mu-Lr; Fri, 04 Jan 2019 17:08:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 554E711270A3; Fri,  4 Jan 2019 17:08:35 +0000 (GMT)
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
Message-Id: <20190104170835.554E711270A3@debutante.sirena.org.uk>
Date:   Fri,  4 Jan 2019 17:08:35 +0000 (GMT)
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

