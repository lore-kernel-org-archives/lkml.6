Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CCEC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BC420831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BC420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeKCAmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:42:38 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:35611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKCAmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:42:38 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M42fA-1gIbSb1SRE-0001PJ; Fri, 02 Nov 2018 16:34:09 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M42fA-1gIbSb1SRE-0001PJ; Fri, 02 Nov 2018 16:34:09 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: sunxi: rename SND_SUN8I_ADDA_PR_REGMAP
Date:   Fri,  2 Nov 2018 16:33:40 +0100
Message-Id: <20181102153406.1528053-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:fT64GQCt3ITNlORRv1BBYCNCCCF4dp4AUPXGY+8Cd4hqQf6OUi0
 a9dyGNM9kkEvvpaOKWc3fznCfwMmwReEa8h3m9BWqID0DSmfY3xRXPFAITA0eKOfiVnKx1S
 Ch8STSv+ZnMwy3A4eipNfK3lBQEDOTM/AOONVQBrq/KV1YFJyEdTsBxACb0v7K28EKZ+Acs
 FAjYdeBhqFiUJVWb6MALQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J1+RDrAoVjU=:sCZDXzLXJw5uCGCxELqcPR
 4DBd4VR2Xm1W9enHgYlEmU/94ufNZU778ORyadVIDHqCXh9oL6h7ReWT0nyk6L08nC9vSqVkl
 axTqjpnjHP5V2JrPQUqsN9yxurvfka2TCPdWZaq0xGr3lafd5/2FD6O9Mcs+4zNoFWeUHcYgC
 ygTMJiDd0bIPYAJaxguQATlJOK2M47JPB4eFSTYS6RVS97SDRChqAL+7AMp0ijTjBrjqpWybG
 orALo2FGqehKv9oTMpYOoypET/E78zBjQtzymfdFHk0yQOLertGS9tuOXmWFGn9vvi4s3sqnC
 BITKjBAJ0/4JHKC/C8Ba3KPbgkSYBvu+05NbABtF+LQ+pLyMPUSaxQrlwfE8khtj4xBBXiZE3
 DhuQYpVL6Hd0xvjSy1AW5D9JasMBBMzBtIf0Bg/BglHFM+nKS842UTM/59IiAlaxFN7puo7ah
 5a9G1GwGmfn/XOSIL9hc4/reUHR5DS7WCHimSIqvmOhnoHkVElxJxmDa/um1hKFDpi+Svf4SP
 yYB0MAjijk+gSYLAScCPWWsNHDCeMx8+DWQ+mh+d5iXTjR4MF+y5l7HuazLXo1cFbW2ZqsJJp
 dzci/rlXHPpUe6xOxOxPcBLhucXHZQiHA90T41xFq5nYYbkhwQAHY0VOshu0kBoUIJJQC55ve
 LGfB41DwkP82c1pLUMaoLvmarr9+pSImYvoX7l11dc1C1ivcY8oGwB5mYfx+L0f2fxpU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added SND_SUN50I_CODEC_ANALOG driver selects a nonexisting
symbol SND_SUNXI_ADDA_PR_REGMAP, which was evidently intended to replace
SND_SUN8I_ADDA_PR_REGMAP, but since they are now mismatched, we can run
into link errors for some configurations:

sound/soc/sunxi/sun50i-codec-analog.o: In function `sun50i_codec_analog_probe':
sun50i-codec-analog.c:(.text+0x62): undefined reference to `sun8i_adda_pr_regmap_init'

The new name appears to be more sensible, and as the symbol is hidden,
there are no downsides in the rename, so use that consistently now.

Fixes: 42371f327df0 ("ASoC: sunxi: Add new driver for Allwinner A64 codec's analog path controls")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sunxi/Kconfig  | 4 ++--
 sound/soc/sunxi/Makefile | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 66aad0d3f9c7..0f992bdf1a10 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -23,7 +23,7 @@ config SND_SUN8I_CODEC
 config SND_SUN8I_CODEC_ANALOG
 	tristate "Allwinner sun8i Codec Analog Controls Support"
 	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
-	select SND_SUN8I_ADDA_PR_REGMAP
+	select SND_SUNXI_ADDA_PR_REGMAP
 	help
 	  Say Y or M if you want to add support for the analog controls for
 	  the codec embedded in newer Allwinner SoCs.
@@ -54,7 +54,7 @@ config SND_SUN4I_SPDIF
 	  Say Y or M to add support for the S/PDIF audio block in the Allwinner
 	  A10 and affiliated SoCs.
 
-config SND_SUN8I_ADDA_PR_REGMAP
+config SND_SUNXI_ADDA_PR_REGMAP
 	tristate
 	select REGMAP
 
diff --git a/sound/soc/sunxi/Makefile b/sound/soc/sunxi/Makefile
index a86be340a076..c4dd2803a011 100644
--- a/sound/soc/sunxi/Makefile
+++ b/sound/soc/sunxi/Makefile
@@ -5,4 +5,4 @@ obj-$(CONFIG_SND_SUN4I_SPDIF) += sun4i-spdif.o
 obj-$(CONFIG_SND_SUN8I_CODEC_ANALOG) += sun8i-codec-analog.o
 obj-$(CONFIG_SND_SUN50I_CODEC_ANALOG) += sun50i-codec-analog.o
 obj-$(CONFIG_SND_SUN8I_CODEC) += sun8i-codec.o
-obj-$(CONFIG_SND_SUN8I_ADDA_PR_REGMAP) += sun8i-adda-pr-regmap.o
+obj-$(CONFIG_SND_SUNXI_ADDA_PR_REGMAP) += sun8i-adda-pr-regmap.o
-- 
2.18.0

