Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CC4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3161206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887705;
	bh=PeSgtdSNJhTyaWBtu/LUdz63k8FZfuQPvS7/5X1jd/c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=RoYj3hpzbmEtSUFEDRSLMjvqTcqtZxEfvClfqGQmMtvkik778bcXC9ztbdGfVFQyl
	 cY9iQaBGDEgQPHKPfVRv68AIvvfuu/7cQZsDZZPw4ZbJzdYMbADBYVqj4gWOmSFRqs
	 26Q09GW5ZDKJPM1D579093jNrbOX5WVR5N3/f6aI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfAGTBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:01:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40534 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfAGS6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WaEF+S0xXPxBBPGhrrHgLbhQl7yArUYoW3hZHYm2E6I=; b=vvQnBCBeXH59
        QTjafVMPQFa3pcnniNhPZRk1TRLLXBGA8vBKq3Y4BdgDMa8hhsroA7Ey0ZGfk+ocqkcJzGpW0K82O
        LSnaKIONRvS+QCHzQl174JrQ+IKJ7x74bq8iAvi3qoLh71ohGTC4OdTMGrwyROmPzMcQYQxjUfOWL
        q8hsc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga62-0007li-Lk; Mon, 07 Jan 2019 18:57:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4F0EE1127491; Mon,  7 Jan 2019 18:57:58 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Bard liao <yung-chuan.liao@linux.intel.com>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Oder Chiou <oder_chiou@realtek.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: rl6437a: use __be32 for a __be32 buf" to the asoc tree
In-Reply-To:  <20190105020249.8639-22-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185758.4F0EE1127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:57:58 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rl6437a: use __be32 for a __be32 buf

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

From b8e022e83ba99a0deb27e929033008402f863dd7 Mon Sep 17 00:00:00 2001
From: Bard liao <yung-chuan.liao@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:49 -0600
Subject: [PATCH] ASoC: rl6437a: use __be32 for a __be32 buf

The buf in rl6347a_hw_read is __be32.

Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rl6347a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rl6347a.c b/sound/soc/codecs/rl6347a.c
index 8f571cf8edd4..c0d729b45277 100644
--- a/sound/soc/codecs/rl6347a.c
+++ b/sound/soc/codecs/rl6347a.c
@@ -64,8 +64,8 @@ int rl6347a_hw_read(void *context, unsigned int reg, unsigned int *value)
 	struct i2c_client *client = context;
 	struct i2c_msg xfer[2];
 	int ret;
-	__be32 be_reg;
-	unsigned int index, vid, buf = 0x0;
+	__be32 be_reg, buf = 0x0;
+	unsigned int index, vid;
 
 	/* handle index registers */
 	if (reg <= 0xff) {
-- 
2.20.1

