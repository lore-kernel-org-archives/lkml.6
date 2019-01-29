Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D76C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B668C20857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548785551;
	bh=AFZpw44j2DtzuhDEUxpxZuWfTx8exGaz650jIUFxs+4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xHbmYK/ZnWeC3IwXqp1J3ySnTfsnuxfnRn6U2XH9wK4vTE+Gb4Hy2PB0Pgm8g9+Wd
	 ZpNq1WKoSEp1k5tCAEkmRKohfy6zXsq6kbbF8BrfeMGBZw7ItlPwb6O+LkeN5s9ys7
	 jNVjTv3ijzku9Bpis7Qn4Lb9Sh2HxVIxheKlAOIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfA2SM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:12:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59910 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfA2SM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xy0VqZxWz696lwx1Yy0MKiaYgAxH7bozA91tz+6yzNg=; b=mARqOi3Kv6xv
        WgdJQVonHjksjkSYCnh/pjcj12Z2einMBHgpWj/ZjvjQsvQYUlmrcUTcaunsf0QsD1o4hZ1TImL9V
        Np2p1AV9iIkEATIc/SVHfu9lJSiKr+LirPvuwCAKpMURxYHc+MvbdIO3yC0nWCRg1GrMO5yAcs6F3
        xecZ4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goXrv-0000yD-CC; Tue, 29 Jan 2019 18:12:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DD4F31127D50; Tue, 29 Jan 2019 18:12:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org, alsa-devel@alsa-project.org
Subject: Applied "dt-bindings: ASoC: Add Spreadtrum DMA platform documentation" to the asoc tree
In-Reply-To:  <15c562bcfd488fbf1979a69f96ddbd8df57f7e69.1548747137.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190129181218.DD4F31127D50@debutante.sirena.org.uk>
Date:   Tue, 29 Jan 2019 18:12:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: ASoC: Add Spreadtrum DMA platform documentation

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

From 27e27e6555d3a1dd3c906796af6d8e7eb538857f Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 29 Jan 2019 16:04:44 +0800
Subject: [PATCH] dt-bindings: ASoC: Add Spreadtrum DMA platform documentation

Add documentation for Spreadtrum DMA platform driver.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/sprd-pcm.txt    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sprd-pcm.txt

diff --git a/Documentation/devicetree/bindings/sound/sprd-pcm.txt b/Documentation/devicetree/bindings/sound/sprd-pcm.txt
new file mode 100644
index 000000000000..4b23e84b2e57
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sprd-pcm.txt
@@ -0,0 +1,23 @@
+* Spreadtrum DMA platfrom bindings
+
+Required properties:
+- compatible: Should be "sprd,pcm-platform".
+- dmas: Specify the list of DMA controller phandle and DMA request line ordered pairs.
+- dma-names: Identifier string for each DMA request line in the dmas property.
+  These strings correspond 1:1 with the ordered pairs in dmas.
+
+Example:
+
+	audio_platform:platform@0 {
+		compatible = "sprd,pcm-platform";
+		dmas = <&agcp_dma 1 1>, <&agcp_dma 2 2>,
+		     <&agcp_dma 3 3>, <&agcp_dma 4 4>,
+		     <&agcp_dma 5 5>, <&agcp_dma 6 6>,
+		     <&agcp_dma 7 7>, <&agcp_dma 8 8>,
+		     <&agcp_dma 9 9>, <&agcp_dma 10 10>;
+		dma-names = "normal_p_l", "normal_p_r",
+			"normal_c_l", "normal_c_r",
+			"voice_c", "fast_p",
+			"loop_c", "loop_p",
+			"voip_c", "voip_p";
+	};
-- 
2.20.1

