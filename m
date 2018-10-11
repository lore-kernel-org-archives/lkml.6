Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2111BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20602085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="w0ABnq+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20602085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeJKWNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:13:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57618 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKWNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=v1L3MDGwSXiBtgrn45rCEpSxAgfeGogOmVbIILfQxUY=; b=w0ABnq+DH1Li
        jxdNa/5eS1+RNCo7CEwrw3Rd2w/Y+aVWV1uSvcabp26tAXhD6aXEH0Jr6jDOqka6qpozD6qwcPMaQ
        tMhlU+j4Q3JZc5RZilH6+oCRc2iOj498kjDU7/utMusga3BbqiBvnR+8UJWByBH+jocHXYuBxjc2l
        l9fVI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAcDs-0001pt-4k; Thu, 11 Oct 2018 14:45:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D64CD11223ED; Thu, 11 Oct 2018 15:45:55 +0100 (BST)
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
Subject: Applied "ASoC: max98373: Sort DHT Rot Pnt Volume in reverse order" to the asoc tree
In-Reply-To:  <20181010232222.52340-4-ryans.lee@maximintegrated.com>
Message-Id: <20181011144555.D64CD11223ED@debutante.sirena.org.uk>
Date:   Thu, 11 Oct 2018 15:45:55 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98373: Sort DHT Rot Pnt Volume in reverse order

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

From a23f5dc8448694a0ffe2127a04aa5787b9cf9e5f Mon Sep 17 00:00:00 2001
From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Date: Wed, 10 Oct 2018 23:26:17 +0000
Subject: [PATCH] ASoC: max98373: Sort DHT Rot Pnt Volume in reverse order

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 37f8bcdd8e35..a09d01318f79 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -471,12 +471,12 @@ static const DECLARE_TLV_DB_RANGE(max98373_dht_spkgain_min_tlv,
 	0, 9, TLV_DB_SCALE_ITEM(800, 100, 0),
 );
 static const DECLARE_TLV_DB_RANGE(max98373_dht_rotation_point_tlv,
-	0, 1, TLV_DB_SCALE_ITEM(-50, -50, 0),
-	2, 7, TLV_DB_SCALE_ITEM(-200, -100, 0),
-	8, 9, TLV_DB_SCALE_ITEM(-1000, -200, 0),
-	10, 11, TLV_DB_SCALE_ITEM(-1500, -300, 0),
-	12, 13, TLV_DB_SCALE_ITEM(-2000, -200, 0),
-	14, 15, TLV_DB_SCALE_ITEM(-2500, -500, 0),
+	0, 1, TLV_DB_SCALE_ITEM(-3000, 500, 0),
+	2, 4, TLV_DB_SCALE_ITEM(-2200, 200, 0),
+	5, 6, TLV_DB_SCALE_ITEM(-1500, 300, 0),
+	7, 9, TLV_DB_SCALE_ITEM(-1000, 200, 0),
+	10, 13, TLV_DB_SCALE_ITEM(-500, 100, 0),
+	14, 15, TLV_DB_SCALE_ITEM(-100, 50, 0),
 );
 static const DECLARE_TLV_DB_RANGE(max98373_limiter_thresh_tlv,
 	0, 15, TLV_DB_SCALE_ITEM(-1500, 100, 0),
@@ -617,7 +617,7 @@ SOC_SINGLE("DHT Switch", MAX98373_R20D4_DHT_EN,
 SOC_SINGLE_TLV("DHT Min Volume", MAX98373_R20D1_DHT_CFG,
 	MAX98373_DHT_SPK_GAIN_MIN_SHIFT, 9, 0, max98373_dht_spkgain_min_tlv),
 SOC_SINGLE_TLV("DHT Rot Pnt Volume", MAX98373_R20D1_DHT_CFG,
-	MAX98373_DHT_ROT_PNT_SHIFT, 15, 0, max98373_dht_rotation_point_tlv),
+	MAX98373_DHT_ROT_PNT_SHIFT, 15, 1, max98373_dht_rotation_point_tlv),
 SOC_SINGLE_TLV("DHT Attack Step Volume", MAX98373_R20D2_DHT_ATTACK_CFG,
 	MAX98373_DHT_ATTACK_STEP_SHIFT, 4, 0, max98373_dht_step_size_tlv),
 SOC_SINGLE_TLV("DHT Release Step Volume", MAX98373_R20D3_DHT_RELEASE_CFG,
-- 
2.19.0.rc2

