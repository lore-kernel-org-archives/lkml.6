Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934511AbeBLM2a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:28:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38290 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933194AbeBLM22 (ORCPT
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
Subject: Applied "ASoC: stm32: spdifrx: Use default dai name" to the asoc tree
In-Reply-To: <1517417223-21899-3-git-send-email-olivier.moysan@st.com>
Message-Id: <E1elDCm-0002mT-Dz@debutante>
Date: Mon, 12 Feb 2018 12:27:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: spdifrx: Use default dai name

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

>From 037002b14b7ae217aa79b260228ba51afc516a8c Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Wed, 31 Jan 2018 17:47:03 +0100
Subject: [PATCH] ASoC: stm32: spdifrx: Use default dai name

Use dai name provided by framework from dev_name() function.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 42ad2ae22d21..373df4f24be1 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -819,7 +819,6 @@ static const struct snd_soc_dai_ops stm32_spdifrx_pcm_dai_ops = {
 
 static struct snd_soc_dai_driver stm32_spdifrx_dai[] = {
 	{
-		.name = "spdifrx-capture-cpu-dai",
 		.probe = stm32_spdifrx_dai_probe,
 		.capture = {
 			.stream_name = "CPU-Capture",
-- 
2.16.1
