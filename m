Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF325C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BD42146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661241;
	bh=4qgr4zUsOZb4znSqbXlDvGZqQMxNjZUjRJl2TPTgBRs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Od1ChsfuP9hnyK0inHGQLslLLuwqyqbN0yuBAG6oIZKNvrWg68k8YAwTDm7wSvG8u
	 mXONQiBpN8W6N3JXSsxIJlbbcfF1tiD2/+3t1mgzbAUIzUhplVw0Z8frSTVwhWG3eN
	 ePn/nWYFHEWwDcBy+L5Lxe+M4gTgiLhu8pLjiobQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfBTLOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:14:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45476 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfBTLN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hzqJS3OteXZ1S1jtyRNULW0VKRVCxBcTd8t2RdqvV0c=; b=Z5ETXcrvd7IM
        1RHP8aHKcGqPUP+fwAQ5DOiKt3yN9DCfxf3z+chYlIPnR04FnHt0WDJ/9iAWc9/OeGw7knfL0Tvez
        8flyptggIJpncwEMWXjXBHgDHJKxhFrYGl8s+MeXrnEgcEERCuQ3rrXGPEx5VxXb2P4HIjxiMs+aZ
        JjaEM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwPon-000122-3A; Wed, 20 Feb 2019 11:13:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 58B6A11284BD; Tue, 19 Feb 2019 15:50:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Bogdan Togorean <bogdan.togorean@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, lars@metafoo.de,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, tiwai@suse.com, broonie@kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: adau1977: Add support for setting MICBIAS via DT" to the asoc tree
In-Reply-To:  <20190219141139.24216-3-bogdan.togorean@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190219155018.58B6A11284BD@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 15:50:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: adau1977: Add support for setting MICBIAS via DT

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

From 65d257ee12860340947bbc336243b4a9a5d721df Mon Sep 17 00:00:00 2001
From: Bogdan Togorean <bogdan.togorean@gmail.com>
Date: Tue, 19 Feb 2019 16:11:39 +0200
Subject: [PATCH] ASoC: adau1977: Add support for setting MICBIAS via DT

If platform_data is NULL add reading of optional adi,micbias
property from DT. If adi,micbias is not set keep the default
value for micbias.

Signed-off-by: Bogdan Togorean <bogdan.togorean@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1977.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index 116af6a9ce3b..11c53bcb71dd 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -885,13 +885,15 @@ static int adau1977_setup_micbias(struct adau1977 *adau1977)
 	struct adau1977_platform_data *pdata = adau1977->dev->platform_data;
 	unsigned int micbias;
 
-	if (pdata) {
+	if (pdata)
 		micbias = pdata->micbias;
-		if (micbias > ADAU1977_MICBIAS_9V0)
-			return -EINVAL;
-
-	} else {
+	else if (device_property_read_u32(adau1977->dev, "adi,micbias",
+					  &micbias))
 		micbias = ADAU1977_MICBIAS_8V5;
+
+	if (micbias > ADAU1977_MICBIAS_9V0) {
+		dev_err(adau1977->dev, "Invalid value for 'adi,micbias'\n");
+		return -EINVAL;
 	}
 
 	return regmap_update_bits(adau1977->regmap, ADAU1977_REG_MICBIAS,
-- 
2.20.1

