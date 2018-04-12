Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeDLI6U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 04:58:20 -0400
Received: from m12-15.163.com ([220.181.12.15]:57146 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbeDLI6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 04:58:18 -0400
From: wangbo <wdjjwb@163.com>
To: linux-kernel@vger.kernel.org
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, wang.bo116@zte.com.cn
Subject: [PATCH] spi: imx: Update MODULE_DESCRIPTION to "SPI Controller driver"
Date: Thu, 12 Apr 2018 16:58:08 +0800
Message-Id: <1523523488-22034-1-git-send-email-wdjjwb@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: D8CowAB38f2kH89arXv9OQ--.38264S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1fCr4UKrWruF13Jr47urg_yoW3Wrg_Cr
        18Xr43Gr18Cr9Ik3W2g34fZryavFn8WrnakF1UtFy3X392vw13A3yqvrZ8Z3WUAw48XFsx
        CFs3Gr4rCw43CjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnOtxPUUUUU==
X-Originating-IP: [118.113.201.59]
X-CM-SenderInfo: xzgmy4re6rljoofrz/1tbiTBQmGVSIYn1AGwAAs-
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now i.MX SPI controller can work in Slave mode.
Update MODULE_DESCRIPTION to "SPI Controller driver".

Signed-off-by: wangbo <wang.bo116@zte.com.cn>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6f57592..a056ee8 100644
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
2.7.4
