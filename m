Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF20C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62FC2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="utvybBly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62FC2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbeKNEel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:34:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45272 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730909AbeKNEej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9QuBJTAPsOAgolTfxE37V9Lzx9CK9SU+PkIy38j1Nzs=; b=utvybBlyuzWH
        3wW1A46Z1hsiPjBp5fe9Sh+xTzwaq0ZETi9tEDRhjawkVAuRb7wzOQx3HCJrgh5YmvojEexfimxLw
        kahjlQuGvoK5iQC1+usv60auJYfMn5aJNOGebfKikVEIUdpR6PWlfSkEjIfL438aQpSazyTN71AKQ
        v67Ug=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMdWc-0002Pg-C8; Tue, 13 Nov 2018 18:34:58 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 099FD440079; Tue, 13 Nov 2018 18:34:54 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Pavel Machek <pavel@ucw.cz>, Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: pxa2xx: Add ready signal" to the spi tree
In-Reply-To:  <20181113102228.820214-6-lkundrak@v3.sk>
Message-Id: <20181113183454.099FD440079@finisterre.ee.mobilebroadband>
Date:   Tue, 13 Nov 2018 18:34:53 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: pxa2xx: Add ready signal

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

From 77d33897c68d56797a3201e06bdf10e2094a96d6 Mon Sep 17 00:00:00 2001
From: Lubomir Rintel <lkundrak@v3.sk>
Date: Tue, 13 Nov 2018 11:22:27 +0100
Subject: [PATCH] spi: pxa2xx: Add ready signal

Strobe a GPIO line when the slave TX FIFO is filled. This is how the
Embedded Controller on an OLPC XO-1.75 machine, that happens to be a SPI
master, learns that it can initiate a transaction.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Tested-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 16 +++++++++++++++-
 drivers/spi/spi-pxa2xx.h |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index a057c3be7e3b..69b221e34b2d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1081,6 +1081,11 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 	if (spi_controller_is_slave(master)) {
 		while (drv_data->write(drv_data))
 			;
+		if (drv_data->gpiod_ready) {
+			gpiod_set_value(drv_data->gpiod_ready, 1);
+			udelay(1);
+			gpiod_set_value(drv_data->gpiod_ready, 0);
+		}
 	}
 
 	/*
@@ -1778,7 +1783,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 				if (PTR_ERR(gpiod) == -ENOENT)
 					continue;
 
-				status = (int)PTR_ERR(gpiod);
+				status = PTR_ERR(gpiod);
 				goto out_error_clock_enabled;
 			} else {
 				drv_data->cs_gpiods[i] = gpiod;
@@ -1786,6 +1791,15 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (platform_info->is_slave) {
+		drv_data->gpiod_ready = devm_gpiod_get_optional(dev,
+						"ready", GPIOD_OUT_LOW);
+		if (IS_ERR(drv_data->gpiod_ready)) {
+			status = PTR_ERR(drv_data->gpiod_ready);
+			goto out_error_clock_enabled;
+		}
+	}
+
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 513c53aaeab2..4e324da66ef7 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -64,6 +64,9 @@ struct driver_data {
 
 	/* GPIOs for chip selects */
 	struct gpio_desc **cs_gpiods;
+
+	/* Optional slave FIFO ready signal */
+	struct gpio_desc *gpiod_ready;
 };
 
 struct chip_data {
-- 
2.19.1

