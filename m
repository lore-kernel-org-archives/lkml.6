Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7701BC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2772176D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="lNVEf+2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2772176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeHHN12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:27:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35304 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeHHN11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=k4rWto0uhQkeKlIdPkU5QI1E3/ekVI2f76hdqaO2M5w=; b=lNVEf+2UnQyp
        xQqyKPGYLmP9ZdqAbxvApRgXsOOx+9g07aky25VDFGWEtzFvFa86+qdBhnT0SjPCZLC8k4i44c+Xi
        JG7Ju/ScHj2cruhS113oMIukNcMLJ/QmZoM4gbklGJ+xZO/gm5GjxvI8j+qTBsL4/1IJQ+Av1X9pN
        kt+Ws=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fnMJv-0001t5-CO; Wed, 08 Aug 2018 11:08:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1F0861124340; Wed,  8 Aug 2018 12:08:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: rt5677: Fix initialization of rt5677_of_match.data" to the asoc tree
In-Reply-To:  <20180807171940.150507-1-mka@chromium.org>
Message-Id: <20180808110803.1F0861124340@debutante.sirena.org.uk>
Date:   Wed,  8 Aug 2018 12:08:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5677: Fix initialization of rt5677_of_match.data

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

From f861e3e28a3016a2064d9f600eaa92a530b732b4 Mon Sep 17 00:00:00 2001
From: Matthias Kaehlcke <mka@chromium.org>
Date: Tue, 7 Aug 2018 10:19:40 -0700
Subject: [PATCH] ASoC: rt5677: Fix initialization of rt5677_of_match.data

The driver expects to find the device id in rt5677_of_match.data, however
it is currently assigned to rt5677_of_match.type. Fix this.

The problem was found with the help of clang:
  sound/soc/codecs/rt5677.c:5010:36: warning: expression which evaluates to
  zero treated as a null pointer constant of type 'const void *'
  [-Wnon-literal-null-conversion]
    { .compatible = "realtek,rt5677", RT5677 },
                                      ^~~~~~

Fixes: ddc9e69b9dc2 ("ASoC: rt5677: Hide platform data in the module sources")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 922becfee59b..9b7a1833d331 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5008,7 +5008,7 @@ static const struct regmap_config rt5677_regmap = {
 };
 
 static const struct of_device_id rt5677_of_match[] = {
-	{ .compatible = "realtek,rt5677", RT5677 },
+	{ .compatible = "realtek,rt5677", .data = (const void *)RT5677 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rt5677_of_match);
-- 
2.18.0

