Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EBFC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8722320892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791470;
	bh=eq85YXIoHECgpxj1m+FlDB/EfPCsHf8T9opCgfPyp1c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=lGI39Dj5DlwiN5onmmrzowIeop8htiFLeU2/OulpDhwDfzMFAKVeY9TXtAkUK/k43
	 kLGHAEMMNDcj1ex7DSWq2MznEiCekeTLA4q7VNUpXd9abvl2Qpn+uw2tydHmlpDkVm
	 cs7NkZAHtL05pXpOB3zwTWeM6/bLnjwzU3QRChxg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8722320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbeLNMoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:44:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41112 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbeLNMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Y4BuVQy06zpqRgXeODAUHEBXyRVoDxqOc0AyhiB4lUU=; b=SY4YQ+Y4fua6
        tinSJ36r8yGx02yGURXngecNEERVbYHv/+HS2fWUHIamcUFQ4mTXpI2Ff4Awx1vnspaty9fvfFW2j
        lGEkftelov1tqJZxBEifs7cByG2tizjyRCZUH74Y3tRhLB9ZmN11iKRU7jRTMFYuy1knR5wDXye0T
        CZMUs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXmpB-0006l7-S6; Fri, 14 Dec 2018 12:44:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5111E11258A2; Fri, 14 Dec 2018 12:44:13 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, vkoul@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        tiwai@suse.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, rohitkr@codeaurora.org, srini@kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6asm-dai: Add support to compress offload" to the asoc tree
In-Reply-To:  <20181115181324.26784-6-srinivas.kandagatla@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20181214124413.5111E11258A2@debutante.sirena.org.uk>
Date:   Fri, 14 Dec 2018 12:44:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6asm-dai: Add support to compress offload

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

From 22930c79ac5c243c95e46508f0989e153836adc7 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 15 Nov 2018 18:13:24 +0000
Subject: [PATCH] ASoC: qdsp6: q6asm-dai: Add support to compress offload

This patch adds MP3 playback support in q6asm dais, adding other codec
support should be pretty trivial.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig           |   1 +
 sound/soc/qcom/qdsp6/q6asm-dai.c | 372 ++++++++++++++++++++++++++++++-
 2 files changed, 372 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 1b9fc0665792..804ae0d93058 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -66,6 +66,7 @@ config SND_SOC_QDSP6_ASM
 	tristate
 
 config SND_SOC_QDSP6_ASM_DAI
+	select SND_SOC_COMPRESS
 	tristate
 
 config SND_SOC_QDSP6
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 86115de5c1b2..5b986b74dd36 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -10,6 +10,8 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
+#include <linux/spinlock.h>
+#include <sound/compress_driver.h>
 #include <asm/dma.h>
 #include <linux/dma-mapping.h>
 #include <linux/of_device.h>
@@ -30,6 +32,15 @@
 #define CAPTURE_MIN_PERIOD_SIZE     320
 #define SID_MASK_DEFAULT	0xF
 
+/* Default values used if user space does not set */
+#define COMPR_PLAYBACK_MIN_FRAGMENT_SIZE (8 * 1024)
+#define COMPR_PLAYBACK_MAX_FRAGMENT_SIZE (128 * 1024)
+#define COMPR_PLAYBACK_MIN_NUM_FRAGMENTS (4)
+#define COMPR_PLAYBACK_MAX_NUM_FRAGMENTS (16 * 4)
+#define Q6ASM_DAI_TX_RX	0
+#define Q6ASM_DAI_TX	1
+#define Q6ASM_DAI_RX	2
+
 enum stream_state {
 	Q6ASM_STREAM_IDLE = 0,
 	Q6ASM_STREAM_STOPPED,
@@ -38,11 +49,18 @@ enum stream_state {
 
 struct q6asm_dai_rtd {
 	struct snd_pcm_substream *substream;
+	struct snd_compr_stream *cstream;
+	struct snd_compr_params codec_param;
+	struct snd_dma_buffer dma_buffer;
+	spinlock_t lock;
 	phys_addr_t phys;
 	unsigned int pcm_size;
 	unsigned int pcm_count;
 	unsigned int pcm_irq_pos;       /* IRQ position */
 	unsigned int periods;
+	unsigned int bytes_sent;
+	unsigned int bytes_received;
+	unsigned int copied_total;
 	uint16_t bits_per_sample;
 	uint16_t source; /* Encoding source bit mask */
 	struct audio_client *audio_client;
@@ -137,6 +155,21 @@ static struct snd_pcm_hw_constraint_list constraints_sample_rates = {
 	.mask = 0,
 };
 
+static const struct snd_compr_codec_caps q6asm_compr_caps = {
+	.num_descriptors = 1,
+	.descriptor[0].max_ch = 2,
+	.descriptor[0].sample_rates = {	8000, 11025, 12000, 16000, 22050,
+					24000, 32000, 44100, 48000, 88200,
+					96000, 176400, 192000 },
+	.descriptor[0].num_sample_rates = 13,
+	.descriptor[0].bit_rate[0] = 320,
+	.descriptor[0].bit_rate[1] = 128,
+	.descriptor[0].num_bitrates = 2,
+	.descriptor[0].profiles = 0,
+	.descriptor[0].modes = SND_AUDIOCHANMODE_MP3_STEREO,
+	.descriptor[0].formats = 0,
+};
+
 static void event_handler(uint32_t opcode, uint32_t token,
 			  uint32_t *payload, void *priv)
 {
@@ -460,6 +493,306 @@ static struct snd_pcm_ops q6asm_dai_ops = {
 	.mmap		= q6asm_dai_mmap,
 };
 
+static void compress_event_handler(uint32_t opcode, uint32_t token,
+				   uint32_t *payload, void *priv)
+{
+	struct q6asm_dai_rtd *prtd = priv;
+	struct snd_compr_stream *substream = prtd->cstream;
+	unsigned long flags;
+	uint64_t avail;
+
+	switch (opcode) {
+	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
+		spin_lock_irqsave(&prtd->lock, flags);
+		if (!prtd->bytes_sent) {
+			q6asm_write_async(prtd->audio_client, prtd->pcm_count,
+					  0, 0, NO_TIMESTAMP);
+			prtd->bytes_sent += prtd->pcm_count;
+		}
+
+		spin_unlock_irqrestore(&prtd->lock, flags);
+		break;
+
+	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
+		prtd->state = Q6ASM_STREAM_STOPPED;
+		break;
+
+	case ASM_CLIENT_EVENT_DATA_WRITE_DONE:
+		spin_lock_irqsave(&prtd->lock, flags);
+
+		prtd->copied_total += prtd->pcm_count;
+		snd_compr_fragment_elapsed(substream);
+
+		if (prtd->state != Q6ASM_STREAM_RUNNING) {
+			spin_unlock_irqrestore(&prtd->lock, flags);
+			break;
+		}
+
+		avail = prtd->bytes_received - prtd->bytes_sent;
+
+		if (avail >= prtd->pcm_count) {
+			q6asm_write_async(prtd->audio_client,
+					   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+			prtd->bytes_sent += prtd->pcm_count;
+		}
+
+		spin_unlock_irqrestore(&prtd->lock, flags);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int q6asm_dai_compr_open(struct snd_compr_stream *stream)
+{
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct snd_soc_component *c = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct q6asm_dai_data *pdata;
+	struct device *dev = c->dev;
+	struct q6asm_dai_rtd *prtd;
+	int stream_id, size, ret;
+
+	stream_id = cpu_dai->driver->id;
+	pdata = snd_soc_component_get_drvdata(c);
+	if (!pdata) {
+		dev_err(dev, "Drv data not found ..\n");
+		return -EINVAL;
+	}
+
+	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
+	if (!prtd)
+		return -ENOMEM;
+
+	prtd->cstream = stream;
+	prtd->audio_client = q6asm_audio_client_alloc(dev,
+					(q6asm_cb)compress_event_handler,
+					prtd, stream_id, LEGACY_PCM_MODE);
+	if (!prtd->audio_client) {
+		dev_err(dev, "Could not allocate memory\n");
+		kfree(prtd);
+		return -ENOMEM;
+	}
+
+	size = COMPR_PLAYBACK_MAX_FRAGMENT_SIZE *
+			COMPR_PLAYBACK_MAX_NUM_FRAGMENTS;
+	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
+				  &prtd->dma_buffer);
+	if (ret) {
+		dev_err(dev, "Cannot allocate buffer(s)\n");
+		return ret;
+	}
+
+	if (pdata->sid < 0)
+		prtd->phys = prtd->dma_buffer.addr;
+	else
+		prtd->phys = prtd->dma_buffer.addr | (pdata->sid << 32);
+
+	snd_compr_set_runtime_buffer(stream, &prtd->dma_buffer);
+	spin_lock_init(&prtd->lock);
+	runtime->private_data = prtd;
+
+	return 0;
+}
+
+static int q6asm_dai_compr_free(struct snd_compr_stream *stream)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+
+	if (prtd->audio_client) {
+		if (prtd->state)
+			q6asm_cmd(prtd->audio_client, CMD_CLOSE);
+
+		snd_dma_free_pages(&prtd->dma_buffer);
+		q6asm_unmap_memory_regions(stream->direction,
+					   prtd->audio_client);
+		q6asm_audio_client_free(prtd->audio_client);
+		prtd->audio_client = NULL;
+	}
+	q6routing_stream_close(rtd->dai_link->id, stream->direction);
+	kfree(prtd);
+
+	return 0;
+}
+
+static int q6asm_dai_compr_set_params(struct snd_compr_stream *stream,
+				      struct snd_compr_params *params)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct snd_soc_component *c = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	int dir = stream->direction;
+	struct q6asm_dai_data *pdata;
+	struct device *dev = c->dev;
+	int ret;
+
+	memcpy(&prtd->codec_param, params, sizeof(*params));
+
+	pdata = snd_soc_component_get_drvdata(c);
+	if (!pdata)
+		return -EINVAL;
+
+	if (!prtd || !prtd->audio_client) {
+		dev_err(dev, "private data null or audio client freed\n");
+		return -EINVAL;
+	}
+
+	prtd->periods = runtime->fragments;
+	prtd->pcm_count = runtime->fragment_size;
+	prtd->pcm_size = runtime->fragments * runtime->fragment_size;
+	prtd->bits_per_sample = 16;
+	if (dir == SND_COMPRESS_PLAYBACK) {
+		ret = q6asm_open_write(prtd->audio_client, params->codec.id,
+					prtd->bits_per_sample);
+
+		if (ret < 0) {
+			dev_err(dev, "q6asm_open_write failed\n");
+			q6asm_audio_client_free(prtd->audio_client);
+			prtd->audio_client = NULL;
+			return ret;
+		}
+	}
+
+	prtd->session_id = q6asm_get_session_id(prtd->audio_client);
+	ret = q6routing_stream_open(rtd->dai_link->id, LEGACY_PCM_MODE,
+			      prtd->session_id, dir);
+	if (ret) {
+		dev_err(dev, "Stream reg failed ret:%d\n", ret);
+		return ret;
+	}
+
+	ret = q6asm_map_memory_regions(dir, prtd->audio_client, prtd->phys,
+				       (prtd->pcm_size / prtd->periods),
+				       prtd->periods);
+
+	if (ret < 0) {
+		dev_err(dev, "Buffer Mapping failed ret:%d\n", ret);
+		return -ENOMEM;
+	}
+
+	prtd->state = Q6ASM_STREAM_RUNNING;
+
+	return 0;
+}
+
+static int q6asm_dai_compr_trigger(struct snd_compr_stream *stream, int cmd)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret = q6asm_run_nowait(prtd->audio_client, 0, 0, 0);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		prtd->state = Q6ASM_STREAM_STOPPED;
+		ret = q6asm_cmd_nowait(prtd->audio_client, CMD_EOS);
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ret = q6asm_cmd_nowait(prtd->audio_client, CMD_PAUSE);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int q6asm_dai_compr_pointer(struct snd_compr_stream *stream,
+		struct snd_compr_tstamp *tstamp)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&prtd->lock, flags);
+
+	tstamp->copied_total = prtd->copied_total;
+	tstamp->byte_offset = prtd->copied_total % prtd->pcm_size;
+
+	spin_unlock_irqrestore(&prtd->lock, flags);
+
+	return 0;
+}
+
+static int q6asm_dai_compr_ack(struct snd_compr_stream *stream,
+				size_t count)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&prtd->lock, flags);
+	prtd->bytes_received += count;
+	spin_unlock_irqrestore(&prtd->lock, flags);
+
+	return count;
+}
+
+static int q6asm_dai_compr_mmap(struct snd_compr_stream *stream,
+		struct vm_area_struct *vma)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct snd_soc_component *c = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = c->dev;
+
+	return dma_mmap_coherent(dev, vma,
+			prtd->dma_buffer.area, prtd->dma_buffer.addr,
+			prtd->dma_buffer.bytes);
+}
+
+static int q6asm_dai_compr_get_caps(struct snd_compr_stream *stream,
+				    struct snd_compr_caps *caps)
+{
+	caps->direction = SND_COMPRESS_PLAYBACK;
+	caps->min_fragment_size = COMPR_PLAYBACK_MIN_FRAGMENT_SIZE;
+	caps->max_fragment_size = COMPR_PLAYBACK_MAX_FRAGMENT_SIZE;
+	caps->min_fragments = COMPR_PLAYBACK_MIN_NUM_FRAGMENTS;
+	caps->max_fragments = COMPR_PLAYBACK_MAX_NUM_FRAGMENTS;
+	caps->num_codecs = 1;
+	caps->codecs[0] = SND_AUDIOCODEC_MP3;
+
+	return 0;
+}
+
+static int q6asm_dai_compr_get_codec_caps(struct snd_compr_stream *stream,
+					  struct snd_compr_codec_caps *codec)
+{
+	switch (codec->codec) {
+	case SND_AUDIOCODEC_MP3:
+		*codec = q6asm_compr_caps;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct snd_compr_ops q6asm_dai_compr_ops = {
+	.open		= q6asm_dai_compr_open,
+	.free		= q6asm_dai_compr_free,
+	.set_params	= q6asm_dai_compr_set_params,
+	.pointer	= q6asm_dai_compr_pointer,
+	.trigger	= q6asm_dai_compr_trigger,
+	.get_caps	= q6asm_dai_compr_get_caps,
+	.get_codec_caps	= q6asm_dai_compr_get_codec_caps,
+	.mmap		= q6asm_dai_compr_mmap,
+	.ack		= q6asm_dai_compr_ack,
+};
+
 static int q6asm_dai_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_pcm_substream *psubstream, *csubstream;
@@ -515,7 +848,7 @@ static const struct snd_soc_component_driver q6asm_fe_dai_component = {
 	.ops		= &q6asm_dai_ops,
 	.pcm_new	= q6asm_dai_pcm_new,
 	.pcm_free	= q6asm_dai_pcm_free,
-
+	.compr_ops	= &q6asm_dai_compr_ops,
 };
 
 static struct snd_soc_dai_driver q6asm_fe_dais[] = {
@@ -529,6 +862,41 @@ static struct snd_soc_dai_driver q6asm_fe_dais[] = {
 	Q6ASM_FEDAI_DRIVER(8),
 };
 
+static int of_q6asm_parse_dai_data(struct device *dev,
+				    struct q6asm_dai_data *pdata)
+{
+	static struct snd_soc_dai_driver *dai_drv;
+	struct snd_soc_pcm_stream empty_stream;
+	struct device_node *node;
+	int ret, id, dir;
+
+	memset(&empty_stream, 0, sizeof(empty_stream));
+
+	for_each_child_of_node(dev->of_node, node) {
+		ret = of_property_read_u32(node, "reg", &id);
+		if (ret || id > MAX_SESSIONS || id < 0) {
+			dev_err(dev, "valid dai id not found:%d\n", ret);
+			continue;
+		}
+
+		dai_drv = &q6asm_fe_dais[id];
+
+		ret = of_property_read_u32(node, "direction", &dir);
+		if (ret)
+			continue;
+
+		if (dir == Q6ASM_DAI_RX)
+			dai_drv->capture = empty_stream;
+		else if (dir == Q6ASM_DAI_TX)
+			dai_drv->playback = empty_stream;
+
+		if (of_property_read_bool(node, "is-compress-dai"))
+			dai_drv->compress_new = snd_soc_new_compress;
+	}
+
+	return 0;
+}
+
 static int q6asm_dai_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -549,6 +917,8 @@ static int q6asm_dai_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, pdata);
 
+	of_q6asm_parse_dai_data(dev, pdata);
+
 	return devm_snd_soc_register_component(dev, &q6asm_fe_dai_component,
 					q6asm_fe_dais,
 					ARRAY_SIZE(q6asm_fe_dais));
-- 
2.19.0.rc2

