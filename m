Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB73C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF74720840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547662028;
	bh=P3+AwJVlOh7QmTKjL45wx+2I6YeStWYJygYJG3ub0x0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=XWyJkQBIUC7Lt3kAT4gX3o6NMGGG7bC6nAcwhSQHV7liD2dAi4kKuRK88QTjbkC3b
	 34Ipd1CWPmCCuVXB0VaFzjwAkZF0roDDbHPXXo8UfKV0pFUM7RDHoy2KMmG23hT8dA
	 sE8tHF3Ufem9SMdDr7HksJ6h5A/U7IOZ2Va3Lb24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfAPSHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:07:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55574 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfAPSHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VxtsiwJxpPVFGGMEFrg0N5yUlvnl8mDU8YIXx8BJ71k=; b=I7ZHQBLtm1aD
        NkNGlj1WA1DKcb3lzXSBdED+aySaWBWwBEfj2yBN191+/Evt5ZLtRtM0+C9prV4RbHZtHMwFzfQ9p
        Fzn3SJrdDCbMNJX+9uD09mlRUytH5u625C1jwWWHLwaCs/8vAxmve3xxcMgYcrFx3ugtna+NFPGhz
        w1CJ4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjpaZ-0002SY-JP; Wed, 16 Jan 2019 18:06:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 34F5D1126FFD; Wed, 16 Jan 2019 18:06:55 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, tzungbi@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qcom: Kconfig: select max98927 for sdm845" to the asoc tree
In-Reply-To:  <20190115110253.261596-1-cychiang@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190116180655.34F5D1126FFD@debutante.sirena.org.uk>
Date:   Wed, 16 Jan 2019 18:06:55 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qcom: Kconfig: select max98927 for sdm845

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

From 0ddb0fb00a769ef85c788cb40627d09df6919833 Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Tue, 15 Jan 2019 19:02:53 +0800
Subject: [PATCH] ASoC: qcom: Kconfig: select max98927 for sdm845

Select SND_SOC_MAX98927 for SND_SOC_SDM845.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 804ae0d93058..7948e993adba 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -102,6 +102,7 @@ config SND_SOC_SDM845
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
+	select SND_SOC_MAX98927
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
-- 
2.20.1

