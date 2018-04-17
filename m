Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AIpwx49lLPqNPm3ZmY943SaXN9E7szYClbru+NlNtw0i111t8A27wJNdelJx7XxMfqfHtjJJwSHz
ARC-Seal: i=1; a=rsa-sha256; t=1523984980; cv=none;
        d=google.com; s=arc-20160816;
        b=GQBYe5Ie73zG1KpfL46l4wQQ2NsXOKewyrZlHd7/Dx1AcNeRHKjW6FHG9t9e01KQRc
         /01llm+TSRsqijvj0mZbxQZnRmBTYwbuFcgBK8282N9JzJNamth7B2NPX+MN5gcxdlwW
         q8+DfbwFjSUZrMS0AzUBmul4oU0FsgXuEsVQ5gQT4RaUoL4No2Nu5l1ii38/5JAKNdU8
         Mx3sp3OZTJC9L0OhMu8sahMBZznpV6PJo+aQi8YjG9u896xA+lNafFPYTTeSQETORroT
         x/6MrmY6tOSPoKH6mORsv7bLX6JFvVw3pTvfVEXxgN39ipjxWS0zD7vMAjfPqjEACp63
         W/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=QLz8w1MMxB08hgidcbuyJCLbu8RvwUeVdHIPf8jCpHw=;
        b=VlvEAXTv66VoslXF1Ajrgp6rVJjXDuZEMumuefsTL+lDr0t6PLfhIfH6D8mmSMVnmA
         mwBgIR7IZuc5AGsWRKW+AS94O7pqXcIOUfJTmwogvG0gCjexefwAc5QPkuuRwLAzJkjq
         nzijK0AmAuZ1DussmY34jDGjqEyMCU47FXXe3mITJM+Jo/ga86nvKAWGzL2GnpXdKOeQ
         HHxDSI8SD4N2J2PCwyODuws6fCSZH9WbGuI6L2OlvbLI7AOnQRKS70nINpSOvTLvKEu4
         RfAmPmpdEXmUV7LNlmMzSTi/8ngEec+2aEhtuGIbutCJnjRnEs/PIhEc34zqTmUo9/ys
         dlEg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=sfO8WFMc;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=sfO8WFMc;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
From: Mark Brown <broonie@kernel.org>
To: Mukunda@sirena.org.uk, Vijendar <Vijendar.Mukunda@amd.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Mark Brown <broonie@kernel.org>, , "moderated list:SOUND - SOC LAYER / DYNAMIC, AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Jason Clinton <jclinton@chromium.org>, Mark Brown <broonie@kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: amd: fixed checkpatch pl warnings" to the asoc tree
In-Reply-To: <1523941201-15665-3-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <E1f8U6m-0001gW-Pf@debutante>
Date: Tue, 17 Apr 2018 18:09:32 +0100
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598014074889832395?=
X-GMAIL-MSGID: =?utf-8?q?1598014074889832395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: amd: fixed checkpatch pl warnings

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

>From 13838c11c31e764d8143fdfcccea47691afd5ff2 Mon Sep 17 00:00:00 2001
From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Date: Tue, 17 Apr 2018 10:29:52 +0530
Subject: [PATCH] ASoC: amd: fixed checkpatch pl warnings

fixed checkpatch pl warnings.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 259 ++++++++++++++++++++----------------
 sound/soc/amd/acp.h         |  22 +--
 2 files changed, 153 insertions(+), 128 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 540088d317f2..5ffe2efc6363 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -130,7 +130,8 @@ static void acp_reg_write(u32 val, void __iomem *acp_mmio, u32 reg)
 	writel(val, acp_mmio + (reg * 4));
 }
 
-/* Configure a given dma channel parameters - enable/disable,
+/*
+ * Configure a given dma channel parameters - enable/disable,
  * number of descriptors, priority
  */
 static void config_acp_dma_channel(void __iomem *acp_mmio, u8 ch_num,
@@ -149,11 +150,12 @@ static void config_acp_dma_channel(void __iomem *acp_mmio, u8 ch_num,
 			& dscr_strt_idx),
 			acp_mmio, mmACP_DMA_DSCR_STRT_IDX_0 + ch_num);
 
-	/* program a DMA channel with the number of descriptors to be
+	/*
+	 * program a DMA channel with the number of descriptors to be
 	 * processed in the transfer
-	*/
+	 */
 	acp_reg_write(ACP_DMA_DSCR_CNT_0__DMAChDscrCnt_MASK & num_dscrs,
-		acp_mmio, mmACP_DMA_DSCR_CNT_0 + ch_num);
+		      acp_mmio, mmACP_DMA_DSCR_CNT_0 + ch_num);
 
 	/* set DMA channel priority */
 	acp_reg_write(priority_level, acp_mmio, mmACP_DMA_PRIO_0 + ch_num);
@@ -180,13 +182,15 @@ static void config_dma_descriptor_in_sram(void __iomem *acp_mmio,
 	acp_reg_write(descr_info->xfer_val, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
 }
 
-/* Initialize the DMA descriptor information for transfer between
+/*
+ * Initialize the DMA descriptor information for transfer between
  * system memory <-> ACP SRAM
  */
 static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
-					u32 size, int direction, u32 pte_offset,
-					u16 ch, u32 sram_bank,
-					u16 dma_dscr_idx, u32 asic_type)
+					   u32 size, int direction,
+					   u32 pte_offset, u16 ch,
+					   u32 sram_bank, u16 dma_dscr_idx,
+					   u32 asic_type)
 {
 	u16 i;
 	acp_dma_dscr_transfer_t dmadscr[NUM_DSCRS_PER_CHANNEL];
@@ -195,58 +199,58 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
 		dmadscr[i].xfer_val = 0;
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
 			dma_dscr_idx = dma_dscr_idx + i;
-			dmadscr[i].dest = sram_bank + (i * (size/2));
+			dmadscr[i].dest = sram_bank + (i * (size / 2));
 			dmadscr[i].src = ACP_INTERNAL_APERTURE_WINDOW_0_ADDRESS
-				+ (pte_offset * SZ_4K) + (i * (size/2));
+				+ (pte_offset * SZ_4K) + (i * (size / 2));
 			switch (asic_type) {
 			case CHIP_STONEY:
 				dmadscr[i].xfer_val |=
-				(ACP_DMA_ATTRIBUTES_DAGB_GARLIC_TO_SHAREDMEM  << 16) |
+				(ACP_DMA_ATTR_DAGB_GARLIC_TO_SHAREDMEM  << 16) |
 				(size / 2);
 				break;
 			default:
 				dmadscr[i].xfer_val |=
-				(ACP_DMA_ATTRIBUTES_DAGB_ONION_TO_SHAREDMEM  << 16) |
+				(ACP_DMA_ATTR_DAGB_ONION_TO_SHAREDMEM  << 16) |
 				(size / 2);
 			}
 		} else {
 			dma_dscr_idx = dma_dscr_idx + i;
-			dmadscr[i].src = sram_bank + (i * (size/2));
+			dmadscr[i].src = sram_bank + (i * (size / 2));
 			dmadscr[i].dest =
 			ACP_INTERNAL_APERTURE_WINDOW_0_ADDRESS +
-			(pte_offset * SZ_4K) + (i * (size/2));
+			(pte_offset * SZ_4K) + (i * (size / 2));
 			switch (asic_type) {
 			case CHIP_STONEY:
 				dmadscr[i].xfer_val |=
 				BIT(22) |
-				(ACP_DMA_ATTRIBUTES_SHARED_MEM_TO_DAGB_GARLIC << 16) |
+				(ACP_DMA_ATTR_SHARED_MEM_TO_DAGB_GARLIC << 16) |
 				(size / 2);
 				break;
 			default:
 				dmadscr[i].xfer_val |=
 				BIT(22) |
-				(ACP_DMA_ATTRIBUTES_SHAREDMEM_TO_DAGB_ONION << 16) |
+				(ACP_DMA_ATTR_SHAREDMEM_TO_DAGB_ONION << 16) |
 				(size / 2);
 			}
 		}
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
-						&dmadscr[i]);
+					      &dmadscr[i]);
 	}
 	config_acp_dma_channel(acp_mmio, ch,
-				dma_dscr_idx - 1,
-				NUM_DSCRS_PER_CHANNEL,
-				ACP_DMA_PRIORITY_LEVEL_NORMAL);
+			       dma_dscr_idx - 1,
+			       NUM_DSCRS_PER_CHANNEL,
+			       ACP_DMA_PRIORITY_LEVEL_NORMAL);
 }
 
-/* Initialize the DMA descriptor information for transfer between
+/*
+ * Initialize the DMA descriptor information for transfer between
  * ACP SRAM <-> I2S
  */
 static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
-						int direction, u32 sram_bank,
-						u16 destination, u16 ch,
-						u16 dma_dscr_idx, u32 asic_type)
+					   int direction, u32 sram_bank,
+					   u16 destination, u16 ch,
+					   u16 dma_dscr_idx, u32 asic_type)
 {
-
 	u16 i;
 	acp_dma_dscr_transfer_t dmadscr[NUM_DSCRS_PER_CHANNEL];
 
@@ -254,7 +258,7 @@ static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
 		dmadscr[i].xfer_val = 0;
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
 			dma_dscr_idx = dma_dscr_idx + i;
-			dmadscr[i].src = sram_bank  + (i * (size/2));
+			dmadscr[i].src = sram_bank  + (i * (size / 2));
 			/* dmadscr[i].dest is unused by hardware. */
 			dmadscr[i].dest = 0;
 			dmadscr[i].xfer_val |= BIT(22) | (destination << 16) |
@@ -269,12 +273,12 @@ static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
 				(destination << 16) | (size / 2);
 		}
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
-						&dmadscr[i]);
+					      &dmadscr[i]);
 	}
 	/* Configure the DMA channel with the above descriptore */
 	config_acp_dma_channel(acp_mmio, ch, dma_dscr_idx - 1,
-				NUM_DSCRS_PER_CHANNEL,
-				ACP_DMA_PRIORITY_LEVEL_NORMAL);
+			       NUM_DSCRS_PER_CHANNEL,
+			       ACP_DMA_PRIORITY_LEVEL_NORMAL);
 }
 
 /* Create page table entries in ACP SRAM for the allocated memory */
@@ -291,7 +295,7 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 	for (page_idx = 0; page_idx < (num_of_pages); page_idx++) {
 		/* Load the low address of page int ACP SRAM through SRBM */
 		acp_reg_write((offset + (page_idx * 8)),
-			acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
+			      acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
 		addr = page_to_phys(pg);
 
 		low = lower_32_bits(addr);
@@ -301,7 +305,7 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 
 		/* Load the High address of page int ACP SRAM through SRBM */
 		acp_reg_write((offset + (page_idx * 8) + 4),
-			acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
+			      acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
 
 		/* page enable in ACP */
 		high |= BIT(31);
@@ -313,8 +317,8 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 }
 
 static void config_acp_dma(void __iomem *acp_mmio,
-			struct audio_substream_data *audio_config,
-			u32 asic_type)
+			   struct audio_substream_data *audio_config,
+			   u32 asic_type)
 {
 	u32 pte_offset, sram_bank;
 	u16 ch1, ch2, destination, dma_dscr_idx;
@@ -341,7 +345,7 @@ static void config_acp_dma(void __iomem *acp_mmio,
 	}
 
 	acp_pte_config(acp_mmio, audio_config->pg, audio_config->num_of_pages,
-			pte_offset);
+		       pte_offset);
 	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
 	else
@@ -349,8 +353,8 @@ static void config_acp_dma(void __iomem *acp_mmio,
 
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, audio_config->size,
-				       audio_config->direction, pte_offset,
-					ch1, sram_bank, dma_dscr_idx, asic_type);
+				       audio_config->direction, pte_offset, ch1,
+				       sram_bank, dma_dscr_idx, asic_type);
 
 	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
@@ -358,14 +362,14 @@ static void config_acp_dma(void __iomem *acp_mmio,
 		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, audio_config->size,
-					audio_config->direction, sram_bank,
-					destination, ch2, dma_dscr_idx,
-					asic_type);
+				       audio_config->direction, sram_bank,
+				       destination, ch2, dma_dscr_idx,
+				       asic_type);
 }
 
 /* Start a given DMA channel transfer */
 static void acp_dma_start(void __iomem *acp_mmio,
-			 u16 ch_num, bool is_circular)
+			  u16 ch_num, bool is_circular)
 {
 	u32 dma_ctrl;
 
@@ -375,7 +379,8 @@ static void acp_dma_start(void __iomem *acp_mmio,
 	/* Invalidating the DAGB cache */
 	acp_reg_write(1, acp_mmio, mmACP_DAGB_ATU_CTRL);
 
-	/* configure the DMA channel and start the DMA transfer
+	/*
+	 * configure the DMA channel and start the DMA transfer
 	 * set dmachrun bit to start the transfer and enable the
 	 * interrupt on completion of the dma transfer
 	 */
@@ -410,9 +415,10 @@ static int acp_dma_stop(void __iomem *acp_mmio, u8 ch_num)
 
 	dma_ctrl = acp_reg_read(acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
 
-	/* clear the dma control register fields before writing zero
+	/*
+	 * clear the dma control register fields before writing zero
 	 * in reset bit
-	*/
+	 */
 	dma_ctrl &= ~ACP_DMA_CNTL_0__DMAChRun_MASK;
 	dma_ctrl &= ~ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 
@@ -420,9 +426,10 @@ static int acp_dma_stop(void __iomem *acp_mmio, u8 ch_num)
 	dma_ch_sts = acp_reg_read(acp_mmio, mmACP_DMA_CH_STS);
 
 	if (dma_ch_sts & BIT(ch_num)) {
-		/* set the reset bit for this channel to stop the dma
-		*  transfer
-		*/
+		/*
+		 * set the reset bit for this channel to stop the dma
+		 *  transfer
+		 */
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChRst_MASK;
 		acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
 	}
@@ -431,13 +438,14 @@ static int acp_dma_stop(void __iomem *acp_mmio, u8 ch_num)
 	while (true) {
 		dma_ch_sts = acp_reg_read(acp_mmio, mmACP_DMA_CH_STS);
 		if (!(dma_ch_sts & BIT(ch_num))) {
-			/* clear the reset flag after successfully stopping
-			* the dma transfer and break from the loop
-			*/
+			/*
+			 * clear the reset flag after successfully stopping
+			 * the dma transfer and break from the loop
+			 */
 			dma_ctrl &= ~ACP_DMA_CNTL_0__DMAChRst_MASK;
 
 			acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0
-								+ ch_num);
+				      + ch_num);
 			break;
 		}
 		if (--count == 0) {
@@ -450,7 +458,7 @@ static int acp_dma_stop(void __iomem *acp_mmio, u8 ch_num)
 }
 
 static void acp_set_sram_bank_state(void __iomem *acp_mmio, u16 bank,
-					bool power_on)
+				    bool power_on)
 {
 	u32 val, req_reg, sts_reg, sts_reg_mask;
 	u32 loops = 1000;
@@ -530,7 +538,7 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 
 	while (true) {
 		val = acp_reg_read(acp_mmio, mmACP_STATUS);
-		if (val & (u32) 0x1)
+		if (val & (u32)0x1)
 			break;
 		if (--count == 0) {
 			pr_err("Failed to reset ACP\n");
@@ -546,11 +554,11 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 
 	/* initiailize Onion control DAGB register */
 	acp_reg_write(ACP_ONION_CNTL_DEFAULT, acp_mmio,
-			mmACP_AXI2DAGB_ONION_CNTL);
+		      mmACP_AXI2DAGB_ONION_CNTL);
 
 	/* initiailize Garlic control DAGB registers */
 	acp_reg_write(ACP_GARLIC_CNTL_DEFAULT, acp_mmio,
-			mmACP_AXI2DAGB_GARLIC_CNTL);
+		      mmACP_AXI2DAGB_GARLIC_CNTL);
 
 	sram_pte_offset = ACP_DAGB_GRP_SRAM_BASE_ADDRESS |
 			ACP_DAGB_BASE_ADDR_GRP_1__AXI2DAGBSnoopSel_MASK |
@@ -558,17 +566,18 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 			ACP_DAGB_BASE_ADDR_GRP_1__AXI2DAGBGrpEnable_MASK;
 	acp_reg_write(sram_pte_offset,  acp_mmio, mmACP_DAGB_BASE_ADDR_GRP_1);
 	acp_reg_write(ACP_PAGE_SIZE_4K_ENABLE, acp_mmio,
-			mmACP_DAGB_PAGE_SIZE_GRP_1);
+		      mmACP_DAGB_PAGE_SIZE_GRP_1);
 
 	acp_reg_write(ACP_SRAM_BASE_ADDRESS, acp_mmio,
-			mmACP_DMA_DESC_BASE_ADDR);
+		      mmACP_DMA_DESC_BASE_ADDR);
 
 	/* Num of descriptiors in SRAM 0x4, means 256 descriptors;(64 * 4) */
 	acp_reg_write(0x4, acp_mmio, mmACP_DMA_DESC_MAX_NUM_DSCR);
 	acp_reg_write(ACP_EXTERNAL_INTR_CNTL__DMAIOCMask_MASK,
-		acp_mmio, mmACP_EXTERNAL_INTR_CNTL);
+		      acp_mmio, mmACP_EXTERNAL_INTR_CNTL);
 
-       /* When ACP_TILE_P1 is turned on, all SRAM banks get turned on.
+       /*
+	* When ACP_TILE_P1 is turned on, all SRAM banks get turned on.
 	* Now, turn off all of them. This can't be done in 'poweron' of
 	* ACP pm domain, as this requires ACP to be initialized.
 	* For Stoney, Memory gating is disabled,i.e SRAM Banks
@@ -606,7 +615,7 @@ static int acp_deinit(void __iomem *acp_mmio)
 		}
 		udelay(100);
 	}
-	/** Disable ACP clock */
+	/* Disable ACP clock */
 	val = acp_reg_read(acp_mmio, mmACP_CONTROL);
 	val &= ~ACP_CONTROL__ClkEn_MASK;
 	acp_reg_write(val, acp_mmio, mmACP_CONTROL);
@@ -615,7 +624,7 @@ static int acp_deinit(void __iomem *acp_mmio)
 
 	while (true) {
 		val = acp_reg_read(acp_mmio, mmACP_STATUS);
-		if (!(val & (u32) 0x1))
+		if (!(val & (u32)0x1))
 			break;
 		if (--count == 0) {
 			pr_err("Failed to reset ACP\n");
@@ -658,7 +667,7 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 		snd_pcm_period_elapsed(irq_data->play_i2ssp_stream);
 
 		acp_reg_write((intr_flag & BIT(ACP_TO_I2S_DMA_CH_NUM)) << 16,
-				acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
@@ -673,14 +682,14 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_CH_NUM, false);
 
 		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
-				acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
 	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
 		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
-				acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
 	if (valid_irq)
@@ -695,11 +704,12 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	int ret = 0;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
+								    DRV_NAME);
 	struct audio_drv_data *intr_data = dev_get_drvdata(component->dev);
 	struct audio_substream_data *adata =
 		kzalloc(sizeof(struct audio_substream_data), GFP_KERNEL);
-	if (adata == NULL)
+	if (!adata)
 		return -ENOMEM;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -731,17 +741,19 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	adata->acp_mmio = intr_data->acp_mmio;
 	runtime->private_data = adata;
 
-	/* Enable ACP irq, when neither playback or capture streams are
+	/*
+	 * Enable ACP irq, when neither playback or capture streams are
 	 * active by the time when a new stream is being opened.
 	 * This enablement is not required for another stream, if current
 	 * stream is not closed
-	*/
+	 */
 	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream)
 		acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		intr_data->play_i2ssp_stream = substream;
-		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
+		/*
+		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
 		 * Setting SRAM bank state code skipped for STONEY platform.
 		 */
@@ -772,7 +784,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime;
 	struct audio_substream_data *rtd;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
+								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
 	runtime = substream->runtime;
@@ -782,12 +795,14 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	if (adata->asic_type == CHIP_STONEY) {
-		val = acp_reg_read(adata->acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
+		val = acp_reg_read(adata->acp_mmio,
+				   mmACP_I2S_16BIT_RESOLUTION_EN);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
 		else
 			val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
-		acp_reg_write(val, adata->acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
+		acp_reg_write(val, adata->acp_mmio,
+			      mmACP_I2S_16BIT_RESOLUTION_EN);
 	}
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
@@ -797,7 +812,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
 	pg = virt_to_page(substream->dma_buffer.area);
 
-	if (pg != NULL) {
+	if (pg) {
 		acp_set_sram_bank_state(rtd->acp_mmio, 0, true);
 		/* Save for runtime private data */
 		rtd->pg = pg;
@@ -885,18 +900,18 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 		return -EINVAL;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		config_acp_dma_channel(rtd->acp_mmio, SYSRAM_TO_ACP_CH_NUM,
-					PLAYBACK_START_DMA_DESCR_CH12,
-					NUM_DSCRS_PER_CHANNEL, 0);
+				       PLAYBACK_START_DMA_DESCR_CH12,
+				       NUM_DSCRS_PER_CHANNEL, 0);
 		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_I2S_DMA_CH_NUM,
-					PLAYBACK_START_DMA_DESCR_CH13,
-					NUM_DSCRS_PER_CHANNEL, 0);
+				       PLAYBACK_START_DMA_DESCR_CH13,
+				       NUM_DSCRS_PER_CHANNEL, 0);
 	} else {
 		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_SYSRAM_CH_NUM,
-					CAPTURE_START_DMA_DESCR_CH14,
-					NUM_DSCRS_PER_CHANNEL, 0);
+				       CAPTURE_START_DMA_DESCR_CH14,
+				       NUM_DSCRS_PER_CHANNEL, 0);
 		config_acp_dma_channel(rtd->acp_mmio, I2S_TO_ACP_DMA_CH_NUM,
-					CAPTURE_START_DMA_DESCR_CH15,
-					NUM_DSCRS_PER_CHANNEL, 0);
+				       CAPTURE_START_DMA_DESCR_CH15,
+				       NUM_DSCRS_PER_CHANNEL, 0);
 	}
 	return 0;
 }
@@ -910,7 +925,8 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
 	struct audio_substream_data *rtd = runtime->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
+								    DRV_NAME);
 
 	if (!rtd)
 		return -EINVAL;
@@ -924,7 +940,7 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			if (rtd->i2ssp_renderbytescount == 0)
 				rtd->i2ssp_renderbytescount = bytescount;
 			acp_dma_start(rtd->acp_mmio,
-						SYSRAM_TO_ACP_CH_NUM, false);
+				      SYSRAM_TO_ACP_CH_NUM, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
 						BIT(SYSRAM_TO_ACP_CH_NUM)) {
 				if (!loops--) {
@@ -936,41 +952,41 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			}
 
 			acp_dma_start(rtd->acp_mmio,
-					ACP_TO_I2S_DMA_CH_NUM, true);
+				      ACP_TO_I2S_DMA_CH_NUM, true);
 
 		} else {
 			if (rtd->i2ssp_capturebytescount == 0)
 				rtd->i2ssp_capturebytescount = bytescount;
 			acp_dma_start(rtd->acp_mmio,
-					    I2S_TO_ACP_DMA_CH_NUM, true);
+				      I2S_TO_ACP_DMA_CH_NUM, true);
 		}
 		ret = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		/* Need to stop only circular DMA channels :
+		/*
+		 * Need to stop only circular DMA channels :
 		 * ACP_TO_I2S_DMA_CH_NUM / I2S_TO_ACP_DMA_CH_NUM. Non-circular
 		 * channels will stopped automatically after its transfer
 		 * completes : SYSRAM_TO_ACP_CH_NUM / ACP_TO_SYSRAM_CH_NUM
 		 */
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			ret = acp_dma_stop(rtd->acp_mmio,
-						SYSRAM_TO_ACP_CH_NUM);
+					   SYSRAM_TO_ACP_CH_NUM);
 			ret = acp_dma_stop(rtd->acp_mmio,
-					ACP_TO_I2S_DMA_CH_NUM);
+					   ACP_TO_I2S_DMA_CH_NUM);
 			rtd->i2ssp_renderbytescount = 0;
 		} else {
 			ret = acp_dma_stop(rtd->acp_mmio,
-					I2S_TO_ACP_DMA_CH_NUM);
+					   I2S_TO_ACP_DMA_CH_NUM);
 			ret = acp_dma_stop(rtd->acp_mmio,
-						ACP_TO_SYSRAM_CH_NUM);
+					   ACP_TO_SYSRAM_CH_NUM);
 			rtd->i2ssp_capturebytescount = 0;
 		}
 		break;
 	default:
 		ret = -EINVAL;
-
 	}
 	return ret;
 }
@@ -978,26 +994,27 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd,
+								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
 	switch (adata->asic_type) {
 	case CHIP_STONEY:
 		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
-							SNDRV_DMA_TYPE_DEV,
-							NULL, ST_MIN_BUFFER,
-							ST_MAX_BUFFER);
+							    SNDRV_DMA_TYPE_DEV,
+							    NULL, ST_MIN_BUFFER,
+							    ST_MAX_BUFFER);
 		break;
 	default:
 		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
-							SNDRV_DMA_TYPE_DEV,
-							NULL, MIN_BUFFER,
-							MAX_BUFFER);
+							    SNDRV_DMA_TYPE_DEV,
+							    NULL, MIN_BUFFER,
+							    MAX_BUFFER);
 		break;
 	}
 	if (ret < 0)
 		dev_err(component->dev,
-				"buffer preallocation failer error:%d\n", ret);
+			"buffer preallocation failer error:%d\n", ret);
 	return ret;
 }
 
@@ -1007,14 +1024,16 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
+								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
 	kfree(rtd);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		adata->play_i2ssp_stream = NULL;
-		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
+		/*
+		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
 		 * Setting SRAM bank state code skipped for STONEY platform.
 		 * added condition checks for Carrizo platform only
@@ -1022,20 +1041,21 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 		if (adata->asic_type != CHIP_STONEY) {
 			for (bank = 1; bank <= 4; bank++)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
-				false);
+							false);
 		}
 	} else  {
 		adata->capture_i2ssp_stream = NULL;
 		if (adata->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
-						     false);
+							false);
 		}
 	}
 
-	/* Disable ACP irq, when the current stream is being closed and
+	/*
+	 * Disable ACP irq, when the current stream is being closed and
 	 * another stream is also not active.
-	*/
+	 */
 	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
@@ -1054,7 +1074,7 @@ static const struct snd_pcm_ops acp_dma_ops = {
 	.prepare = acp_dma_prepare,
 };
 
-static struct snd_soc_component_driver acp_asoc_platform = {
+static const struct snd_soc_component_driver acp_asoc_platform = {
 	.name = DRV_NAME,
 	.ops = &acp_dma_ops,
 	.pcm_new = acp_dma_new,
@@ -1073,8 +1093,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 	}
 
 	audio_drv_data = devm_kzalloc(&pdev->dev, sizeof(struct audio_drv_data),
-					GFP_KERNEL);
-	if (audio_drv_data == NULL)
+				      GFP_KERNEL);
+	if (!audio_drv_data)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1082,7 +1102,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 	if (IS_ERR(audio_drv_data->acp_mmio))
 		return PTR_ERR(audio_drv_data->acp_mmio);
 
-	/* The following members gets populated in device 'open'
+	/*
+	 * The following members gets populated in device 'open'
 	 * function. Till then interrupts are disabled in 'acp_init'
 	 * and device doesn't generate any interrupts.
 	 */
@@ -1099,7 +1120,7 @@ static int acp_audio_probe(struct platform_device *pdev)
 	}
 
 	status = devm_request_irq(&pdev->dev, res->start, dma_irq_handler,
-					0, "ACP_IRQ", &pdev->dev);
+				  0, "ACP_IRQ", &pdev->dev);
 	if (status) {
 		dev_err(&pdev->dev, "ACP IRQ request failed\n");
 		return status;
@@ -1115,7 +1136,7 @@ static int acp_audio_probe(struct platform_device *pdev)
 	}
 
 	status = devm_snd_soc_register_component(&pdev->dev,
-						&acp_asoc_platform, NULL, 0);
+						 &acp_asoc_platform, NULL, 0);
 	if (status != 0) {
 		dev_err(&pdev->dev, "Fail to register ALSA platform device\n");
 		return status;
@@ -1154,28 +1175,30 @@ static int acp_pcm_resume(struct device *dev)
 	}
 
 	if (adata->play_i2ssp_stream && adata->play_i2ssp_stream->runtime) {
-		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
+		/*
+		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
 		 * Setting SRAM bank state code skipped for STONEY platform.
 		 */
 		if (adata->asic_type != CHIP_STONEY) {
 			for (bank = 1; bank <= 4; bank++)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
-						true);
+							true);
 		}
 		config_acp_dma(adata->acp_mmio,
-			adata->play_i2ssp_stream->runtime->private_data,
-			adata->asic_type);
+			       adata->play_i2ssp_stream->runtime->private_data,
+			       adata->asic_type);
 	}
-	if (adata->capture_i2ssp_stream && adata->capture_i2ssp_stream->runtime) {
+	if (adata->capture_i2ssp_stream &&
+	    adata->capture_i2ssp_stream->runtime) {
 		if (adata->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
-						true);
+							true);
 		}
 		config_acp_dma(adata->acp_mmio,
-			adata->capture_i2ssp_stream->runtime->private_data,
-			adata->asic_type);
+			       adata->capture_i2ssp_stream->runtime->private_data,
+			       adata->asic_type);
 	}
 	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	return 0;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index ba01510eb818..0e6089b4f8a0 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -115,23 +115,25 @@ enum {
 };
 
 enum {
-	ACP_DMA_ATTRIBUTES_SHAREDMEM_TO_DAGB_ONION = 0x0,
-	ACP_DMA_ATTRIBUTES_SHARED_MEM_TO_DAGB_GARLIC = 0x1,
-	ACP_DMA_ATTRIBUTES_DAGB_ONION_TO_SHAREDMEM = 0x8,
-	ACP_DMA_ATTRIBUTES_DAGB_GARLIC_TO_SHAREDMEM = 0x9,
-	ACP_DMA_ATTRIBUTES_FORCE_SIZE = 0xF
+	ACP_DMA_ATTR_SHAREDMEM_TO_DAGB_ONION = 0x0,
+	ACP_DMA_ATTR_SHARED_MEM_TO_DAGB_GARLIC = 0x1,
+	ACP_DMA_ATTR_DAGB_ONION_TO_SHAREDMEM = 0x8,
+	ACP_DMA_ATTR_DAGB_GARLIC_TO_SHAREDMEM = 0x9,
+	ACP_DMA_ATTR_FORCE_SIZE = 0xF
 };
 
 typedef struct acp_dma_dscr_transfer {
 	/* Specifies the source memory location for the DMA data transfer. */
 	u32 src;
-	/* Specifies the destination memory location to where the data will
+	/*
+	 * Specifies the destination memory location to where the data will
 	 * be transferred.
-	*/
+	 */
 	u32 dest;
-	/* Specifies the number of bytes need to be transferred
-	* from source to destination memory.Transfer direction & IOC enable
-	*/
+	/*
+	 * Specifies the number of bytes need to be transferred
+	 * from source to destination memory.Transfer direction & IOC enable
+	 */
 	u32 xfer_val;
 	/* Reserved for future use */
 	u32 reserved;
-- 
2.17.0
