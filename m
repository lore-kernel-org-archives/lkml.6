Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933571AbeCMQtj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:49:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40390 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932729AbeCMQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:49:36 -0400
From: Mark Brown <broonie@kernel.org>
To: Olivier Moysan <olivier.moysan@st.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@stlinux.com, linux-kernel@vger.kernel.org,
        olivier.moysan@st.com, jsarha@ti.com, arnaud.pouliquen@st.com,
        benjamin.gaignard@st.com, rmk@arm.linux.org.uk,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: dmaengine_pcm: document process callback" to the asoc tree
In-Reply-To: <1520958428-10930-4-git-send-email-olivier.moysan@st.com>
Message-Id: <20180313164709.D352C440079@finisterre.ee.mobilebroadband>
Date: Tue, 13 Mar 2018 16:47:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dmaengine_pcm: document process callback

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

>From 2e78a5562ebc2e4bbdfd7f7729385b3acc94c36e Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Tue, 13 Mar 2018 17:27:08 +0100
Subject: [PATCH] ASoC: dmaengine_pcm: document process callback

Add missing description of process callback.

Fixes: 78648092ef46 ("ASoC: dmaengine_pcm: add processing support")
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/dmaengine_pcm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 47ef486852ed..e3481eebdd98 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -118,6 +118,8 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
  *   PCM substream. Will be called from the PCM drivers hwparams callback.
  * @compat_request_channel: Callback to request a DMA channel for platforms
  *   which do not use devicetree.
+ * @process: Callback used to apply processing on samples transferred from/to
+ *   user space.
  * @compat_filter_fn: Will be used as the filter function when requesting a
  *  channel for platforms which do not use devicetree. The filter parameter
  *  will be the DAI's DMA data.
-- 
2.16.2
