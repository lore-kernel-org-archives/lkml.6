Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C162CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A68D2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887543;
	bh=IRcDshHCBJigh2uwl0lmMNB1hCM03tgO+bG9/wyt94Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yfj0pAma7G7WJ4nF2xxu+mS/BldvdpggRIxgpbC0Nx6vqSSzHNRUYq0SW7xipTH9J
	 BAv3+m0SOFEq2gZYozRKl79P+e8WcabFs75YXWlOh1MUYBzXTTLcoJKyeRnE2m3e/T
	 3cLtRUl0k7bJgTIMWe2R/0C6aWvreH/Lice64WEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfAGS7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:59:02 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42298 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfAGS66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HRf5kn33r7fEQgiKgrSPHNJfVuLdODB8ZHNDwqgSrRQ=; b=wkDnQwC5kzPw
        Hsn+WX7Au43JuqHEIBCwud7cvHjRSzjEp7bRtXhg0ngowqnYfcBSa9gmvitlhIumqUV1uCXGfw96w
        bN/PeQcAK6+LhM20e1Ckk9GEPM9YXx7feCvS1E1h2r1EFTRp8NXoFp0KjrCu22jR7xVrsqKGYBwrn
        xtsF8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6D-0007mg-Px; Mon, 07 Jan 2019 18:58:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 69B7D1127492; Mon,  7 Jan 2019 18:58:09 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, John Hsu <KCHSU0@nuvoton.com>,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: nau8824: fix boolean assignment" to the asoc tree
In-Reply-To:  <20190105020249.8639-16-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185809.69B7D1127492@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: nau8824: fix boolean assignment

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

From 290da7a7e349566f0e1541b14f25b722f58f236b Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:43 -0600
Subject: [PATCH] ASoC: nau8824: fix boolean assignment

Reported by Coccinelle:
nau8824.c:810:6-12: ERROR: Assignment of bool to non-0/1 constant

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8824.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 468d5143e2c4..87ed3dc496dc 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -807,7 +807,7 @@ static const struct snd_soc_dapm_route nau8824_dapm_routes[] = {
 static bool nau8824_is_jack_inserted(struct nau8824 *nau8824)
 {
 	struct snd_soc_jack *jack = nau8824->jack;
-	bool insert = FALSE;
+	bool insert = false;
 
 	if (nau8824->irq && jack)
 		insert = jack->status & SND_JACK_HEADPHONE;
-- 
2.20.1

