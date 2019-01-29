Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB760C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8764220857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548785554;
	bh=frryMwST4CTE/Q0lZnnib7r8BaG7FlzbH6tBgCDiGqI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=mrCrMr3AeDDhExv2vSA/mf8+gd5Je6IHFEMlCqkEgu1v3HjytUDusmtkGIRja2MfG
	 3hPHO5u4PyCexncnOflQSRMFyfe8FXML/d6aonXJR7MBHQr2oPw1wVvkSuJROJtOD6
	 Wl6/tCs+FhHd7p9NyoUKtoTFAWyETqClBT8FNHDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfA2SMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:12:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59976 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbfA2SMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=UqyLHhB4Q7jDy2scymt74Q1MaT3smPGcxpy+HkRAuPY=; b=X7HQjYFuxO3H
        HJGdblLFr6G3Kfllw2HNOeXOdCI9ufFuxJBzkn/IcS3cfVJxXvYIJYs250YeXqDJ0ZPPaFb/KHYQy
        rusEkTbo3PFZDAfHsvZF/GjGtTYv8XcZGwVpUDw+psvcZcc9YnnBCsSpXPtRqg8fNv2S3Eo+eYlSQ
        vE44s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goXrt-0000yA-Oi; Tue, 29 Jan 2019 18:12:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C53961127D50; Tue, 29 Jan 2019 18:12:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: sprd: Add Spreadtrum audio DMA platfrom driver" to the asoc tree
In-Reply-To:  <d02bf3a04f6bfcd28f9689cbb6b4dff0132b71da.1548747137.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190129181216.C53961127D50@debutante.sirena.org.uk>
Date:   Tue, 29 Jan 2019 18:12:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sprd: Add Spreadtrum audio DMA platfrom driver

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

From 42fea318e1d19c0214ed4336d19f512c5d78cc3b Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 29 Jan 2019 16:04:45 +0800
Subject: [PATCH] ASoC: sprd: Add Spreadtrum audio DMA platfrom driver

The Spreadtrum DMA engine uses the link-list mode to support audio playback
or capture, thus this patch adds audio DMA platform support for CPU DAI to
trigger DMA link-list transfer.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/Kconfig             |   1 +
 sound/soc/Makefile            |   1 +
 sound/soc/sprd/Kconfig        |   6 +
 sound/soc/sprd/Makefile       |   4 +
 sound/soc/sprd/sprd-pcm-dma.c | 562 ++++++++++++++++++++++++++++++++++
 sound/soc/sprd/sprd-pcm-dma.h |  15 +
 6 files changed, 589 insertions(+)
 create mode 100644 sound/soc/sprd/Kconfig
 create mode 100644 sound/soc/sprd/Makefile
 create mode 100644 sound/soc/sprd/sprd-pcm-dma.c
 create mode 100644 sound/soc/sprd/sprd-pcm-dma.h

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 6592a422a047..aa35940f5c50 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -64,6 +64,7 @@ source "sound/soc/samsung/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/sirf/Kconfig"
 source "sound/soc/spear/Kconfig"
+source "sound/soc/sprd/Kconfig"
 source "sound/soc/sti/Kconfig"
 source "sound/soc/stm/Kconfig"
 source "sound/soc/sunxi/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 48c48c1c893c..974fb9821e17 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= sirf/
 obj-$(CONFIG_SND_SOC)	+= spear/
+obj-$(CONFIG_SND_SOC)	+= sprd/
 obj-$(CONFIG_SND_SOC)	+= sti/
 obj-$(CONFIG_SND_SOC)	+= stm/
 obj-$(CONFIG_SND_SOC)	+= sunxi/
diff --git a/sound/soc/sprd/Kconfig b/sound/soc/sprd/Kconfig
new file mode 100644
index 000000000000..43ece7daf0e9
--- /dev/null
+++ b/sound/soc/sprd/Kconfig
@@ -0,0 +1,6 @@
+config SND_SOC_SPRD
+	tristate "SoC Audio for the Spreadtrum SoC chips"
+	depends on ARCH_SPRD || COMPILE_TEST
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the Spreadtrum SoCs' Audio interfaces.
diff --git a/sound/soc/sprd/Makefile b/sound/soc/sprd/Makefile
new file mode 100644
index 000000000000..47620e57a9f2
--- /dev/null
+++ b/sound/soc/sprd/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Spreadtrum Audio Support
+
+obj-$(CONFIG_SND_SOC_SPRD)	+= sprd-pcm-dma.o
diff --git a/sound/soc/sprd/sprd-pcm-dma.c b/sound/soc/sprd/sprd-pcm-dma.c
new file mode 100644
index 000000000000..cbb27c4abeba
--- /dev/null
+++ b/sound/soc/sprd/sprd-pcm-dma.c
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Spreadtrum Communications Inc.
+
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/dma/sprd-dma.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "sprd-pcm-dma.h"
+
+#define DRV_NAME			"sprd_pcm_dma"
+#define SPRD_PCM_DMA_LINKLIST_SIZE	64
+#define SPRD_PCM_DMA_BRUST_LEN		640
+
+struct sprd_pcm_dma_data {
+	struct dma_chan *chan;
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t cookie;
+	dma_addr_t phys;
+	void *virt;
+	int pre_pointer;
+};
+
+struct sprd_pcm_dma_private {
+	struct snd_pcm_substream *substream;
+	struct sprd_pcm_dma_params *params;
+	struct sprd_pcm_dma_data data[SPRD_PCM_CHANNEL_MAX];
+	int hw_chan;
+	int dma_addr_offset;
+};
+
+static const struct snd_pcm_hardware sprd_pcm_hardware = {
+	.info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_PAUSE |
+		SNDRV_PCM_INFO_RESUME | SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	.period_bytes_min = 1,
+	.period_bytes_max = 64 * 1024,
+	.periods_min = 1,
+	.periods_max = PAGE_SIZE / SPRD_PCM_DMA_LINKLIST_SIZE,
+	.buffer_bytes_max = 64 * 1024,
+};
+
+static int sprd_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = component->dev;
+	struct sprd_pcm_dma_private *dma_private;
+	int hw_chan = SPRD_PCM_CHANNEL_MAX;
+	int size, ret, i;
+
+	snd_soc_set_runtime_hwparams(substream, &sprd_pcm_hardware);
+
+	ret = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+					 SPRD_PCM_DMA_BRUST_LEN);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+					 SPRD_PCM_DMA_BRUST_LEN);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+
+	dma_private = devm_kzalloc(dev, sizeof(*dma_private), GFP_KERNEL);
+	if (!dma_private)
+		return -ENOMEM;
+
+	size = runtime->hw.periods_max * SPRD_PCM_DMA_LINKLIST_SIZE;
+
+	for (i = 0; i < hw_chan; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+		data->virt = dmam_alloc_coherent(dev, size, &data->phys,
+						 GFP_KERNEL);
+		if (!data->virt) {
+			ret = -ENOMEM;
+			goto error;
+		}
+	}
+
+	dma_private->hw_chan = hw_chan;
+	runtime->private_data = dma_private;
+	dma_private->substream = substream;
+
+	return 0;
+
+error:
+	for (i = 0; i < hw_chan; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+		if (data->virt)
+			dmam_free_coherent(dev, size, data->virt, data->phys);
+	}
+
+	devm_kfree(dev, dma_private);
+	return ret;
+}
+
+static int sprd_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sprd_pcm_dma_private *dma_private = runtime->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = component->dev;
+	int size = runtime->hw.periods_max * SPRD_PCM_DMA_LINKLIST_SIZE;
+	int i;
+
+	for (i = 0; i < dma_private->hw_chan; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+		dmam_free_coherent(dev, size, data->virt, data->phys);
+	}
+
+	devm_kfree(dev, dma_private);
+
+	return 0;
+}
+
+static void sprd_pcm_dma_complete(void *data)
+{
+	struct sprd_pcm_dma_private *dma_private = data;
+	struct snd_pcm_substream *substream = dma_private->substream;
+
+	snd_pcm_period_elapsed(substream);
+}
+
+static void sprd_pcm_release_dma_channel(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sprd_pcm_dma_private *dma_private = runtime->private_data;
+	int i;
+
+	for (i = 0; i < SPRD_PCM_CHANNEL_MAX; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+		if (data->chan) {
+			dma_release_channel(data->chan);
+			data->chan = NULL;
+		}
+	}
+}
+
+static int sprd_pcm_request_dma_channel(struct snd_pcm_substream *substream,
+					int channels)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sprd_pcm_dma_private *dma_private = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = component->dev;
+	struct sprd_pcm_dma_params *dma_params = dma_private->params;
+	int i;
+
+	if (channels > SPRD_PCM_CHANNEL_MAX) {
+		dev_err(dev, "invalid dma channel number:%d\n", channels);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < channels; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+		data->chan = dma_request_slave_channel(dev,
+						       dma_params->chan_name[i]);
+		if (!data->chan) {
+			dev_err(dev, "failed to request dma channel:%s\n",
+				dma_params->chan_name[i]);
+			sprd_pcm_release_dma_channel(substream);
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+static int sprd_pcm_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct sprd_pcm_dma_private *dma_private = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct sprd_pcm_dma_params *dma_params;
+	size_t totsize = params_buffer_bytes(params);
+	size_t period = params_period_bytes(params);
+	int channels = params_channels(params);
+	int is_playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	struct scatterlist *sg;
+	unsigned long flags;
+	int ret, i, j, sg_num;
+
+	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+	if (!dma_params) {
+		dev_warn(component->dev, "no dma parameters setting\n");
+		dma_private->params = NULL;
+		snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+		runtime->dma_bytes = totsize;
+		return 0;
+	}
+
+	if (!dma_private->params) {
+		dma_private->params = dma_params;
+		ret = sprd_pcm_request_dma_channel(substream, channels);
+		if (ret)
+			return ret;
+	}
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+
+	runtime->dma_bytes = totsize;
+	sg_num = totsize / period;
+	dma_private->dma_addr_offset = totsize / channels;
+
+	sg = devm_kcalloc(component->dev, sg_num, sizeof(*sg), GFP_KERNEL);
+	if (!sg) {
+		ret = -ENOMEM;
+		goto sg_err;
+	}
+
+	for (i = 0; i < channels; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+		struct dma_chan *chan = data->chan;
+		struct dma_slave_config config = { };
+		struct sprd_dma_linklist link = { };
+		enum dma_transfer_direction dir;
+		struct scatterlist *sgt = sg;
+
+		config.src_maxburst = dma_params->fragment_len[i];
+		config.src_addr_width = dma_params->datawidth[i];
+		config.dst_addr_width = dma_params->datawidth[i];
+		if (is_playback) {
+			config.src_addr = runtime->dma_addr +
+				i * dma_private->dma_addr_offset;
+			config.dst_addr = dma_params->dev_phys[i];
+			dir = DMA_MEM_TO_DEV;
+		} else {
+			config.src_addr = dma_params->dev_phys[i];
+			config.dst_addr = runtime->dma_addr +
+				i * dma_private->dma_addr_offset;
+			dir = DMA_DEV_TO_MEM;
+		}
+
+		sg_init_table(sgt, sg_num);
+		for (j = 0; j < sg_num; j++, sgt++) {
+			u32 sg_len = period / channels;
+
+			sg_dma_len(sgt) = sg_len;
+			sg_dma_address(sgt) = runtime->dma_addr +
+				i * dma_private->dma_addr_offset + sg_len * j;
+		}
+
+		/*
+		 * Configure the link-list address for the DMA engine link-list
+		 * mode.
+		 */
+		link.virt_addr = (unsigned long)data->virt;
+		link.phy_addr = data->phys;
+
+		ret = dmaengine_slave_config(chan, &config);
+		if (ret) {
+			dev_err(component->dev,
+				"failed to set slave configuration: %d\n", ret);
+			goto config_err;
+		}
+
+		/*
+		 * We configure the DMA request mode, interrupt mode, channel
+		 * mode and channel trigger mode by the flags.
+		 */
+		flags = SPRD_DMA_FLAGS(SPRD_DMA_CHN_MODE_NONE, SPRD_DMA_NO_TRG,
+				       SPRD_DMA_FRAG_REQ, SPRD_DMA_TRANS_INT);
+		data->desc = chan->device->device_prep_slave_sg(chan, sg,
+								sg_num, dir,
+								flags, &link);
+		if (!data->desc) {
+			dev_err(component->dev, "failed to prepare slave sg\n");
+			ret = -ENOMEM;
+			goto config_err;
+		}
+
+		if (!runtime->no_period_wakeup) {
+			data->desc->callback = sprd_pcm_dma_complete;
+			data->desc->callback_param = dma_private;
+		}
+	}
+
+	devm_kfree(component->dev, sg);
+
+	return 0;
+
+config_err:
+	devm_kfree(component->dev, sg);
+sg_err:
+	sprd_pcm_release_dma_channel(substream);
+	return ret;
+}
+
+static int sprd_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	sprd_pcm_release_dma_channel(substream);
+
+	return 0;
+}
+
+static int sprd_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct sprd_pcm_dma_private *dma_private =
+		substream->runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	int ret = 0, i;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		for (i = 0; i < dma_private->hw_chan; i++) {
+			struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+			if (!data->desc)
+				continue;
+
+			data->cookie = dmaengine_submit(data->desc);
+			ret = dma_submit_error(data->cookie);
+			if (ret) {
+				dev_err(component->dev,
+					"failed to submit dma request: %d\n",
+					ret);
+				return ret;
+			}
+
+			dma_async_issue_pending(data->chan);
+		}
+
+		break;
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		for (i = 0; i < dma_private->hw_chan; i++) {
+			struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+			if (data->chan)
+				dmaengine_resume(data->chan);
+		}
+
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		for (i = 0; i < dma_private->hw_chan; i++) {
+			struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+			if (data->chan)
+				dmaengine_terminate_async(data->chan);
+		}
+
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		for (i = 0; i < dma_private->hw_chan; i++) {
+			struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+			if (data->chan)
+				dmaengine_pause(data->chan);
+		}
+
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t sprd_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sprd_pcm_dma_private *dma_private = runtime->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	int pointer[SPRD_PCM_CHANNEL_MAX];
+	int bytes_of_pointer = 0, sel_max = 0, i;
+	snd_pcm_uframes_t x;
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	for (i = 0; i < dma_private->hw_chan; i++) {
+		struct sprd_pcm_dma_data *data = &dma_private->data[i];
+
+		if (!data->chan)
+			continue;
+
+		status = dmaengine_tx_status(data->chan, data->cookie, &state);
+		if (status == DMA_ERROR) {
+			dev_err(component->dev,
+				"failed to get dma channel %d status\n", i);
+			return 0;
+		}
+
+		/*
+		 * We just get current transfer address from the DMA engine, so
+		 * we need convert to current pointer.
+		 */
+		pointer[i] = state.residue - runtime->dma_addr -
+			i * dma_private->dma_addr_offset;
+
+		if (i == 0) {
+			bytes_of_pointer = pointer[i];
+			sel_max = pointer[i] < data->pre_pointer ? 1 : 0;
+		} else {
+			sel_max ^= pointer[i] < data->pre_pointer ? 1 : 0;
+
+			if (sel_max)
+				bytes_of_pointer =
+					max(pointer[i], pointer[i - 1]) << 1;
+			else
+				bytes_of_pointer =
+					min(pointer[i], pointer[i - 1]) << 1;
+		}
+
+		data->pre_pointer = pointer[i];
+	}
+
+	x = bytes_to_frames(runtime, bytes_of_pointer);
+	if (x == runtime->buffer_size)
+		x = 0;
+
+	return x;
+}
+
+static int sprd_pcm_mmap(struct snd_pcm_substream *substream,
+			 struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	return remap_pfn_range(vma, vma->vm_start,
+			       runtime->dma_addr >> PAGE_SHIFT,
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot);
+}
+
+static struct snd_pcm_ops sprd_pcm_ops = {
+	.open = sprd_pcm_open,
+	.close = sprd_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = sprd_pcm_hw_params,
+	.hw_free = sprd_pcm_hw_free,
+	.trigger = sprd_pcm_trigger,
+	.pointer = sprd_pcm_pointer,
+	.mmap = sprd_pcm_mmap,
+};
+
+static int sprd_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_card *card = rtd->card->snd_card;
+	struct snd_pcm *pcm = rtd->pcm;
+	struct snd_pcm_substream *substream;
+	int ret;
+
+	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	if (substream) {
+		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
+					  sprd_pcm_hardware.buffer_bytes_max,
+					  &substream->dma_buffer);
+		if (ret) {
+			dev_err(card->dev,
+				"can't alloc playback dma buffer: %d\n", ret);
+			return ret;
+		}
+	}
+
+	substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
+	if (substream) {
+		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, card->dev,
+					  sprd_pcm_hardware.buffer_bytes_max,
+					  &substream->dma_buffer);
+		if (ret) {
+			dev_err(card->dev,
+				"can't alloc capture dma buffer: %d\n", ret);
+			snd_dma_free_pages(&pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->dma_buffer);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void sprd_pcm_free(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pcm->streams); i++) {
+		substream = pcm->streams[i].substream;
+		if (substream) {
+			snd_dma_free_pages(&substream->dma_buffer);
+			substream->dma_buffer.area = NULL;
+			substream->dma_buffer.addr = 0;
+		}
+	}
+}
+
+static const struct snd_soc_component_driver sprd_soc_component = {
+	.name		= DRV_NAME,
+	.ops		= &sprd_pcm_ops,
+	.pcm_new	= sprd_pcm_new,
+	.pcm_free	= sprd_pcm_free,
+};
+
+static int sprd_soc_platform_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &sprd_soc_component,
+					      NULL, 0);
+	if (ret)
+		dev_err(&pdev->dev, "could not register platform:%d\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id sprd_pcm_of_match[] = {
+	{ .compatible = "sprd,pcm-platform", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sprd_pcm_of_match);
+
+static struct platform_driver sprd_pcm_driver = {
+	.driver = {
+		.name = "sprd-pcm-audio",
+		.of_match_table = sprd_pcm_of_match,
+	},
+
+	.probe = sprd_soc_platform_probe,
+};
+
+module_platform_driver(sprd_pcm_driver);
+
+MODULE_DESCRIPTION("Spreadtrum ASoC PCM DMA");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:sprd-audio");
diff --git a/sound/soc/sprd/sprd-pcm-dma.h b/sound/soc/sprd/sprd-pcm-dma.h
new file mode 100644
index 000000000000..d85a34f1461d
--- /dev/null
+++ b/sound/soc/sprd/sprd-pcm-dma.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __SPRD_PCM_DMA_H
+#define __SPRD_PCM_DMA_H
+
+#define SPRD_PCM_CHANNEL_MAX	2
+
+struct sprd_pcm_dma_params {
+	dma_addr_t dev_phys[SPRD_PCM_CHANNEL_MAX];
+	u32 datawidth[SPRD_PCM_CHANNEL_MAX];
+	u32 fragment_len[SPRD_PCM_CHANNEL_MAX];
+	const char *chan_name[SPRD_PCM_CHANNEL_MAX];
+};
+
+#endif /* __SPRD_PCM_DMA_H */
-- 
2.20.1

