Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D51C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBE12245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="lhzdr3yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBE12245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbeKNFqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:46:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52082 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbeKNFqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qz1avzVV8a4qKlM6T0RRIzDzSzVhvGLFh4sJox5IyhU=; b=lhzdr3yqDBmY
        lBUE7BuLw0lqmxgBTF3ISZx7qy5UrscgUQYBiIkv5D3uX3zHkKSSNgYz57HgcWHTpNKiqptxWRXiK
        pFMtfdXsgOQBSgAdTpmyPU0+KFuthzOSbdrRUitKE1FxgKF9FxLUJXkUPPxYE+3SxU42hd6d9amto
        7A5kA=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMedo-0002WN-D5; Tue, 13 Nov 2018 19:46:28 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AA2AD440078; Tue, 13 Nov 2018 19:46:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Ravulapati Vishnu vardhan Rao 
        <vishnuvardhanrao.ravulapati@amd.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER /, DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        Vishnuvardhanrao.Ravulapati@amd.com,
        Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: amd: create ACP3x PCM platform device" to the asoc tree
In-Reply-To:  <1542000903-19020-4-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <20181113194622.AA2AD440078@finisterre.ee.mobilebroadband>
Date:   Tue, 13 Nov 2018 19:46:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: create ACP3x PCM platform device

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

From 7894a7e7ea3de6c1fd5b2b43f3a73106c94ef584 Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Mon, 12 Nov 2018 11:04:54 +0530
Subject: [PATCH] ASoC: amd: create ACP3x PCM platform device

ACP 3x IP has I2S controller device as one of IP blocks.
Create a platform device for it, so that the PCM platform driver
can be bound to this device. Pass PCI resources like MMIO, irq
to the platform device.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <vishnuvardhanrao.ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x.h     |  4 ++
 sound/soc/amd/raven/pci-acp3x.c | 70 ++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index e9b4df0c6726..83b1ed8f6060 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -1,6 +1,10 @@
 #include "chip_offset_byte.h"
 
 #define ACP3x_PHY_BASE_ADDRESS 0x1240000
+#define	ACP3x_I2S_MODE	0
+#define	ACP3x_REG_START	0x1240000
+#define	ACP3x_REG_END	0x1250200
+#define I2S_MODE	0x04
 
 static inline u32 rv_readl(void __iomem *base_addr)
 {
diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 27588ed066c9..0700162b0ed1 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -16,19 +16,26 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
 
 #include "acp3x.h"
 
 struct acp3x_dev_data {
 	void __iomem *acp3x_base;
+	bool acp3x_audio_mode;
+	struct resource *res;
+	struct platform_device *pdev;
 };
 
 static int snd_acp3x_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
 	int ret;
-	u32 addr;
+	u32 addr, val;
 	struct acp3x_dev_data *adata;
+	struct platform_device_info pdevinfo;
+	unsigned int irqflags;
 
 	if (pci_enable_device(pci)) {
 		dev_err(&pci->dev, "pci_enable_device failed\n");
@@ -48,6 +55,15 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		goto release_regions;
 	}
 
+	/* check for msi interrupt support */
+	ret = pci_enable_msi(pci);
+	if (ret)
+		/* msi is not enabled */
+		irqflags = IRQF_SHARED;
+	else
+		/* msi is enabled */
+		irqflags = 0;
+
 	addr = pci_resource_start(pci, 0);
 	adata->acp3x_base = ioremap(addr, pci_resource_len(pci, 0));
 	if (!adata->acp3x_base) {
@@ -56,8 +72,57 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 	}
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
+
+	val = rv_readl(adata->acp3x_base + mmACP_I2S_PIN_CONFIG);
+	switch (val) {
+	case I2S_MODE:
+		adata->res = devm_kzalloc(&pci->dev,
+					  sizeof(struct resource) * 2,
+					  GFP_KERNEL);
+		if (!adata->res) {
+			ret = -ENOMEM;
+			goto unmap_mmio;
+		}
+
+		adata->res[0].name = "acp3x_i2s_iomem";
+		adata->res[0].flags = IORESOURCE_MEM;
+		adata->res[0].start = addr;
+		adata->res[0].end = addr + (ACP3x_REG_END - ACP3x_REG_START);
+
+		adata->res[1].name = "acp3x_i2s_irq";
+		adata->res[1].flags = IORESOURCE_IRQ;
+		adata->res[1].start = pci->irq;
+		adata->res[1].end = pci->irq;
+
+		adata->acp3x_audio_mode = ACP3x_I2S_MODE;
+
+		memset(&pdevinfo, 0, sizeof(pdevinfo));
+		pdevinfo.name = "acp3x_rv_i2s";
+		pdevinfo.id = 0;
+		pdevinfo.parent = &pci->dev;
+		pdevinfo.num_res = 2;
+		pdevinfo.res = adata->res;
+		pdevinfo.data = &irqflags;
+		pdevinfo.size_data = sizeof(irqflags);
+
+		adata->pdev = platform_device_register_full(&pdevinfo);
+		if (!adata->pdev) {
+			dev_err(&pci->dev, "cannot register %s device\n",
+				pdevinfo.name);
+			ret = -ENODEV;
+			goto unmap_mmio;
+		}
+		break;
+	default:
+		dev_err(&pci->dev, "Inavlid ACP audio mode : %d\n", val);
+		ret = -ENODEV;
+		goto unmap_mmio;
+	}
 	return 0;
 
+unmap_mmio:
+	pci_disable_msi(pci);
+	iounmap(adata->acp3x_base);
 release_regions:
 	pci_release_regions(pci);
 disable_pci:
@@ -70,7 +135,10 @@ static void snd_acp3x_remove(struct pci_dev *pci)
 {
 	struct acp3x_dev_data *adata = pci_get_drvdata(pci);
 
+	platform_device_unregister(adata->pdev);
 	iounmap(adata->acp3x_base);
+
+	pci_disable_msi(pci);
 	pci_release_regions(pci);
 	pci_disable_device(pci);
 }
-- 
2.19.1

