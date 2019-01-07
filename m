Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD6DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F44206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887481;
	bh=fAhFiTz8XD0Fce+MsSeGG4cErF4gl4Km8/qR9DRX+Vs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UinVgvu2CTRSy63NqDmx/GaLpyiPoz5uoGncxXSo8Rx5Y+n4Zq2xmTmHxSmL+fddR
	 yaXAqavT2+vQNLkswpTiHK3uvlLwb7H9tFiyVdzAaVztat5+0sh575K1WMC7IEEXRU
	 YnE7RHFgtiwfbZxJQWHPySvfUJBX/vRYSp5WVK0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfAGS6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:58:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40142 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfAGS54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZeeKJbXY+PtlLSFSqvZ/6Qdr3OBdTj8OLT5IZjfgqHg=; b=enhOCcCAh1KN
        P4oBGUQAtiy0mqcUUCbciosYonfkwnuHeGZfbGbSFojgNwhUPR78tWiJ48+q+iMpaD2cnFd6a3wyu
        P3uBQcHZ/nA3XX+nhLJSFrzDvldCDbHT0Hq859BUOcQOoZHp4sfBS6qHOKT4/OiJ7unfavBBHFXTj
        JpkWk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga5r-0007km-Q4; Mon, 07 Jan 2019 18:57:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6B9541127491; Mon,  7 Jan 2019 18:57:47 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "dt-bindings: ASoC: xlnx, spdif: Document spdif bindings" to the asoc tree
In-Reply-To:  <1546538993-55473-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185747.6B9541127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:57:47 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: ASoC: xlnx, spdif: Document spdif bindings

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

From 2f00f7715e624d04e25d9cb8bb0f53884d3bcb59 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Thu, 3 Jan 2019 23:39:51 +0530
Subject: [PATCH] dt-bindings: ASoC: xlnx, spdif: Document spdif bindings

Added documentation for SPDIF IP DT bindings.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/xlnx,spdif.txt  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/xlnx,spdif.txt b/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
new file mode 100644
index 000000000000..15c2d64d247c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
@@ -0,0 +1,28 @@
+Device-Tree bindings for Xilinx SPDIF IP
+
+The IP supports playback and capture of SPDIF audio
+
+Required properties:
+ - compatible: "xlnx,spdif-2.0"
+ - clock-names: List of input clocks.
+   Required elements: "s_axi_aclk", "aud_clk_i"
+ - clocks: Input clock specifier. Refer to common clock bindings.
+ - reg: Base address and address length of the IP core instance.
+ - interrupts-parent: Phandle for interrupt controller.
+ - interrupts: List of Interrupt numbers.
+ - xlnx,spdif-mode: 0 :- receiver mode
+		    1 :- transmitter mode
+ - xlnx,aud_clk_i: input audio clock value.
+
+Example:
+	spdif_0: spdif@80010000 {
+		clock-names = "aud_clk_i", "s_axi_aclk";
+		clocks = <&misc_clk_0>, <&clk 71>;
+		compatible = "xlnx,spdif-2.0";
+		interrupt-names = "spdif_interrupt";
+		interrupt-parent = <&gic>;
+		interrupts = <0 91 4>;
+		reg = <0x0 0x80010000 0x0 0x10000>;
+		xlnx,spdif-mode = <1>;
+		xlnx,aud_clk_i = <49152913>;
+	};
-- 
2.20.1

