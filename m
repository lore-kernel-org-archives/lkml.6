Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZoX8rJY2kX+F7VNykEmCCh20KkPvKt2ahVHvJBNBqcvJFYQQj3v42s33WblpFEAHkXA/ZLJ
ARC-Seal: i=1; a=rsa-sha256; t=1526917701; cv=none;
        d=google.com; s=arc-20160816;
        b=eXmRVvpNs1nYOtYw4w9XfXBf2tTU9Mt+hIbTqwQEXmQdgXP4QsJml6HR+tSW6YWqQB
         JmVftx2AEtTqaremWZZBt5PRohQwhH4gGRh94HhftciWXcqtxxvzmk8rr+BWibuFA7Wr
         B2TEeptxmeb0Lqtib33fM6G6a4C3SGtb3DVztmsKN8J1VX8Q7+pmTF9Ws9uSZ4qv0s5v
         xYMYRskSB6VDS60HU4JlzkdeP+EA/5OcxBiu8ES1jLafoWqx7gkxtQWdtw6c0wkmRBK9
         2rqGVsHI/xcD0SAwMod3wXupQSBYopxSeWyq6aZ6xtHhBkbt1Erv5IqDYvQLxjrjnbwK
         xUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=XQWxGY7YGgxgA5to88sPaFU9HXoLvW8z18E2zeBt2KE=;
        b=snNbHz7dU5qAt2JqnAi0VRKfGpDxSuouzGt+tcm78alPrvXas5LE0ZOq29NxxJCmTW
         +Sx1qJc7AOEPwnMwYQvOu2sJPiw5Qv5DpRPhJRQZ2Vq4OZ6aA211xbkT0XTH4ogxcz5h
         4q66seFZ6R4uTpyy/fgrXNVWVWoyf83YjDo82RtuCKcCwlJA8WL9M4OGy29hegKhBM7W
         RLWMIRNJK6fyNIlU41IJNBNsBCWNv64mCOTPb+1rLWcub9GRpCQbFwvazqUMkbeRSoio
         6M36JgMoG+q3bRQ7YKHXdItVLEgE/iYEvEwSmPDJt759VuvZyeUQohuAiY8tAAN4CiA3
         XOFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=U7/CeUXo;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=U7/CeUXo;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Mukunda@sirena.org.uk, Vijendar <Vijendar.Mukunda@amd.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Mark Brown <broonie@kernel.org>, , "moderated list:SOUND - SOC, LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Daniel Kurtz <djkurtz@chromium.org>, Jason Clinton <jclinton@chromium.org>, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: amd: dma driver changes for bt i2s instance" to the asoc tree
In-Reply-To: <1525754888-14124-10-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <E1fKn2i-0007F0-G0@debutante>
Date: Mon, 21 May 2018 16:48:12 +0100
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601089256338552789?=
X-GMAIL-MSGID: =?utf-8?q?1601089256338552789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: amd: dma driver changes for bt i2s instance

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

>From ccfbb4f5723736bb6f548a319ab97e4c4f8ff2b4 Mon Sep 17 00:00:00 2001
From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Date: Tue, 8 May 2018 10:17:53 +0530
Subject: [PATCH] ASoC: amd: dma driver changes for bt i2s instance

With in ACP, There are three I2S controllers can be
configured/enabled ( I2S SP, I2S MICSP, I2S BT).
Default enabled I2S controller instance is I2S SP.
This patch provides required changes to support I2S BT
controller Instance.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c |  24 +++
 sound/soc/amd/acp-pcm-dma.c          | 256 +++++++++++++++++++++------
 sound/soc/amd/acp.h                  |  40 +++++
 3 files changed, 263 insertions(+), 57 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 133139dbcb06..ccddc6650b9c 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -36,6 +36,7 @@
 #include <linux/input.h>
 #include <linux/acpi.h>
 
+#include "acp.h"
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
 
@@ -44,6 +45,7 @@
 
 static struct snd_soc_jack cz_jack;
 static struct clk *da7219_dai_clk;
+extern int bt_uart_enable;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -132,6 +134,9 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 static int cz_da7219_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
 	/*
 	 * On this platform for PCM device we support stereo
@@ -143,6 +148,7 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
+	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -153,6 +159,11 @@ static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
 
 static int cz_max_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->i2s_instance = I2S_SP_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -163,6 +174,11 @@ static void cz_max_shutdown(struct snd_pcm_substream *substream)
 
 static int cz_dmic_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->i2s_instance = I2S_SP_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -266,10 +282,16 @@ static int cz_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct snd_soc_card *card;
+	struct acp_platform_info *machine;
 
+	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp_platform_info),
+			       GFP_KERNEL);
+	if (!machine)
+		return -ENOMEM;
 	card = &cz_card;
 	cz_card.dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
+	snd_soc_card_set_drvdata(card, machine);
 	ret = devm_snd_soc_register_card(&pdev->dev, &cz_card);
 	if (ret) {
 		dev_err(&pdev->dev,
@@ -277,6 +299,8 @@ static int cz_probe(struct platform_device *pdev)
 				cz_card.name, ret);
 		return ret;
 	}
+	bt_uart_enable = !device_property_read_bool(&pdev->dev,
+						    "bt-pad-enable");
 	return 0;
 }
 
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 1c44b26ad2db..ac32deaa9541 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -37,12 +37,14 @@
 #define MAX_BUFFER (PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define MIN_BUFFER MAX_BUFFER
 
-#define ST_PLAYBACK_MAX_PERIOD_SIZE 8192
+#define ST_PLAYBACK_MAX_PERIOD_SIZE 4096
 #define ST_CAPTURE_MAX_PERIOD_SIZE  ST_PLAYBACK_MAX_PERIOD_SIZE
 #define ST_MAX_BUFFER (ST_PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define ST_MIN_BUFFER ST_MAX_BUFFER
 
 #define DRV_NAME "acp_audio_dma"
+bool bt_uart_enable = true;
+EXPORT_SYMBOL(bt_uart_enable);
 
 static const struct snd_pcm_hardware acp_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
@@ -357,6 +359,9 @@ static void acp_dma_start(void __iomem *acp_mmio,
 	case ACP_TO_I2S_DMA_CH_NUM:
 	case ACP_TO_SYSRAM_CH_NUM:
 	case I2S_TO_ACP_DMA_CH_NUM:
+	case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
+	case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
+	case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 		break;
 	default:
@@ -519,6 +524,13 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 	val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
 	acp_reg_write(val, acp_mmio, mmACP_SOFT_RESET);
 
+	/* For BT instance change pins from UART to BT */
+	if (!bt_uart_enable) {
+		val = acp_reg_read(acp_mmio, mmACP_BT_UART_PAD_SEL);
+		val |= ACP_BT_UART_PAD_SELECT_MASK;
+		acp_reg_write(val, acp_mmio, mmACP_BT_UART_PAD_SEL);
+	}
+
 	/* initiailize Onion control DAGB register */
 	acp_reg_write(ACP_ONION_CNTL_DEFAULT, acp_mmio,
 		      mmACP_AXI2DAGB_ONION_CNTL);
@@ -637,6 +649,24 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
+	if ((intr_flag & BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_9) ==
+			PLAYBACK_START_DMA_DESCR_CH9)
+			dscr_idx = PLAYBACK_END_DMA_DESCR_CH8;
+		else
+			dscr_idx = PLAYBACK_START_DMA_DESCR_CH8;
+		config_acp_dma_channel(acp_mmio,
+				       SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
+				       dscr_idx, 1, 0);
+		acp_dma_start(acp_mmio, SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
+			      false);
+		snd_pcm_period_elapsed(irq_data->play_i2sbt_stream);
+		acp_reg_write((intr_flag &
+			      BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
 		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_15) ==
@@ -659,6 +689,31 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_11) ==
+			CAPTURE_START_DMA_DESCR_CH11)
+			dscr_idx = CAPTURE_END_DMA_DESCR_CH10;
+		else
+			dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
+		config_acp_dma_channel(acp_mmio,
+				       ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
+				       dscr_idx, 1, 0);
+		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
+			      false);
+		acp_reg_write((intr_flag &
+			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
+	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
+		acp_reg_write((intr_flag &
+			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
 	if (valid_irq)
 		return IRQ_HANDLED;
 	else
@@ -714,11 +769,11 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	 * This enablement is not required for another stream, if current
 	 * stream is not closed
 	 */
-	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream)
+	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream &&
+	    !intr_data->play_i2sbt_stream && !intr_data->capture_i2sbt_stream)
 		acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		intr_data->play_i2ssp_stream = substream;
 		/*
 		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
@@ -730,7 +785,6 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 							bank, true);
 		}
 	} else {
-		intr_data->capture_i2ssp_stream = substream;
 		if (intr_data->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(intr_data->acp_mmio,
@@ -754,6 +808,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
+	struct snd_soc_card *card = prtd->card;
+	struct acp_platform_info *pinfo = snd_soc_card_get_drvdata(card);
 
 	runtime = substream->runtime;
 	rtd = runtime->private_data;
@@ -761,52 +817,109 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (WARN_ON(!rtd))
 		return -EINVAL;
 
+	rtd->i2s_instance = pinfo->i2s_instance;
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
 				   mmACP_I2S_16BIT_RESOLUTION_EN);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
-		else
-			val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			switch (rtd->i2s_instance) {
+			case I2S_BT_INSTANCE:
+				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
+			}
+		} else {
+			switch (rtd->i2s_instance) {
+			case I2S_BT_INSTANCE:
+				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+			}
+		}
 		acp_reg_write(val, adata->acp_mmio,
 			      mmACP_I2S_16BIT_RESOLUTION_EN);
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		switch (adata->asic_type) {
-		case CHIP_STONEY:
-			rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
+		switch (rtd->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			rtd->pte_offset = ACP_ST_BT_PLAYBACK_PTE_OFFSET;
+			rtd->ch1 = SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM;
+			rtd->ch2 = ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM;
+			rtd->sram_bank = ACP_SRAM_BANK_3_ADDRESS;
+			rtd->destination = TO_BLUETOOTH;
+			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH8;
+			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH9;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW;
+			adata->play_i2sbt_stream = substream;
 			break;
+		case I2S_SP_INSTANCE:
 		default:
-			rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+			switch (adata->asic_type) {
+			case CHIP_STONEY:
+				rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
+				break;
+			default:
+				rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+			}
+			rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
+			rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+			rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
+			rtd->destination = TO_ACP_I2S_1;
+			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
+			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
+			adata->play_i2ssp_stream = substream;
 		}
-		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
-		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
-		rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
-		rtd->destination = TO_ACP_I2S_1;
-		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
-		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
-		rtd->byte_cnt_high_reg_offset =
-				mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
-		rtd->byte_cnt_low_reg_offset = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
 	} else {
-		switch (adata->asic_type) {
-		case CHIP_STONEY:
-			rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
-			rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
+		switch (rtd->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			rtd->pte_offset = ACP_ST_BT_CAPTURE_PTE_OFFSET;
+			rtd->ch1 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
+			rtd->ch2 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
+			rtd->sram_bank = ACP_SRAM_BANK_4_ADDRESS;
+			rtd->destination = FROM_BLUETOOTH;
+			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
+			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
+			adata->capture_i2sbt_stream = substream;
 			break;
+		case I2S_SP_INSTANCE:
 		default:
 			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
-			rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
+			rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
+			rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
+			switch (adata->asic_type) {
+			case CHIP_STONEY:
+				rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
+				rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
+				break;
+			default:
+				rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
+				rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
+			}
+			rtd->destination = FROM_ACP_I2S_1;
+			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
+			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+			adata->capture_i2ssp_stream = substream;
 		}
-		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
-		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
-		rtd->destination = FROM_ACP_I2S_1;
-		rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
-		rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
-		rtd->byte_cnt_high_reg_offset =
-				mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
-		rtd->byte_cnt_low_reg_offset = mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
 	}
 
 	size = params_buffer_bytes(params);
@@ -999,24 +1112,39 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		adata->play_i2ssp_stream = NULL;
-		/*
-		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
-		 * won't be turned off. The default state for SRAM banks is ON.
-		 * Setting SRAM bank state code skipped for STONEY platform.
-		 * added condition checks for Carrizo platform only
-		 */
-		if (adata->asic_type != CHIP_STONEY) {
-			for (bank = 1; bank <= 4; bank++)
-				acp_set_sram_bank_state(adata->acp_mmio, bank,
-							false);
+		switch (rtd->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			adata->play_i2sbt_stream = NULL;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			adata->play_i2ssp_stream = NULL;
+			/*
+			 * For Stoney, Memory gating is disabled,i.e SRAM Banks
+			 * won't be turned off. The default state for SRAM banks
+			 * is ON.Setting SRAM bank state code skipped for STONEY
+			 * platform. Added condition checks for Carrizo platform
+			 * only.
+			 */
+			if (adata->asic_type != CHIP_STONEY) {
+				for (bank = 1; bank <= 4; bank++)
+					acp_set_sram_bank_state(adata->acp_mmio,
+								bank, false);
+			}
 		}
 	} else  {
-		adata->capture_i2ssp_stream = NULL;
-		if (adata->asic_type != CHIP_STONEY) {
-			for (bank = 5; bank <= 8; bank++)
-				acp_set_sram_bank_state(adata->acp_mmio, bank,
-							false);
+		switch (rtd->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			adata->capture_i2sbt_stream = NULL;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			adata->capture_i2ssp_stream = NULL;
+			if (adata->asic_type != CHIP_STONEY) {
+				for (bank = 5; bank <= 8; bank++)
+					acp_set_sram_bank_state(adata->acp_mmio,
+								bank, false);
+			}
 		}
 	}
 
@@ -1024,7 +1152,8 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	 * Disable ACP irq, when the current stream is being closed and
 	 * another stream is also not active.
 	 */
-	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
+	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream &&
+	    !adata->play_i2sbt_stream && !adata->capture_i2sbt_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	kfree(rtd);
 	return 0;
@@ -1078,6 +1207,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 
 	audio_drv_data->play_i2ssp_stream = NULL;
 	audio_drv_data->capture_i2ssp_stream = NULL;
+	audio_drv_data->play_i2sbt_stream = NULL;
+	audio_drv_data->capture_i2sbt_stream = NULL;
 
 	audio_drv_data->asic_type =  *pdata;
 
@@ -1134,6 +1265,7 @@ static int acp_pcm_resume(struct device *dev)
 {
 	u16 bank;
 	int status;
+	struct audio_substream_data *rtd;
 	struct audio_drv_data *adata = dev_get_drvdata(dev);
 
 	status = acp_init(adata->acp_mmio, adata->asic_type);
@@ -1153,9 +1285,8 @@ static int acp_pcm_resume(struct device *dev)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
 							true);
 		}
-		config_acp_dma(adata->acp_mmio,
-			       adata->play_i2ssp_stream->runtime->private_data,
-			       adata->asic_type);
+		rtd = adata->play_i2ssp_stream->runtime->private_data;
+		config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
 	}
 	if (adata->capture_i2ssp_stream &&
 	    adata->capture_i2ssp_stream->runtime) {
@@ -1164,9 +1295,20 @@ static int acp_pcm_resume(struct device *dev)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
 							true);
 		}
-		config_acp_dma(adata->acp_mmio,
-			       adata->capture_i2ssp_stream->runtime->private_data,
-			       adata->asic_type);
+		rtd =  adata->capture_i2ssp_stream->runtime->private_data;
+		config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
+	}
+	if (adata->asic_type != CHIP_CARRIZO) {
+		if (adata->play_i2sbt_stream &&
+		    adata->play_i2sbt_stream->runtime) {
+			rtd = adata->play_i2sbt_stream->runtime->private_data;
+			config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
+		}
+		if (adata->capture_i2sbt_stream &&
+		    adata->capture_i2sbt_stream->runtime) {
+			rtd = adata->capture_i2sbt_stream->runtime->private_data;
+			config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
+		}
 	}
 	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	return 0;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 62695ede997d..9cd3e96c84d4 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -13,6 +13,8 @@
 /* Playback and Capture Offset for Stoney */
 #define ACP_ST_PLAYBACK_PTE_OFFSET	0x04
 #define ACP_ST_CAPTURE_PTE_OFFSET	0x00
+#define ACP_ST_BT_PLAYBACK_PTE_OFFSET	0x08
+#define ACP_ST_BT_CAPTURE_PTE_OFFSET	0x0c
 
 #define ACP_GARLIC_CNTL_DEFAULT			0x00000FB4
 #define ACP_ONION_CNTL_DEFAULT			0x00000FB4
@@ -46,8 +48,13 @@
 
 #define TO_ACP_I2S_1   0x2
 #define TO_ACP_I2S_2   0x4
+#define TO_BLUETOOTH   0x3
 #define FROM_ACP_I2S_1 0xa
 #define FROM_ACP_I2S_2 0xb
+#define FROM_BLUETOOTH 0xb
+
+#define I2S_SP_INSTANCE                 0x01
+#define I2S_BT_INSTANCE                 0x02
 
 #define ACP_TILE_ON_MASK                0x03
 #define ACP_TILE_OFF_MASK               0x02
@@ -68,6 +75,14 @@
 #define ACP_TO_SYSRAM_CH_NUM 14
 #define I2S_TO_ACP_DMA_CH_NUM 15
 
+/* Playback DMA Channels for I2S BT instance */
+#define SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM  8
+#define ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM 9
+
+/* Capture DMA Channels for I2S BT Instance */
+#define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 10
+#define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 11
+
 #define NUM_DSCRS_PER_CHANNEL 2
 
 #define PLAYBACK_START_DMA_DESCR_CH12 0
@@ -80,9 +95,23 @@
 #define CAPTURE_START_DMA_DESCR_CH15 6
 #define CAPTURE_END_DMA_DESCR_CH15 7
 
+/* I2S BT Instance DMA Descriptors */
+#define PLAYBACK_START_DMA_DESCR_CH8 8
+#define PLAYBACK_END_DMA_DESCR_CH8 9
+#define PLAYBACK_START_DMA_DESCR_CH9 10
+#define PLAYBACK_END_DMA_DESCR_CH9 11
+
+#define CAPTURE_START_DMA_DESCR_CH10 12
+#define CAPTURE_END_DMA_DESCR_CH10 13
+#define CAPTURE_START_DMA_DESCR_CH11 14
+#define CAPTURE_END_DMA_DESCR_CH11 15
+
 #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
 #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
 #define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
+#define ACP_I2S_BT_16BIT_RESOLUTION_EN	0x04
+#define ACP_BT_UART_PAD_SELECT_MASK	0x1
+
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
 	ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
@@ -95,6 +124,7 @@ struct audio_substream_data {
 	struct page *pg;
 	unsigned int order;
 	u16 num_of_pages;
+	u16 i2s_instance;
 	u16 direction;
 	u16 ch1;
 	u16 ch2;
@@ -113,10 +143,20 @@ struct audio_substream_data {
 struct audio_drv_data {
 	struct snd_pcm_substream *play_i2ssp_stream;
 	struct snd_pcm_substream *capture_i2ssp_stream;
+	struct snd_pcm_substream *play_i2sbt_stream;
+	struct snd_pcm_substream *capture_i2sbt_stream;
 	void __iomem *acp_mmio;
 	u32 asic_type;
 };
 
+/*
+ * this structure used for platform data transfer between machine driver
+ * and dma driver
+ */
+struct acp_platform_info {
+	u16 i2s_instance;
+};
+
 union acp_dma_count {
 	struct {
 	u32 low;
-- 
2.17.0
