Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51D6C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F6E205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549124292;
	bh=gqRLv6sMva00aL3UZIu24/OAjdjN1f2q/tYXmFefdGE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Im9wDAlzCVqVCxkxU6DS97gLaTD62YglqJMO4MXSJdVqyT0M890It1SqeeLxMqZnT
	 CO8iyjQVp8H+NEocLqxvrWdAaVNBDnKiX9t5C3epUGyA2DCc9/Fm5r9UQU77DsR9RP
	 mpAuZHHhidjY4oEtrL3cW4qLYNCUX9qWBWDTMIAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfBBQSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:18:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49804 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfBBQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 11:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=83gppFg0UvqU48o4kcbtN3Fe6uo92OYHefho3ugRppY=; b=jhwBQD2q4v65
        jppgbUNYNt+6y/FGPjuLa/0ceGm2Yi/SZWvv8iuLn/aCI2Ys73bOhkzA8cUVn2pUoqLPP/ALcY0RE
        7ITx04rB2ppbcxAyk2hW0OS/qjNowMgUrayQ6peraw50mcU9XseU+/N6i4iZ36zYitLvTRCjD0rts
        aiUc4=;
Received: from [2001:67c:1810:f055:877d:5801:eba7:24a1] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gpxzY-0007cD-9w; Sat, 02 Feb 2019 16:18:04 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A10C5440082; Sat,  2 Feb 2019 16:17:58 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Zhiwei Jiang <qq282012236@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, qq282012236@gmail.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: dapm: Add warnings for widget overwrite when adding route" to the asoc tree
In-Reply-To:  <20190131113005.13380-1-qq282012236@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190202161758.A10C5440082@finisterre.ee.mobilebroadband>
Date:   Sat,  2 Feb 2019 16:17:58 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dapm: Add warnings for widget overwrite when adding route

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

From 411db2ab7df35804422e4b26c5849b3868e6a038 Mon Sep 17 00:00:00 2001
From: Zhiwei Jiang <qq282012236@gmail.com>
Date: Thu, 31 Jan 2019 19:30:05 +0800
Subject: [PATCH] ASoC: dapm: Add warnings for widget overwrite when adding
 route

Currently, in some complex cases, more than one widgets have same
name and registed from differnt dapm context, and route add from
another context too. When snd_soc_dapm_add_route, the previous
registered widget will overwritten by the latest same name widget,
will cause unexpect error. For Asoc framework we cant avoid this
situation and we cant decide which widget that wanted with route.
At least we can give users a notice.

Signed-off-by: Zhiwei Jiang <qq282012236@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 36d964a52874..5b74dffc9c11 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2829,6 +2829,8 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	char prefixed_sink[80];
 	char prefixed_source[80];
 	const char *prefix;
+	unsigned int sink_ref = 0;
+	unsigned int source_ref = 0;
 	int ret;
 
 	prefix = soc_dapm_prefix(dapm);
@@ -2862,6 +2864,11 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 				if (wsource)
 					break;
 			}
+			sink_ref++;
+			if (sink_ref > 1)
+				dev_warn(dapm->dev,
+					"ASoC: sink widget %s overwritten\n",
+					w->name);
 			continue;
 		}
 		if (!wsource && !(strcmp(w->name, source))) {
@@ -2871,6 +2878,11 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 				if (wsink)
 					break;
 			}
+			source_ref++;
+			if (source_ref > 1)
+				dev_warn(dapm->dev,
+					"ASoC: source widget %s overwritten\n",
+					w->name);
 		}
 	}
 	/* use widget from another DAPM context if not found from this */
-- 
2.20.1

