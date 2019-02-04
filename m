Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1EAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89995214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549271284;
	bh=/xJp5l7glGy/bq8lITMInq3WDJ/71EvCOuSHC/0psB8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=RkZCOaWyUa4Mz05lRMkDt2DDXxVas+kDoTAKE34RbhmEioA/eGJm5YNhsvS0mijJa
	 oI26lKuIbLjscHv+O5kkB+dj3crolt5COjS5MVP39JnELfemSKiAs7WkifNH1WYONm
	 yVNlNrbyeK0uhSYoQX0gtE1zQ7UMkwBEm7RNLbIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfBDJID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:08:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40814 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfBDJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3Dq+g6lR0JWV+AnlTj24dxl1gWoTDQj222HSXcEWh0w=; b=Ma5rR66u/2Sf
        QtW4I8S4yNJLqRBfUBGTG76/QFi0CHORPq4fxqK60x9CCOXz0VFgUpooN7AhAWpFc+dNrwHIELsi2
        2W+Uf/gu+KqDV4gtF29MsT8dJ4uRNwJ5n6+V9B4hyUKsf79Qz1w3+jKzRNI/0tHKFmw1oWcL8WdCW
        7JTg4=;
Received: from 53.97-247-81.adsl-dyn.isp.belgacom.be ([81.247.97.53] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gqaDe-0000gd-Dn; Mon, 04 Feb 2019 09:07:10 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C90F1440082; Mon,  4 Feb 2019 09:07:08 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     wen yang <yellowriver2010@hotmail.com>
Cc:     Wen Yang <yellowriver2010@hotmil.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe" to the asoc tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190204090708.C90F1440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Feb 2019 09:07:08 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe

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

From 11907e9d3533648615db08140e3045b829d2c141 Mon Sep 17 00:00:00 2001
From: wen yang <yellowriver2010@hotmail.com>
Date: Sat, 2 Feb 2019 14:53:16 +0000
Subject: [PATCH] ASoC: fsl-asoc-card: fix object reference leaks in
 fsl_asoc_card_probe

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Signed-off-by: Wen Yang <yellowriver2010@hotmil.com>
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 81f2fe2c6d23..60f87a0d99f4 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -689,6 +689,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 asrc_fail:
 	of_node_put(asrc_np);
 	of_node_put(codec_np);
+	put_device(&cpu_pdev->dev);
 fail:
 	of_node_put(cpu_np);
 
-- 
2.20.1

