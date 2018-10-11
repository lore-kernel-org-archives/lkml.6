Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8172C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780ED20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="I1MzZPgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780ED20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeJKWOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:14:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58326 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKWOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=BuI7NfF/Ks9KD1RiiiVDQrUDcETpkm/0WfmQSw4wO0c=; b=I1MzZPgnE9AQ
        1fnfxPKJ67fhZcsY0MKV7zlCK529ulJji/Cr5qsqOkJ2ErG1126PXp0xsDjIvwPT7nEYZ2nlWyjqw
        2bQC8AWgc2VffXdUsjGfWA7n5O7XcnDkSrOdS6kYRgg8M8WfwEPQRGirevBcayyzjnh/zBidokuRG
        fGJ/M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAcEH-0001qT-Nz; Thu, 11 Oct 2018 14:46:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6F77C11223ED; Thu, 11 Oct 2018 15:46:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc:     Ryan Lee <ryans.lee@maximintegrated.com>,
        Mark Brown <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: max98373: Sort Digital Volume in reverse order" to the asoc tree
In-Reply-To:  <20181010232222.52340-1-ryans.lee@maximintegrated.com>
Message-Id: <20181011144621.6F77C11223ED@debutante.sirena.org.uk>
Date:   Thu, 11 Oct 2018 15:46:21 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98373: Sort Digital Volume in reverse order

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

From 4cbbc91609846c09a8350080cd7e6f7764fb2ec1 Mon Sep 17 00:00:00 2001
From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Date: Wed, 10 Oct 2018 23:26:06 +0000
Subject: [PATCH] ASoC: max98373: Sort Digital Volume in reverse order

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index d6868c9a9ce6..9b7ccd351cae 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -455,7 +455,7 @@ SND_SOC_DAPM_SIGGEN("IMON"),
 SND_SOC_DAPM_SIGGEN("FBMON"),
 };
 
-static DECLARE_TLV_DB_SCALE(max98373_digital_tlv, 0, -50, 0);
+static DECLARE_TLV_DB_SCALE(max98373_digital_tlv, -6350, 50, 1);
 static const DECLARE_TLV_DB_RANGE(max98373_spk_tlv,
 	0, 8, TLV_DB_SCALE_ITEM(0, 50, 0),
 	9, 10, TLV_DB_SCALE_ITEM(500, 100, 0),
@@ -605,7 +605,7 @@ SOC_SINGLE("Dither Switch", MAX98373_R203F_AMP_DSP_CFG,
 SOC_SINGLE("DC Blocker Switch", MAX98373_R203F_AMP_DSP_CFG,
 	MAX98373_AMP_DSP_CFG_DCBLK_SHIFT, 1, 0),
 SOC_SINGLE_TLV("Digital Volume", MAX98373_R203D_AMP_DIG_VOL_CTRL,
-	0, 0x7F, 0, max98373_digital_tlv),
+	0, 0x7F, 1, max98373_digital_tlv),
 SOC_SINGLE_TLV("Speaker Volume", MAX98373_R203E_AMP_PATH_GAIN,
 	MAX98373_SPK_DIGI_GAIN_SHIFT, 10, 0, max98373_spk_tlv),
 SOC_SINGLE_TLV("FS Max Volume", MAX98373_R203E_AMP_PATH_GAIN,
-- 
2.19.0.rc2

