Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF208C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2844223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cHBzpkqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2844223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeKNFpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:45:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50246 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0jVSRF95HLuUhW6rqnUg7KIbBdAthmY6+RoMpID5G1M=; b=cHBzpkqxT93W
        9sw2hTmOD22JBKS8B/JN5+MbPuIFybzeUtQrHpIDyErdXFYJXF15w6glYF2YUh5FQLhhWCuWS6r1e
        0OwVlMLitoTzt93OmEzFc2usGHMxGDbtqPmq1FkR6cikAYXi1NC6R48ajpshv/nS9RuppqK2M032h
        jtjyM=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMecm-0002Uz-Os; Tue, 13 Nov 2018 19:45:25 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5AEE8440079; Tue, 13 Nov 2018 19:45:21 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Ravulapati Vishnu vardhan Rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vishnuvardhanrao.Ravulapati@amd.com,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: amd: enable acp3x drivers build" to the asoc tree
In-Reply-To:  <1542000903-19020-12-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <20181113194521.5AEE8440079@finisterre.ee.mobilebroadband>
Date:   Tue, 13 Nov 2018 19:45:21 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: enable acp3x drivers build

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

From 818ba93b0e9ed4a08cba575dd49c1391ef4b7776 Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Mon, 12 Nov 2018 11:05:02 +0530
Subject: [PATCH] ASoC: amd: enable acp3x drivers build

ACP3x drivers can be built by selecting necessary kernel config option.
The patch enables build support of the same.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/Kconfig        | 5 +++++
 sound/soc/amd/Makefile       | 1 +
 sound/soc/amd/raven/Makefile | 4 ++++
 3 files changed, 10 insertions(+)
 create mode 100644 sound/soc/amd/raven/Makefile

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 58c1dcb4d255..5f3b56087ba1 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -19,3 +19,8 @@ config SND_SOC_AMD_CZ_RT5645_MACH
 	depends on SND_SOC_AMD_ACP && I2C
 	help
 	 This option enables machine driver for rt5645.
+
+config SND_SOC_AMD_ACP3x
+	tristate "AMD Audio Coprocessor-v3.x support"
+	help
+	 This option enables ACP v3.x I2S support on AMD platform
diff --git a/sound/soc/amd/Makefile b/sound/soc/amd/Makefile
index 79b0622fa5d3..8e1c571c3161 100644
--- a/sound/soc/amd/Makefile
+++ b/sound/soc/amd/Makefile
@@ -5,3 +5,4 @@ snd-soc-acp-rt5645-mach-objs := acp-rt5645.o
 obj-$(CONFIG_SND_SOC_AMD_ACP) += acp_audio_dma.o
 obj-$(CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH) += snd-soc-acp-da7219mx98357-mach.o
 obj-$(CONFIG_SND_SOC_AMD_CZ_RT5645_MACH) += snd-soc-acp-rt5645-mach.o
+obj-$(CONFIG_SND_SOC_AMD_ACP3x) += raven/
diff --git a/sound/soc/amd/raven/Makefile b/sound/soc/amd/raven/Makefile
new file mode 100644
index 000000000000..8c03e6fccf6a
--- /dev/null
+++ b/sound/soc/amd/raven/Makefile
@@ -0,0 +1,4 @@
+snd-pci-acp3x-objs	:= pci-acp3x.o
+snd-acp3x-pcm-dma-objs	:= acp3x-pcm-dma.o
+obj-$(CONFIG_SND_SOC_AMD_ACP3x)	 += snd-pci-acp3x.o
+obj-$(CONFIG_SND_SOC_AMD_ACP3x)	 += snd-acp3x-pcm-dma.o
-- 
2.19.1

