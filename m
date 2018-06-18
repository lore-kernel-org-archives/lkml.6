Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FF7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAC1208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Lopu/qVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAC1208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935139AbeFRMDR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:03:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45304 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933572AbeFRMAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DUGPtRxE1TXRhoRsaRpLFCZslJ0I5GcYtvXyNGydM18=; b=Lopu/qVriC7H
        Mh/J84MhJ8oqDsm1nXnUHtPPL0uxpjnvqNMzruQe3MMBOYTIiamVHWub3Pec1I6726PX/a1J2WAwA
        yBZW/8ZBtdhjz+oyt0/Uo1/HZpV9ZyKkjTtg+S+M4EkI82W+VPzQuan/o2IDpmPrvPil0KBAhybnM
        iWPIY=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspJ-0007xZ-U5; Mon, 18 Jun 2018 12:00:06 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspJ-00005s-Fk; Mon, 18 Jun 2018 13:00:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rohit Kumar <rohitkr@codeaurora.org>
Cc:     Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org,
        rohkumar@qti.qualcomm.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Rohit kumar <rohitkr@codeaurora.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qcom: apq8096: set card as device drvdata" to the asoc tree
In-Reply-To:  <1528275324-4878-1-git-send-email-rohitkr@codeaurora.org>
Message-Id: <E1fUspJ-00005s-Fk@debutante>
Date:   Mon, 18 Jun 2018 13:00:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qcom: apq8096: set card as device drvdata

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

From d5c4e972d512ae0b59108ca92b9b35bc5cf5c14e Mon Sep 17 00:00:00 2001
From: Rohit Kumar <rohitkr@codeaurora.org>
Date: Wed, 6 Jun 2018 14:25:24 +0530
Subject: [PATCH] ASoC: qcom: apq8096: set card as device drvdata

snd_soc_card is retrieved as device drvdata during unbind().
Set it as drvdata during bind() to avoid memory corruption during
unbind().

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/apq8096.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 561cd429e6f2..239b8cb77bdb 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -140,6 +140,7 @@ static int apq8096_bind(struct device *dev)
 
 	component_bind_all(dev, card);
 	card->dev = dev;
+	dev_set_drvdata(dev, card);
 	ret = apq8096_sbc_parse_of(card);
 	if (ret) {
 		dev_err(dev, "Error parsing OF data\n");
-- 
2.17.1

