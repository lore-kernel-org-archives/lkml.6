Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0104C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B082177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549631479;
	bh=Hpw+alWVf4HRJL0bVp/AWf3aujoIEkZirIuWt/b/Myg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=EWq0NlyxSOz4Vhf+vKV4ErFqE+rNvrDyykZ/TbAdED8bmJw4E2kggiYUfs8QoF0VA
	 UUn+vt2PpnuJvn5kOsXMXu+Udq81d22gxc0T4LFVwRQrF6dmqnJCzzgFeVekInHoji
	 Z7LmQUyEbHeezO3rOgY1O6j9hiP/H7s1vD144XWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfBHNLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:11:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38046 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfBHNLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hENB2q6vvWZl4wvXwZBYVBxOiCYWvgULT3yMKbjPU9o=; b=HnXnwT03sFdU
        EacfzzlLosR2UV6wDT/4tHaxBwCPOaznhaaxk8VIFPMJZ5CHUTgDcQbzou2VSEDIUYAjE9YFAcB1X
        FsU6x7P18wT1NHbHYM/jZO1eg/3j8Zp1Wml6kx1/27Vug7ncw1Fo44JQwXxC3yq3nbHiHa4qz1o70
        XPjiQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gs5w0-0001Ja-7G; Fri, 08 Feb 2019 13:11:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C0F0D1127F30; Fri,  8 Feb 2019 13:11:11 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        alsa-devel@alsa-project.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: codecs: jz4725b: Remove unnecessary const qualifier" to the asoc tree
In-Reply-To:  <20190208045918.16799-1-natechancellor@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190208131111.C0F0D1127F30@debutante.sirena.org.uk>
Date:   Fri,  8 Feb 2019 13:11:11 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: jz4725b: Remove unnecessary const qualifier

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

From d9186330c881468722c005ee772ca745c81a29ef Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu, 7 Feb 2019 21:59:18 -0700
Subject: [PATCH] ASoC: codecs: jz4725b: Remove unnecessary const qualifier

Clang warns:

sound/soc/codecs/jz4725b.c:177:14: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
static const SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
             ^
include/sound/soc.h:356:2: note: expanded from macro 'SOC_VALUE_ENUM_SINGLE_DECL'
        SOC_VALUE_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xmask, xtexts, xvalues)
        ^
include/sound/soc.h:353:2: note: expanded from macro 'SOC_VALUE_ENUM_DOUBLE_DECL'
        const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, \
        ^

As it points out, SOC_VALUE_ENUM_DOUBLE_DECL has the const attribute in
its definition so remove it here.

Fixes: e9d97b05a80f ("ASoC: codecs: Add jz4725b-codec driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/354
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/jz4725b.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 103ccbc5d55c..766354c73076 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -173,12 +173,12 @@ static const char * const jz4725b_codec_adc_src_texts[] = {
 	"Mic 1", "Mic 2", "Line In", "Mixer",
 };
 static const unsigned int jz4725b_codec_adc_src_values[] = { 0, 1, 2, 3, };
-static const SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
-					JZ4725B_CODEC_REG_CR3,
-					REG_CR3_INSEL_OFFSET,
-					REG_CR3_INSEL_MASK,
-					jz4725b_codec_adc_src_texts,
-					jz4725b_codec_adc_src_values);
+static SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
+				  JZ4725B_CODEC_REG_CR3,
+				  REG_CR3_INSEL_OFFSET,
+				  REG_CR3_INSEL_MASK,
+				  jz4725b_codec_adc_src_texts,
+				  jz4725b_codec_adc_src_values);
 static const struct snd_kcontrol_new jz4725b_codec_adc_src_ctrl =
 			SOC_DAPM_ENUM("Route", jz4725b_codec_adc_src_enum);
 
-- 
2.20.1

