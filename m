Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD0AC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EBD21A0E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DjYWZ1to"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EBD21A0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbeHFN7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:59:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45644 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbeHFN7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=6aiKdaLUWCNwAfYYBewYgoALq0Iajs/6reqXQV8SWhk=; b=DjYWZ1toLxIW
        CYEegyX3Bj/E7FrIL81GGh70iu9PPcDlixY0U9fxnAz7wUG54ftL15/3tbIHj1zD9MSrecCSbLiCy
        psdOq9LXJRXq2yHnHk4NqfVHBNVccyNaluVFrScvVpsvW3hbCf+L5oit0Ul1w0TJEXqBnY4jMg1v8
        vcyNw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fme1x-0007rq-9o; Mon, 06 Aug 2018 11:50:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1171F1124240; Mon,  6 Aug 2018 12:50:33 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        tiwai@suse.com, vkoul@kernel.org, rohitkr@codeaurora.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qcom: remove unused header files from common.h" to the asoc tree
In-Reply-To:  <20180806101209.15167-5-srinivas.kandagatla@linaro.org>
Message-Id: <20180806115033.1171F1124240@debutante.sirena.org.uk>
Date:   Mon,  6 Aug 2018 12:50:33 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qcom: remove unused header files from common.h

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

From d72117d0c89a3f5657ef91d5eef31337964e3cb2 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 6 Aug 2018 11:12:08 +0100
Subject: [PATCH] ASoC: qcom: remove unused header files from common.h

This patch removes unused header files from common.h.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/common.h b/sound/soc/qcom/common.h
index ad5d2cf27459..f05c05b12bd7 100644
--- a/sound/soc/qcom/common.h
+++ b/sound/soc/qcom/common.h
@@ -4,7 +4,6 @@
 #ifndef __QCOM_SND_COMMON_H__
 #define __QCOM_SND_COMMON_H__
 
-#include <linux/component.h>
 #include <sound/soc.h>
 
 int qcom_snd_parse_of(struct snd_soc_card *card);
-- 
2.18.0

