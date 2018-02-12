Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934524AbeBLM2c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:28:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38292 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933156AbeBLM22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:28:28 -0500
From: Mark Brown <broonie@kernel.org>
To: olivier moysan <olivier.moysan@st.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        kernel@stlinux.com, linux-kernel@vger.kernel.org,
        olivier.moysan@st.com, arnaud.pouliquen@st.com,
        benjamin.gaignard@st.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: spdifrx: fix typo in function name." to the asoc tree
In-Reply-To: <1517417223-21899-2-git-send-email-olivier.moysan@st.com>
Message-Id: <E1elDCq-0002ne-BX@debutante>
Date: Mon, 12 Feb 2018 12:27:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: spdifrx: fix typo in function name.

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

>From b9aa4716281247960e009dd55c38bcc4c2e4cb94 Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Wed, 31 Jan 2018 17:47:02 +0100
Subject: [PATCH] ASoC: stm32: spdifrx: fix typo in function name.

Fix function name prefix for naming consistency.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index b9bdefcd3e10..42ad2ae22d21 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -858,8 +858,8 @@ static const struct of_device_id stm32_spdifrx_ids[] = {
 	{}
 };
 
-static int stm_spdifrx_parse_of(struct platform_device *pdev,
-				struct stm32_spdifrx_data *spdifrx)
+static int stm32_spdifrx_parse_of(struct platform_device *pdev,
+				  struct stm32_spdifrx_data *spdifrx)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id;
@@ -914,7 +914,7 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spdifrx);
 
-	ret = stm_spdifrx_parse_of(pdev, spdifrx);
+	ret = stm32_spdifrx_parse_of(pdev, spdifrx);
 	if (ret)
 		return ret;
 
-- 
2.16.1
