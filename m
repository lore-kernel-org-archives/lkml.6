Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A333C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090EF206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887723;
	bh=I9glFtasa+omp4z1O9S6XOyXpoZGtpXj6fViH8G6Wcg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=rPu5hG1xLa9SjXJp+D1yCdHW8PvcDaJ+84736mBt/EN6s1xZwKE5aKAKwBT0ZhJit
	 otDicyc63Ru5WCpaF+J2rbGM3rcIai7C1hk47sgNNDXy/aTmYpKjhnUKXnHDQ4gwfb
	 ZiwPhv2UFjcnY7pEtU13DHQ678ffqxaRmICJHBnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfAGTBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:01:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40540 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbfAGS6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=FcPwXZ/ImYm9gw7NrZp9B6EBR0r695ObnvPVpD/wZrk=; b=ACLDF+4WJm+0
        uUuaRbBurZiu2o2KbM3OXTryrQ4SjWJEu509X+XOc040FW5TvgkG9dX1FG6a4BU+1ZKPAjvPkR+xq
        bIok8RhAoItQsRm+l3a9QuXoWYWGy06bOTnxKPKNSENQ/Nik9dcFmhTiGqTYCJufHAuxFJbn7BwB0
        3AnLg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga66-0007m3-Cv; Mon, 07 Jan 2019 18:58:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 086401127491; Mon,  7 Jan 2019 18:58:02 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Support Opensource <support.opensource@diasemi.com>,
        tiwai@suse.de, open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: da7219: use logical AND" to the asoc tree
In-Reply-To:  <20190105020249.8639-20-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185802.086401127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:02 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: da7219: use logical AND

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

From b468f379e1e01b723825267431d3ba60f824fda2 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:47 -0600
Subject: [PATCH] ASoC: da7219: use logical AND

Reported by Sparse:
da7219.c:841:57: warning: dubious: x & !y

Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index ce165047b9f9..513ec0368653 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -838,7 +838,7 @@ static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 				++i;
 				msleep(50);
 			}
-		} while ((i < DA7219_SRM_CHECK_RETRIES) & (!srm_lock));
+		} while ((i < DA7219_SRM_CHECK_RETRIES) && (!srm_lock));
 
 		if (!srm_lock)
 			dev_warn(component->dev, "SRM failed to lock\n");
-- 
2.20.1

