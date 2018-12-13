Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71EDC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96ABE20892
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544724702;
	bh=yYLEz/McrqUB/CSJCkzJ+8T65A+P8EBp9FJ+Czd0th4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BCdeRx3gW1SuHuy0AVbEkRlz9VwJCV/Y9lCLEGn3K6esqzsrvQ98NI6t0DEdj3MjN
	 pB9CLMD3bJb7R8cdmQJIEzEfFWLkb/SWx8KuLjhnVWlNf9ceIZjlGjaoAzVvC7oEGj
	 eGhcErmeKQLMuogm2Q1xBXl6p5LZ88ggcJ8Ssw5A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96ABE20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbeLMSLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:11:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37536 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbeLMSLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=F4yZQ/CuYY/V7fbr42YvQNaYWJDMYOu7oTPHvOCOGuo=; b=bT0dQujkVieF
        eDms9Jm1tNQ/CoNPaGlp0vwMUT0D0OLn+eyVxHz0cUbTjdogZ/7AG40jKiO1/8T9SH4Do8vaQ7q5y
        G3kvfgT1MANv296EDcHNdKqlpQEA0CVJOoFdVlhcD6PsRTenCZb9DVkgISvRgRptpa4c6qQlsamt3
        8C+gM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVSP-0002Qs-4n; Thu, 13 Dec 2018 18:11:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C620D11254D1; Thu, 13 Dec 2018 18:11:32 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Priit Laes <plaes@plaes.org>, Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "mfd: axp20x: use explicit bit defines" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181213181132.C620D11254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 18:11:32 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   mfd: axp20x: use explicit bit defines

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 82b4d99725aedc3de731faa4e23f256fbe2821cf Mon Sep 17 00:00:00 2001
From: Olliver Schinagl <oliver@schinagl.nl>
Date: Tue, 11 Dec 2018 17:17:12 +0200
Subject: [PATCH] mfd: axp20x: use explicit bit defines

The AXP20X_OFF define is an actual specific bit, define it as such.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index da54399dc7b3..e1450a56fc07 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -30,7 +30,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
-#define AXP20X_OFF	0x80
+#define AXP20X_OFF	BIT(7)
 
 #define AXP806_REG_ADDR_EXT_ADDR_MASTER_MODE	0
 #define AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE	BIT(4)
-- 
2.19.0.rc2

