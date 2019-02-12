Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357BDC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4222083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549981333;
	bh=khnph0eDtUWaiZEhqsDTd5vIX8FWWgtkrxmNoih8Atc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=mWuQMie7gi7KSCHOmw61RDkWO2ux/7Izgwp8J3GvHRs667jwaxO+4owYaZhZHrSQf
	 R8C5lqzVyglyxxXOe79QukYazU/vPA9Oar7j4ZYIQFZLy0LI+lTTCgKi33dh4/YBMa
	 r7BCV38fc4Bwhgx6v+i0GUd2a9BvVOLcb8JQD8pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbfBLOWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:22:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55330 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbfBLOWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SxCd3p/Pc1rwfRIov/t0Yxm6i5Ew1g4pJvVemML/+GM=; b=F7Eki03i7zXA
        aSG4O3WP8yYVr0pPzZp+haCnrd3TiW1bSUe3r22KBku+/MHQozx9wEKvUrIZmG1y3QHtIaoA1I1n1
        fsSoXulxTwOPxJ4oQ81ieL8Ucuc06s1SbDRbGSRlEbMXZlZ4Eygk6Ol7ZB0qhnFE8yThQIkfFk5o1
        JNGE0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtYwm-0004bW-ST; Tue, 12 Feb 2019 14:22:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7A93A1128113; Tue, 12 Feb 2019 14:22:04 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: pcm3060: Add soft reset on probe" to the asoc tree
In-Reply-To:  <20190211060839.21417-1-kmarinushkin@birdec.tech>
X-Patchwork-Hint: ignore
Message-Id: <20190212142204.7A93A1128113@debutante.sirena.org.uk>
Date:   Tue, 12 Feb 2019 14:22:04 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pcm3060: Add soft reset on probe

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

From a3daee085905e97ba20e6b9e72e6639fa518209c Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Date: Mon, 11 Feb 2019 07:08:38 +0100
Subject: [PATCH] ASoC: pcm3060: Add soft reset on probe

Softly reset registers values on module probe

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3060.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 6714aa8d9026..543cb86fd764 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -287,6 +287,14 @@ int pcm3060_probe(struct device *dev)
 	int rc;
 	struct pcm3060_priv *priv = dev_get_drvdata(dev);
 
+	/* soft reset */
+	rc = regmap_update_bits(priv->regmap, PCM3060_REG64,
+				PCM3060_REG_MRST, 0);
+	if (rc) {
+		dev_err(dev, "failed to reset component, rc=%d\n", rc);
+		return rc;
+	}
+
 	if (dev->of_node)
 		pcm3060_parse_dt(dev->of_node, priv);
 
-- 
2.20.1

