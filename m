Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AF4C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C961A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547836714;
	bh=d5J5t9FXK8oeQQD/QiK+BIMuETv1kXCwjlnsZZBWWSI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=pm/UNyqJzqQ+q0ePv7yjYkoBIe0Anb9xIjbh15e150krpCJ1KUyf4v4QyMDmZTYRw
	 /tTChlMttGfiReHAJRgpteHLUJAwlfo8GbiGMGAgEXlhdAUjLiksFk2Vxh9rhhe6wG
	 tJv9prUcj/mM2Six0tW1N9gDdkEKu0cHzoSfs740=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfARSid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:38:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57200 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbfARSic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9UNSHtRuci4KSnGoEUyqO/pL52dBoZeZX8e6vDT7oSw=; b=v6cbDwpbFZJs
        m5z8lnffc2huRp1OmU7leSccx8zmUFZivi6dEAT4cxP1z3KV/kOo/0tGH5kK+WWrcLklcnQmj0RX5
        R8HmYkkHpwdbOB05jOrQVDkSkjODpHoqV/LUIUho+7i5F98ZvG+A7JPmrioj7ZXnw4hTUhXspaEL0
        BX9mQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gkZ2B-0005M0-Ki; Fri, 18 Jan 2019 18:38:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3D8ED11276E7; Fri, 18 Jan 2019 18:38:27 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_sai: Remove expensive print in irq handler" to the asoc tree
In-Reply-To:  <20190118142623.17720-1-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190118183827.3D8ED11276E7@debutante.sirena.org.uk>
Date:   Fri, 18 Jan 2019 18:38:27 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_sai: Remove expensive print in irq handler

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

From e412fcb0db5c44a3450ca678b281ea9332e6bf82 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Fri, 18 Jan 2019 14:26:46 +0000
Subject: [PATCH] ASoC: fsl_sai: Remove expensive print in irq handler

When stopping audio, ASoC will first stop DMA then CPU DAI.
Sometimes there is a delay between DMA stop and CPU DAI stop, which
triggers an underrun error. Now, because of the delay introduced
by dev_err another underrun error will occur causing a vicious circle
making impossible to stop CPU DAI.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 4163f2cfc06f..db9e0872f73d 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -62,10 +62,10 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 		dev_dbg(dev, "isr: Start of Tx word detected\n");
 
 	if (flags & FSL_SAI_CSR_SEF)
-		dev_warn(dev, "isr: Tx Frame sync error detected\n");
+		dev_dbg(dev, "isr: Tx Frame sync error detected\n");
 
 	if (flags & FSL_SAI_CSR_FEF) {
-		dev_warn(dev, "isr: Transmit underrun detected\n");
+		dev_dbg(dev, "isr: Transmit underrun detected\n");
 		/* FIFO reset for safety */
 		xcsr |= FSL_SAI_CSR_FR;
 	}
@@ -96,10 +96,10 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 		dev_dbg(dev, "isr: Start of Rx word detected\n");
 
 	if (flags & FSL_SAI_CSR_SEF)
-		dev_warn(dev, "isr: Rx Frame sync error detected\n");
+		dev_dbg(dev, "isr: Rx Frame sync error detected\n");
 
 	if (flags & FSL_SAI_CSR_FEF) {
-		dev_warn(dev, "isr: Receive overflow detected\n");
+		dev_dbg(dev, "isr: Receive overflow detected\n");
 		/* FIFO reset for safety */
 		xcsr |= FSL_SAI_CSR_FR;
 	}
-- 
2.20.1

