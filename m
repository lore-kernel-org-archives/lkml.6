Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE10C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B30F2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Ocz2zU9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B30F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeJKWNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:13:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58066 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKWNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KbSX8piZTTgT6zHT5YlRclcDJOuL59QoaijNh6OI6zA=; b=Ocz2zU9prO1M
        WtpWDVzrPmgxxVtfJPv8JChVztrLhJ39c64tEMc1MtZD6MTHVPrmGdR2qdE60/+eKW5f45Qn/hWVV
        bwLSSHRyCLo0uUaW8ztSHYOkdAImp1Z/KyjFaXyjoyB2ZT5vtANhEbrWTC/Z0WYqwGITfsKl/zN+w
        Dd6Hg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAcE8-0001qG-Ti; Thu, 11 Oct 2018 14:46:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id ADE7911223ED; Thu, 11 Oct 2018 15:46:12 +0100 (BST)
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
Subject: Applied "ASoC: max98373: Sort BDE Limiter Thresh Volume in reverse order" to the asoc tree
In-Reply-To:  <20181010232222.52340-2-ryans.lee@maximintegrated.com>
Message-Id: <20181011144612.ADE7911223ED@debutante.sirena.org.uk>
Date:   Thu, 11 Oct 2018 15:46:12 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98373: Sort BDE Limiter Thresh Volume in reverse order

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

From 6c3beeca424a0c8d6c79184a880a8954bd498d57 Mon Sep 17 00:00:00 2001
From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Date: Wed, 10 Oct 2018 23:26:10 +0000
Subject: [PATCH] ASoC: max98373: Sort BDE Limiter Thresh Volume in reverse
 order

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 9b7ccd351cae..38871677cbae 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -479,7 +479,7 @@ static const DECLARE_TLV_DB_RANGE(max98373_dht_rotation_point_tlv,
 	14, 15, TLV_DB_SCALE_ITEM(-2500, -500, 0),
 );
 static const DECLARE_TLV_DB_RANGE(max98373_limiter_thresh_tlv,
-	0, 15, TLV_DB_SCALE_ITEM(0, -100, 0),
+	0, 15, TLV_DB_SCALE_ITEM(-1500, 100, 0),
 );
 
 static const DECLARE_TLV_DB_RANGE(max98373_bde_gain_tlv,
@@ -670,13 +670,13 @@ SOC_SINGLE_TLV("BDE LVL3 Clip Reduction Volume", MAX98373_R20B0_BDE_L3_CFG_3,
 SOC_SINGLE_TLV("BDE LVL4 Clip Reduction Volume", MAX98373_R20B3_BDE_L4_CFG_3,
 	0, 0x3C, 0, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL1 Limiter Thresh Volume", MAX98373_R20A8_BDE_L1_CFG_1,
-	0, 0xF, 0, max98373_limiter_thresh_tlv),
+	0, 0xF, 1, max98373_limiter_thresh_tlv),
 SOC_SINGLE_TLV("BDE LVL2 Limiter Thresh Volume", MAX98373_R20AB_BDE_L2_CFG_1,
-	0, 0xF, 0, max98373_limiter_thresh_tlv),
+	0, 0xF, 1, max98373_limiter_thresh_tlv),
 SOC_SINGLE_TLV("BDE LVL3 Limiter Thresh Volume", MAX98373_R20AE_BDE_L3_CFG_1,
-	0, 0xF, 0, max98373_limiter_thresh_tlv),
+	0, 0xF, 1, max98373_limiter_thresh_tlv),
 SOC_SINGLE_TLV("BDE LVL4 Limiter Thresh Volume", MAX98373_R20B1_BDE_L4_CFG_1,
-	0, 0xF, 0, max98373_limiter_thresh_tlv),
+	0, 0xF, 1, max98373_limiter_thresh_tlv),
 /* Limiter */
 SOC_SINGLE("Limiter Switch", MAX98373_R20E2_LIMITER_EN,
 	MAX98373_LIMITER_EN_SHIFT, 1, 0),
-- 
2.19.0.rc2

