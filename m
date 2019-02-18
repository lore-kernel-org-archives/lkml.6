Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39DBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C05217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515979;
	bh=I/tS1M3b5ySesCipRj3YCueHYB3IjNRSh74UJw4Nqb4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=MIKbfyVO1LknDpuRdfs3ZgSoKRMtBR81WOOsbOinC8mD8UlgELlVh/aXzmM9CzDaf
	 WvVa9MTM3GwORZQNpN9i1QYlDJcVw5DDYV49UzDlVEXILy0mRFY2LAuRyMOW3envi4
	 70xNktAAeNhKfMa7Xib2MVOLDVKZ6ZHxrYlrcECY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfBRSw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:52:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47274 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbfBRSwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=a4RStyqL0UfseD8kB7ojNjyPlgcCXXilGpt7LZX1HH4=; b=ig1YB3d4qF6F
        URknWdKn440biN4tarUZXIRcBb0k5xtJs00qZzzaifB6byM9woCxpiW4npxhRB4WfeD0aLdnqD2U5
        vxJsWnHTxkhyDOt42LdetlhkgDHXvDrtahSVbrUjCNk/Oa08yjj03ydQVid7Z+DZDwXTSJcUQ4oP3
        ekjxQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvo1m-0001il-98; Mon, 18 Feb 2019 18:52:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B34E61128008; Mon, 18 Feb 2019 18:52:29 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman <james.schulman@cirrus.com>,
        kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: cs35l36: Make some symbols static" to the asoc tree
In-Reply-To:  <20190218074653.181365-1-weiyongjun1@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190218185229.B34E61128008@debutante.sirena.org.uk>
Date:   Mon, 18 Feb 2019 18:52:29 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs35l36: Make some symbols static

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

From b2c02c63ac254530cffe3a7dc7d4e433da1b3a67 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 18 Feb 2019 07:46:53 +0000
Subject: [PATCH] ASoC: cs35l36: Make some symbols static

Fixes the following sparse warnings:

sound/soc/codecs/cs35l36.c:135:20: warning:
 symbol 'cs35l36_reg' was not declared. Should it be static?
sound/soc/codecs/cs35l36.c:248:6: warning:
 symbol 'cs35l36_readable_reg' was not declared. Should it be static?
sound/soc/codecs/cs35l36.c:398:6: warning:
 symbol 'cs35l36_precious_reg' was not declared. Should it be static?
sound/soc/codecs/cs35l36.c:410:6: warning:
 symbol 'cs35l36_volatile_reg' was not declared. Should it be static?

Fixes: 6ba9dd6c893b ("ASoC: cs35l36: Add support for Cirrus CS35L36 Amplifier")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: James Schulman <james.schulman@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l36.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
index e374fffb7e17..dc8cf61b9db8 100644
--- a/sound/soc/codecs/cs35l36.c
+++ b/sound/soc/codecs/cs35l36.c
@@ -131,7 +131,7 @@ static const struct cs35l36_pll_config cs35l36_pll_sysclk[] = {
 	{27000000,	0x3F, 0x0A},
 };
 
-struct reg_default cs35l36_reg[] = {
+static struct reg_default cs35l36_reg[] = {
 	{CS35L36_TESTKEY_CTRL,			0x00000000},
 	{CS35L36_USERKEY_CTL,			0x00000000},
 	{CS35L36_OTP_CTRL1,			0x00002460},
@@ -244,7 +244,7 @@ struct reg_default cs35l36_reg[] = {
 	{CS35L36_PAC_INT7_CTRL,			0x00000001},
 };
 
-bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
+static bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case CS35L36_SW_RESET:
@@ -394,7 +394,7 @@ bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
+static bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case CS35L36_TESTKEY_CTRL:
@@ -406,7 +406,7 @@ bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-bool cs35l36_volatile_reg(struct device *dev, unsigned int reg)
+static bool cs35l36_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case CS35L36_SW_RESET:
-- 
2.20.1

