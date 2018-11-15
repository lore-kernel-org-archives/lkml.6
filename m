Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3958121780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="kfgiTEUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3958121780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeKPFz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:55:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57184 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1aMumx3oobKlD6wAQIP6ejBGTMC2thu6bqlFSvtcdIw=; b=kfgiTEUZOUyM
        ScpYZs8Lk3WVv1b9ugocN8gRk7d9xQbeJ9+vM5SwNk17ewzmOFK+LAs5xpOIoifUERYKYQ02fiFPu
        2cdkkRAISchKyxw+6uVpUxtsiNs01mD40hjY187FBADq2Bj8ElJ1IlY9jfq85urSsaruMgxkwMn04
        GM4js=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNNb6-0006F2-MW; Thu, 15 Nov 2018 19:46:41 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 571D6440079; Thu, 15 Nov 2018 19:46:37 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: amd: Switch to SPDX identifier" to the asoc tree
In-Reply-To:  <1542298434-17287-2-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <20181115194637.571D6440079@finisterre.ee.mobilebroadband>
Date:   Thu, 15 Nov 2018 19:46:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: Switch to SPDX identifier

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

From d5a932e541f61a2be1cca7bab1e00d2bf7803e71 Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Thu, 15 Nov 2018 21:43:50 +0530
Subject: [PATCH] ASoC: amd: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license
compliance management.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/Makefile           |  2 ++
 sound/soc/amd/raven/acp3x-pcm-dma.c    | 19 +++++--------------
 sound/soc/amd/raven/acp3x.h            |  7 +++++++
 sound/soc/amd/raven/chip_offset_byte.h | 22 +++-------------------
 sound/soc/amd/raven/pci-acp3x.c        | 19 +++++--------------
 5 files changed, 22 insertions(+), 47 deletions(-)

diff --git a/sound/soc/amd/raven/Makefile b/sound/soc/amd/raven/Makefile
index 8c03e6fccf6a..108d1acf189b 100644
--- a/sound/soc/amd/raven/Makefile
+++ b/sound/soc/amd/raven/Makefile
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Raven Ridge platform Support
 snd-pci-acp3x-objs	:= pci-acp3x.o
 snd-acp3x-pcm-dma-objs	:= acp3x-pcm-dma.o
 obj-$(CONFIG_SND_SOC_AMD_ACP3x)	 += snd-pci-acp3x.o
diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index b16cdd187139..2aa34208ae92 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -1,17 +1,8 @@
-/*
- * AMD ALSA SoC PCM Driver
- *
- * Copyright 2016 Advanced Micro Devices, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// AMD ALSA SoC PCM Driver
+//
+//Copyright 2016 Advanced Micro Devices, Inc.
 
 #include <linux/platform_device.h>
 #include <linux/module.h>
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 95fef8570577..4f2cadd90a87 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -1,3 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AMD ALSA SoC PCM Driver
+ *
+ * Copyright 2016 Advanced Micro Devices, Inc.
+ */
+
 #include "chip_offset_byte.h"
 
 #define ACP3x_PHY_BASE_ADDRESS 0x1240000
diff --git a/sound/soc/amd/raven/chip_offset_byte.h b/sound/soc/amd/raven/chip_offset_byte.h
index fceb7bb40297..9c1fac58fb2a 100644
--- a/sound/soc/amd/raven/chip_offset_byte.h
+++ b/sound/soc/amd/raven/chip_offset_byte.h
@@ -1,24 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * ACP 3.0 Register documentation
+ * AMD ACP 3.0 Register Documentation
  *
- * Copyright (C) 2016 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included
- * in all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
- * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
- * IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright 2016 Advanced Micro Devices, Inc.
  */
 
 #ifndef _acp_ip_OFFSET_HEADER
diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 0700162b0ed1..ef805e71a98f 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -1,17 +1,8 @@
-/*
- * AMD ALSA SoC PCM Driver
- *
- * Copyright 2016 Advanced Micro Devices, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// AMD ACP PCI Driver
+//
+//Copyright 2016 Advanced Micro Devices, Inc.
 
 #include <linux/pci.h>
 #include <linux/module.h>
-- 
2.19.1

