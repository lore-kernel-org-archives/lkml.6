Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908FEC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BED5214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547121907;
	bh=YN5kXd+pLKbV6zQQBMxxgDLF0RsvrRB3oaJf6oQyQ+4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dJh3XkMbejOkelhwFzz+GawnXIfI5iS8HFSF0xv8fpJp670BWrN7ovwZTG1c25G8D
	 c0KccrG3d29fwUIqRbJKDpdOuyk3VRXAvef9VXIgZCLMhsZ2EyaEq2Pe6kchrj9nd0
	 DJXOScdLI0au85kRP+9gqLJn8ocn2K8woqcXlflA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfAJMFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:05:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50214 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfAJMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=N1M+86eqy0R7Kit/K+nZRQKvoSzJj/WXI8KqdOW37WQ=; b=JGC1pLBG1UTr
        yITaE9TUOd+3Bjg2EvoMEEDF8qCYxW501gOv0ICWabSt0ZpLoGYzx+tZucCJRLkkUCZM6/cJgblg8
        uvj5Kbna0UbusdDW3aRWoXVor5JhfIy7oaASVxoYmBnXxKmAQVohv+7nSE4kHw7HEQuB7SW6TQ6vi
        P6zYU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghZ4r-0003QK-9h; Thu, 10 Jan 2019 12:04:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B36591127052; Thu, 10 Jan 2019 12:04:48 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Mark Brown <broonie@kernel.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, asishb@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, vinod.koul@linaro.org,
        Ajit Pandey <ajitp@codeaurora.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: soc-core: Hold client_mutex around soc_init_dai_link()" to the asoc tree
In-Reply-To:  <1547110961-23670-1-git-send-email-rohitkr@codeaurora.org>
X-Patchwork-Hint: ignore
Message-Id: <20190110120448.B36591127052@debutante.sirena.org.uk>
Date:   Thu, 10 Jan 2019 12:04:48 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-core: Hold client_mutex around soc_init_dai_link()

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

From 04eb1efcd614d6f067b76a355b3a3599667959dc Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Thu, 10 Jan 2019 14:32:41 +0530
Subject: [PATCH] ASoC: soc-core: Hold client_mutex around soc_init_dai_link()

soc_init_dai_link() calls soc_find_component() which needs
to be within client_mutex lock. Add client_mutex lock around
soc_init_dai_link() in snd_soc_register_card() to avoid
lockdep warning.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index eec92f17dd15..0934b36645b3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1027,6 +1027,7 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 				 struct snd_soc_dai_link *dai_link)
 {
 	struct snd_soc_dai_link_component *platform = dai_link->platform;
+
 	/*
 	 * FIXME
 	 *
@@ -2754,15 +2755,18 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
+	mutex_lock(&client_mutex);
 	for_each_card_prelinks(card, i, link) {
 
 		ret = soc_init_dai_link(card, link);
 		if (ret) {
 			dev_err(card->dev, "ASoC: failed to init link %s\n",
 				link->name);
+			mutex_unlock(&client_mutex);
 			return ret;
 		}
 	}
+	mutex_unlock(&client_mutex);
 
 	dev_set_drvdata(card->dev, card);
 
-- 
2.20.1

