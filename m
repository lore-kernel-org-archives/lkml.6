Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937CBC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6166E206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887567;
	bh=mXh8aL59PO8WEfq1Ynh7NcA55PK1ZnifOeahDQ2OtS8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FyEA245pVkL/5I1bHQkXZvH3qNjQ7+3AM9jClyj9kWXmL7rsJkg1UpcPPA7o2X0w6
	 nM7eqEXvRuvN0eLdBbXJ0K4xO3sr5LDefR8M+roBsLpKYUN6ll0DY8GULDbvEyzvBV
	 GLDjbjxqipf+RiRbDKZwgW2n4cCYFgsS7I2mx1Bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfAGS70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:59:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43092 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbfAGS7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=u8W1sekMwJLEm6EyPy+JcHJsSu5ENjswD94T4/osl8A=; b=VO9Tw2yK8C7G
        aTzdrzzPShXG3uVkEHYgOeBTbXhWIljddoqH9b6uK0ot1d8iuJ8sAkwVuTovFZGTncN9PggO6YTmW
        iUlwlVDEWSMNDUtcIKBzqT+JEu5pjw0D6ItB98b7kPhUDnu16GMiQt5cixW2MppVjp3OZd4JWvHtv
        V5S34=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga7J-0007rY-2v; Mon, 07 Jan 2019 18:59:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A15151127491; Mon,  7 Jan 2019 18:59:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cezary Gapinski <cezary.gapinski@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org
Subject: Applied "spi: stm32: use NULL pointer instead of plain integer" to the spi tree
In-Reply-To:  <1545688840-23992-3-git-send-email-cezary.gapinski@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185916.A15151127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:59:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: stm32: use NULL pointer instead of plain integer

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From d4c9134a6c2c85d18b0d58accdf0e9be447f77a3 Mon Sep 17 00:00:00 2001
From: Cezary Gapinski <cezary.gapinski@gmail.com>
Date: Mon, 24 Dec 2018 23:00:28 +0100
Subject: [PATCH] spi: stm32: use NULL pointer instead of plain integer

Patch fixes sparse warning: Using plain integer as NULL pointer. Replaces
second argument of function devm_clk_get from 0 to NULL.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 5f30578a4224..51d7f720127b 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1100,7 +1100,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_master_put;
 	}
 
-	spi->clk = devm_clk_get(&pdev->dev, 0);
+	spi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
 		ret = PTR_ERR(spi->clk);
 		dev_err(&pdev->dev, "clk get failed: %d\n", ret);
-- 
2.20.1

