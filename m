Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573A2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261CB206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887547;
	bh=BAN0fhTz3ywJQvuPoIUPN6dNDOpQXvY0UmFegPn60ZI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=NBqQSuUd7GcnToNSIoRx0T7jgMODuP81pb47SWu4ksnFVEomwVG2T14bP4y601VuG
	 Fq0LUCdLKdDe9RRUrmGDx44854ix9/noZlHoNixlyDqYWc0MGJQk3G8nUAM+QDAQPo
	 TUG2L7zf4YaFx6XyXgmanzYu/HGXP1U7ojA5NGMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfAGS7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:59:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42066 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbfAGS6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qOVLzL/MCSmF430/ewdMGwZceCrdimAoegmQHNme8AE=; b=DvI14cUUxzWu
        PjSEZAQQKghFd6ytWqF/3ALD/DBbNIRTLiM+yBbXUBfhT+VRYqXYtdYWwKdQplzvOkRQGd5pwXS8T
        NePptbhqksZZ9xmjVUnFA1tcU2L4AP98y4byiAzWtiBBIWe+4rajIG+9vLBkeLt6iVyzz+jeQiZyx
        xz5DU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6c-0007p3-3j; Mon, 07 Jan 2019 18:58:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B1A7D1127491; Mon,  7 Jan 2019 18:58:33 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Jenny TC <jenny.tc@intel.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: dmic: declare trigger function as static" to the asoc tree
In-Reply-To:  <20190105020249.8639-2-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185833.B1A7D1127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:33 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dmic: declare trigger function as static

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

From 902d82222270c957d12fa2e9856484d600a88d20 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:29 -0600
Subject: [PATCH] ASoC: dmic: declare trigger function as static

No reason why this is global, fix warnings with W=1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/dmic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index da921da50ef0..de041369e5a7 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -44,8 +44,8 @@ struct dmic {
 	int modeswitch_delay;
 };
 
-int dmic_daiops_trigger(struct snd_pcm_substream *substream,
-		int cmd, struct snd_soc_dai *dai)
+static int dmic_daiops_trigger(struct snd_pcm_substream *substream,
+			       int cmd, struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
 	struct dmic *dmic = snd_soc_component_get_drvdata(component);
-- 
2.20.1

