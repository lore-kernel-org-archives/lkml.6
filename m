Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11513C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C342145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tGIy7drv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbeLQMVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:21:02 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47264 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732751AbeLQMU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:20:58 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBHCKOLr115708;
        Mon, 17 Dec 2018 06:20:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545049224;
        bh=/ppvfiutK/EPeF7dXtgYaII9QSpZX59wA/1lefq3ESw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tGIy7drvA6Fbt24uv+VBpbly4GKfYPxppevPxklNt4G3z9ZnFRu/ZgZ25T9KrtL7I
         zlXVrzTqFmdznEbXjJ2T1sSncFzbn6anCn8q0xpLeffLTb2vQvBOjNYrtt5X67OxRN
         KvK18VIxrBT+t8Yy6H+c2moik83Ph7H/PYYxIkAg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBHCKOcu100816
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 06:20:24 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 17
 Dec 2018 06:20:23 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 17 Dec 2018 06:20:23 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBHCJuXV023433;
        Mon, 17 Dec 2018 06:20:21 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <jarkko.nikula@bitmer.com>, <tony@atomide.com>, <nsekhar@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jsarha@ti.com>
Subject: [PATCH 9/9] ASoC: ti: Kconfig: Remove the deprecated options
Date:   Mon, 17 Dec 2018 14:21:42 +0200
Message-ID: <20181217122142.6652-10-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217122142.6652-1-peter.ujfalusi@ti.com>
References: <20181217122142.6652-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We no longer have these options used anywhere.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/Kconfig | 159 -------------------------------------------
 1 file changed, 159 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 698810c770f0..4bf3c15d4e51 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -46,14 +46,10 @@ config SND_SOC_OMAP_DMIC
 	  Say Y or M here if you want to have support for DMIC IP found in
 	  OMAP4 and OMAP5.
 
-config SND_OMAP_SOC_MCBSP
-	tristate
-
 config SND_SOC_OMAP_MCBSP
 	tristate "Multichannel Buffered Serial Port (McBSP) support"
 	depends on ARCH_OMAP || ARCH_OMAP1 || COMPILE_TEST
 	select SND_SOC_TI_SDMA_PCM
-	select SND_OMAP_SOC_MCBSP
 	help
 	  Say Y or M here if you want to have support for McBSP IP found in
 	  Texas Instruments OMAP1/2/3/4/5 SoCs.
@@ -209,160 +205,5 @@ config SND_SOC_DM365_VOICE_CODEC
 	  Say Y if you want to add support for SoC On-chip voice codec
 endchoice
 
-menu "Deprecated kconfig options:"
-
-config SND_AM33XX_SOC_EVM
-	tristate "SoC Audio for the AM33XX chip based boards"
-	depends on SOC_AM33XX && I2C
-	select SND_SOC_TLV320AIC3X
-	select SND_SOC_DAVINCI_MCASP
-	help
-	  Say Y or M if you want to add support for SoC audio on AM33XX
-	  boards using McASP and TLV320AIC3X codec. For example AM335X-EVM,
-	  AM335X-EVMSK, and BeagelBone with AudioCape boards have this
-	  setup.
-
-config SND_DAVINCI_SOC_EVM
-	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
-	depends on ARCH_DAVINCI && I2C
-	depends on MACH_DAVINCI_EVM || MACH_DAVINCI_DM355_EVM || MACH_DAVINCI_DM365_EVM
-	select SND_SOC_DAVINCI_EVM
-	help
-	  Say Y if you want to add support for SoC audio on TI
-	  DaVinci DM6446, DM355 or DM365 EVM platforms.
-
-choice
-	prompt "DM365 codec select"
-	depends on SND_DAVINCI_SOC_EVM
-	depends on MACH_DAVINCI_DM365_EVM
-
-config SND_DM365_AIC3X_CODEC
-	tristate "Audio Codec - AIC3101"
-	select SND_SOC_DM365_AIC3X_CODEC
-	help
-	  Say Y if you want to add support for AIC3101 audio codec
-
-config SND_DM365_VOICE_CODEC
-	tristate "Voice Codec - CQ93VC"
-	select SND_SOC_DM365_VOICE_CODEC
-	help
-	  Say Y if you want to add support for SoC On-chip voice codec
-endchoice
-
-config  SND_DM6467_SOC_EVM
-	tristate "SoC Audio support for DaVinci DM6467 EVM"
-	depends on MACH_DAVINCI_DM6467_EVM && I2C
-	select SND_SOC_DAVINCI_EVM
-
-	help
-	  Say Y if you want to add support for SoC audio on TI
-
-config  SND_DA830_SOC_EVM
-	tristate "SoC Audio support for DA830/OMAP-L137 EVM"
-	depends on MACH_DAVINCI_DA830_EVM && I2C
-	select SND_SOC_DAVINCI_EVM
-
-	help
-	  Say Y if you want to add support for SoC audio on TI
-	  DA830/OMAP-L137 EVM
-
-config  SND_DA850_SOC_EVM
-	tristate "SoC Audio support for DA850/OMAP-L138 EVM"
-	depends on MACH_DAVINCI_DA850_EVM && I2C
-	select SND_SOC_DAVINCI_EVM
-	help
-	  Say Y if you want to add support for SoC audio on TI
-	  DA850/OMAP-L138 EVM
-
-config SND_OMAP_SOC_HDMI_AUDIO
-	tristate "HDMI audio support for OMAP4+ based SoCs"
-	select SND_SOC_OMAP_HDMI
-	help
-	  For HDMI audio to work OMAPDSS HDMI support should be
-	  enabled.
-	  The hdmi audio driver implements cpu-dai component using the
-	  callbacks provided by OMAPDSS and registers the component
-	  under DSS HDMI device. Omap-pcm is registered for platform
-	  component also under DSS HDMI device. Dummy codec is used as
-	  as codec component. The hdmi audio driver implements also
-	  the card and registers it under its own platform device.
-	  The device for the driver is registered by OMAPDSS hdmi
-	  driver.
-
-config SND_OMAP_SOC_N810
-	tristate "SoC Audio support for Nokia N810"
-	depends on MACH_NOKIA_N810 && I2C
-	select SND_SOC_NOKIA_N810
-	help
-	  Say Y if you want to add support for SoC audio on Nokia N810.
-
-config SND_OMAP_SOC_RX51
-	tristate "SoC Audio support for Nokia N900 (RX-51)"
-	depends on ARM && I2C && GPIOLIB && ARCH_OMAP3
-	select SND_SOC_NOKIA_RX51
-	help
-	  Say Y if you want to add support for SoC audio on Nokia N900
-	  cellphone.
-
-config SND_OMAP_SOC_AMS_DELTA
-	tristate "SoC Audio support for Amstrad E3 (Delta) videophone"
-	depends on MACH_AMS_DELTA && TTY
-	select SND_SOC_OMAP_AMS_DELTA
-	help
-	  Say Y  if you want to add support  for SoC audio device  connected to
-	  a handset and a speakerphone found on Amstrad E3 (Delta) videophone.
-
-	  Note that in order to get those devices fully supported,  you have to
-	  build  the kernel  with  standard  serial port  driver  included  and
-	  configured for at least 4 ports.  Then, from userspace, you must load
-	  a line discipline #19 on the modem (ttyS3) serial line.  The simplest
-	  way to achieve this is to install util-linux-ng  and use the included
-	  ldattach  utility.  This  can be  started  automatically  from  udev,
-	  a simple rule like this one should do the trick (it does for me):
-	  	ACTION=="add", KERNEL=="controlC0", \
-				RUN+="/usr/sbin/ldattach 19 /dev/ttyS3"
-
-config SND_OMAP_SOC_OSK5912
-	tristate "SoC Audio support for omap osk5912"
-	depends on MACH_OMAP_OSK && I2C
-	select SND_SOC_OMAP_OSK5912
-	help
-	  Say Y if you want to add support for SoC audio on osk5912.
-
-config SND_OMAP_SOC_OMAP_TWL4030
-	tristate "SoC Audio support for TI SoC based boards with twl4030 codec"
-	depends on TWL4030_CORE
-	select SND_SOC_OMAP3_TWL4030
-	help
-	  Say Y if you want to add support for SoC audio on TI SoC based boards
-	  using twl4030 as c codec. This driver currently supports:
-	  - Beagleboard or Devkit8000
-	  - Gumstix Overo or CompuLab CM-T35/CM-T3730
-	  - IGEP v2
-	  - OMAP3EVM
-	  - SDP3430
-	  - Zoom2
-
-config SND_OMAP_SOC_OMAP_ABE_TWL6040
-	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
-	depends on TWL6040_CORE && COMMON_CLK
-	depends on ARCH_OMAP4 || (SOC_OMAP5 && MFD_PALMAS) || COMPILE_TEST
-	select SND_SOC_OMAP_ABE_TWL6040
-	help
-	  Say Y if you want to add support for SoC audio on OMAP boards using
-	  ABE and twl6040 codec. This driver currently supports:
-	  - SDP4430/Blaze boards
-	  - PandaBoard (4430)
-	  - PandaBoardES (4460)
-	  - omap5-uevm (5432)
-
-config SND_OMAP_SOC_OMAP3_PANDORA
-	tristate "SoC Audio support for OMAP3 Pandora"
-	depends on TWL4030_CORE
-	select SND_SOC_OMAP3_PANDORA
-	help
-	  Say Y if you want to add support for SoC audio on the OMAP3 Pandora.
-endmenu
-
 endmenu
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

