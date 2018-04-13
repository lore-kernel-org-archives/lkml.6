Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754703AbeDMLZf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:25:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41516 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754120AbeDMLZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:25:33 -0400
From: Mark Brown <broonie@kernel.org>
To: wangbo <wdjjwb@163.com>
Cc: wangbo <wang.bo116@zte.com.cn>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-spi@vger.kernel.org, wang.bo116@zte.com.cn,
        linux-spi@vger.kernel.org
Subject: Applied "spi: imx: Update MODULE_DESCRIPTION to "SPI Controller driver"" to the spi tree
In-Reply-To: <1523523488-22034-1-git-send-email-wdjjwb@163.com>
Message-Id: <E1f6wpb-0000S3-3O@debutante>
Date: Fri, 13 Apr 2018 12:25:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: imx: Update MODULE_DESCRIPTION to "SPI Controller driver"

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

>From af82800cd2d9cfcae2de1b47a35c26c147b9cdd1 Mon Sep 17 00:00:00 2001
From: wangbo <wdjjwb@163.com>
Date: Thu, 12 Apr 2018 16:58:08 +0800
Subject: [PATCH] spi: imx: Update MODULE_DESCRIPTION to "SPI Controller
 driver"

Now i.MX SPI controller can work in Slave mode.
Update MODULE_DESCRIPTION to "SPI Controller driver".

Signed-off-by: wangbo <wang.bo116@zte.com.cn>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6f57592a7f95..a056ee88a960 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1701,7 +1701,7 @@ static struct platform_driver spi_imx_driver = {
 };
 module_platform_driver(spi_imx_driver);
 
-MODULE_DESCRIPTION("SPI Master Controller driver");
+MODULE_DESCRIPTION("SPI Controller driver");
 MODULE_AUTHOR("Sascha Hauer, Pengutronix");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.17.0
