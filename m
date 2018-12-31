Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93A4C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9838821019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546285356;
	bh=4p1k54+Kb29AsjYz1MDmzzw96jsJH4AjuDXqH2lh1t4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=MHac66gIpM4hZW0UAICDTrrH3ybcohCOY2fEG4jIM0ugh1hW5pcJ3yIkkq8KyirQX
	 G6NVbJxeBs2EO06I78cY730DUDYAx1QZp8Ug6dXxcNgRhE6dPht1UJl4i1vMnlBVaV
	 SLmBWybhDoeYhUgjBOwIU/gFtPAymXxzcD0ECkic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeLaTmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 14:42:35 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47600 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbeLaTme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 14:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=b9MGfoMDNutnRLF76ywp0AtazYBUokiyn+kzO6fbfwg=; b=tSPn6o1ZCkCs
        6OE++ncTYa5n2Y788iwMSSB+qUEVrOA+L+IMpZDkdltg+hYOpdxeDrHN9lOwLi/u2N3bxT3x+46UN
        WdSgigRHbDNG4t7EbZfx9Fbrfw5+KveLbibrA+FPlx6YGi2uraAMApErQsouK7Ghw0CXdD4ClsynM
        ePPdo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ge3S9-0002mT-DM; Mon, 31 Dec 2018 19:42:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2FE23440080; Mon, 31 Dec 2018 19:42:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, kbuild-all@01.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: rockchip: fix platform_no_drv_owner.cocci warnings" to the asoc tree
In-Reply-To:  <20181225043826.GA158508@lkp-ib04.lkp.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20181231194216.2FE23440080@finisterre.ee.mobilebroadband>
Date:   Mon, 31 Dec 2018 19:42:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: fix platform_no_drv_owner.cocci warnings

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

From 95be5edaa1b9e09c90e2d3a492745554ea6c04e6 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 25 Dec 2018 02:20:36 +0000
Subject: [PATCH] ASoC: rockchip: fix platform_no_drv_owner.cocci warnings

Remove .owner field if calls are used which set it automatically
Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rk3328_codec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
index f3442a2283ea..24f8f86d58e9 100644
--- a/sound/soc/codecs/rk3328_codec.c
+++ b/sound/soc/codecs/rk3328_codec.c
@@ -508,7 +508,6 @@ MODULE_DEVICE_TABLE(of, rk3328_codec_of_match);
 static struct platform_driver rk3328_codec_driver = {
 	.driver = {
 		   .name = "rk3328-codec",
-		   .owner = THIS_MODULE,
 		   .of_match_table = of_match_ptr(rk3328_codec_of_match),
 	},
 	.probe = rk3328_platform_probe,
-- 
2.20.1

