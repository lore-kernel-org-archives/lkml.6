Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C803C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB65B206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887522;
	bh=c87FoV++wvdxnfX55RXnw08Y5m7tbG181zKbX87mwc8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=eLTTdnBgLI9O2Eg0ICuD/UYPc9LkXrKryp8ySgBvUdRP3AHMeC72wACLo6EPXowXj
	 5PVDwZ3Xhys8eEHSqQQ6KBNUQLFJsTd3g1OymQKLVv+8PmIq4VBOeOwOEHb3b6gOjy
	 14L1wPWWdO4EJ7ffTV+cBbFMYGp5AEsP8wn4b61M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfAGS6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:58:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41666 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfAGS6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mU4dkKwQ4z/RKfmF2+h3J9QET5AKjyrVRYnyIn08TGA=; b=chNeQHelAx+U
        eOQHytbr9lINUIDujboi3a2nxpX0D1Na83+fm8IRl/EYNevm2AF4OR2CF9O1OtgBPSJh/rbRLx3lS
        YNXaST0PkZFB73xm6UWzvwynn56HWaEqhOcY906m8jlAr0VotNZ4SYbLCu+adbXhk0MTTplSCi+Lu
        MorqU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6d-0007p7-Th; Mon, 07 Jan 2019 18:58:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8CDFC1127491; Mon,  7 Jan 2019 18:58:35 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: dt-bindings: Document support for ak4497" to the asoc tree
In-Reply-To:  <20190104162649.13103-3-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185835.8CDFC1127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:35 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dt-bindings: Document support for ak4497

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

From 5d8d66077af12681441897a350f346c0da7f5576 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Fri, 4 Jan 2019 16:27:04 +0000
Subject: [PATCH] ASoC: dt-bindings: Document support for ak4497

ak4458 driver supports also ak4497 codec.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/ak4458.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
index 7839be78448d..e5820235e0d5 100644
--- a/Documentation/devicetree/bindings/sound/ak4458.txt
+++ b/Documentation/devicetree/bindings/sound/ak4458.txt
@@ -4,7 +4,7 @@ This device supports I2C mode.
 
 Required properties:
 
-- compatible : "asahi-kasei,ak4458"
+- compatible : "asahi-kasei,ak4458" or "asahi-kasei,ak4497"
 - reg : The I2C address of the device for I2C
 
 Optional properties:
-- 
2.20.1

