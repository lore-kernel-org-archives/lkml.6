Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeEUJRE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:17:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39311 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeEUJQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:16:59 -0400
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: fix spelling mistake: "Freeacale" -> "Freescale"
Date: Mon, 21 May 2018 10:16:54 +0100
Message-Id: <20180521091654.17989-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in module description text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/adc/imx7d_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index cfab31162845..ad6764fb2a23 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -604,5 +604,5 @@ static struct platform_driver imx7d_adc_driver = {
 module_platform_driver(imx7d_adc_driver);
 
 MODULE_AUTHOR("Haibo Chen <haibo.chen@freescale.com>");
-MODULE_DESCRIPTION("Freeacale IMX7D ADC driver");
+MODULE_DESCRIPTION("Freescale IMX7D ADC driver");
 MODULE_LICENSE("GPL v2");
-- 
2.17.0
