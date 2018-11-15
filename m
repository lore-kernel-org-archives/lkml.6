Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC75C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7434421780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Mxt0YqtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7434421780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbeKPF4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:56:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57478 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPF4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qpqDqIXlNEWT/EX9s+N/TI2JmJl5ePdSbwmAOEVDUOQ=; b=Mxt0YqtQIO9O
        soCU6feMRArR3Rj8O0aR1riyzGqOrmSr6kBcUXsq1svhwPv1eltLmexhXdMU2he12UDKaG5Yr+Hyw
        qoRyqoql6KbVJ//47ZuxgkuGlU6A7tgvfw5sUUEyTTaEIiSYI/X4hQgte8t4/svixOTohoRcqszwj
        XZ2ho=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNNbH-0006FI-Kd; Thu, 15 Nov 2018 19:46:52 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id CFE8D440078; Thu, 15 Nov 2018 19:46:45 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Ravulapati Vishnu vardhan Rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC, AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: amd: Fixed build errors" to the asoc tree
In-Reply-To:  <1542298434-17287-1-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <20181115194645.CFE8D440078@finisterre.ee.mobilebroadband>
Date:   Thu, 15 Nov 2018 19:46:45 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: Fixed build errors

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

From 1c4fb2457e541c614792e6d9986bc95461e67e41 Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Thu, 15 Nov 2018 21:43:49 +0530
Subject: [PATCH] ASoC: amd: Fixed build errors

Fixed build errors.
- Implicit declaration of pci_enable_msi() & pci_disable_msi()
api's for openrisc architecture.
- type defaults to 'int' in declaration of 'module_pci_driver'

Enabled build for x86 architecture.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 5f3b56087ba1..33ebec990c2f 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -22,5 +22,6 @@ config SND_SOC_AMD_CZ_RT5645_MACH
 
 config SND_SOC_AMD_ACP3x
 	tristate "AMD Audio Coprocessor-v3.x support"
+	depends on X86 && PCI
 	help
 	 This option enables ACP v3.x I2S support on AMD platform
-- 
2.19.1

