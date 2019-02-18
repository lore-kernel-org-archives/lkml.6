Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68740C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0B42177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515961;
	bh=FTBPbaPV5AfbGpUtx43+ePkqVlO443VfbUe6v309n7w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=op4uBoRkvJtzYaDpze6CTu0SmpgzZKxE+ravUj759bN1e1necdzCJRHB6D2smFCl8
	 USyZA1nN0oojEYY+/gWsvQ4/D9Bbmn9HwFN3llw5D9/spsmLHMDXjlU2pPRhVQ4Nj9
	 2OxdZmSNoiZo3Lxc/r6igF8ZvMO67A4qOLjPNqZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfBRSwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:52:39 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47140 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfBRSwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=V462IumyxR+y3sckXpOoKDQDxLViaSTjuv8PZIOQYrY=; b=GYXKkNsazdMR
        mgDLS1grSjybWo4N0h1xoNw+OJHrefmMfyhxEme68zJziWUOfWgp3KfORvIeaxypBa59xdg8bhEil
        d3d6RD4ZxEkdMC4alyYP8DsMNfahwvgScyH0HNSgEfFQ4vuYJfNBSGDGTNdoaxkv6FH5R/UsrFzm5
        pC9LE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvo1o-0001iv-Ge; Mon, 18 Feb 2019 18:52:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DDB971128008; Mon, 18 Feb 2019 18:52:31 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, tzungbi@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qcom: Kconfig: select dmic for sdm845" to the asoc tree
In-Reply-To:  <20190218041819.115729-1-cychiang@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190218185231.DDB971128008@debutante.sirena.org.uk>
Date:   Mon, 18 Feb 2019 18:52:31 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qcom: Kconfig: select dmic for sdm845

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

From 74c6ecf4194ebed285b29964a950e0cd7414fe19 Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Mon, 18 Feb 2019 12:18:19 +0800
Subject: [PATCH] ASoC: qcom: Kconfig: select dmic for sdm845

sdm845 uses dmic on EC so it should select CROS_EC_CODEC.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 7948e993adba..8f206cb4fcc0 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -103,6 +103,7 @@ config SND_SOC_SDM845
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
 	select SND_SOC_MAX98927
+	select SND_SOC_CROS_EC_CODEC
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.20.1

