Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A0CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31F521852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551182793;
	bh=PeoYN6o/eqGlsi6wOzaaQLkFVsrMkpNH7/g5CdyjGII=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JyG1x6uQ/j9Ndasr1pIyCORC1nf5kl4S09wTTBD0b+pp1V/dG0r49y22ePe9oxbSk
	 BbZckG/251zvM5ULn6SmjSYuib0cDloDx5qOansuKONEyGIk8rE9LL0iAwJPrPkMZQ
	 vuWi01ozKp+30BjLY1S/nEMEci8hSOLqgy64j2ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfBZMG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:06:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57516 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfBZMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2b9aa6PgsvVFhQTJ8mHIYo/kijRZUS9JqiqU4v7Z/wg=; b=dwD6/4zEyndP
        heWehUzmieS87cNvL3V8gy6RwSibDg/k9AsO9bbKJSMyIc0g23HzliMOZuzwlpxZzrJmrY5mF67ch
        hIReev0yLJATObISPwUlLqNcXhDKAIQdOu8COAta9jg6SbRLSb+VcOR1UIFlRW3TLk8b4NYPjLO7E
        TT7Hc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gybV3-0007hM-I4; Tue, 26 Feb 2019 12:06:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C2A2A11284E3; Tue, 26 Feb 2019 12:06:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, ncrews@chromium.org,
        rdunlap@infradead.org, tzungbi@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        enric.balletbo@collabora.com, dgreid@chromium.org,
        bleung@chromium.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qcom: Kconfig: fix dependency for sdm845" to the asoc tree
In-Reply-To:  <20190225135405.108052-1-cychiang@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190226120616.C2A2A11284E3@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 12:06:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qcom: Kconfig: fix dependency for sdm845

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

From cdcdba5d624fc3fbad224230ca318c6ddf73795a Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Mon, 25 Feb 2019 21:54:05 +0800
Subject: [PATCH] ASoC: qcom: Kconfig: fix dependency for sdm845

SND_SOC_CROS_EC_CODEC depends on MFD_CROS_EC.
Add that dependency to SND_SOC_SDM845 to fix unmet direct dependencies
warning.

Fixes: 74c6ecf4194e (ASoC: qcom: Kconfig: select dmic for sdm845)
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 8f206cb4fcc0..75ceb04d8bf0 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -98,7 +98,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-	depends on QCOM_APR
+	depends on QCOM_APR && MFD_CROS_EC
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
-- 
2.20.1

