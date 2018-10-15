Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A94AC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6175D2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="PysS4s0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6175D2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeJOTG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:06:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37946 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeJOTG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=k0zqiqK287VUIzeO1OetnnOW7/3VYKnpUrV9JToR+hw=; b=PysS4s0/id4/
        fm/k8p2ulhwH5R3ThTCh/Ok9RZIjBvTXoRfc+TkWLTHnjpGfnyXj0Lnsc1rN1c1GLpMGZs5JOwVBz
        C9zfpa48wC8KOHh4BnZwrSrpyBgiaVlY3fN+2DZ41zUutsWQ462hGO++oICyWP9B56Kal6ZEQ/fwU
        ecC9A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gC0wa-000363-AN; Mon, 15 Oct 2018 11:21:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0EDB611224A9; Mon, 15 Oct 2018 12:21:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        akshu.agrawal@amd.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: AMD: Add SND_JACK_LINEOUT jack type" to the asoc tree
In-Reply-To:  <1539586502-12516-1-git-send-email-akshu.agrawal@amd.com>
Message-Id: <20181015112152.0EDB611224A9@debutante.sirena.org.uk>
Date:   Mon, 15 Oct 2018 12:21:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Add SND_JACK_LINEOUT jack type

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

From 2657c6a9037df1c98eb5dae10dd554ac8c37d38f Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Mon, 15 Oct 2018 12:24:44 +0530
Subject: [PATCH] ASoC: AMD: Add SND_JACK_LINEOUT jack type

Some 3 pole connectors report impedance greater than threshold of
1000Ohm. Thus, da7219 reports them as LINEOUT.
Adding the SND_JACK_LINEOUT type so that we don't fail to detect
any 3 pole jack type.
Also, changing
SND_JACK_HEADPHONE | SND_JACK_MICROPHONE -> SND_JACK_HEADSET

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 717a017f0db6..3f813ea5210a 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -75,7 +75,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	da7219_dai_clk = clk_get(component->dev, "da7219-dai-clks");
 
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+				SND_JACK_HEADSET | SND_JACK_LINEOUT |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				SND_JACK_BTN_2 | SND_JACK_BTN_3,
 				&cz_jack, NULL, 0);
-- 
2.19.0.rc2

