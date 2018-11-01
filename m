Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FD9ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670C62064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670C62064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeKAX5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:57:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50820 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbeKAX5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:57:12 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gIEM4-0000UR-Hg; Thu, 01 Nov 2018 14:53:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc:  clean up indentation issues, remove extraneous space, add missing tabs
Date:   Thu,  1 Nov 2018 14:53:52 +0000
Message-Id: <20181101145352.14104-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to clean up indentation issues, remove spaces, add missing
tabs

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rtc/rtc-ep93xx.c  | 2 +-
 drivers/rtc/rtc-max6916.c | 2 +-
 drivers/rtc/rtc-rk808.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index 694038208745..1932a4f861d1 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -61,7 +61,7 @@ static int ep93xx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct ep93xx_rtc *ep93xx_rtc = dev_get_platdata(dev);
 	unsigned long time;
 
-	 time = readl(ep93xx_rtc->mmio_base + EP93XX_RTC_DATA);
+	time = readl(ep93xx_rtc->mmio_base + EP93XX_RTC_DATA);
 
 	rtc_time_to_tm(time, tm);
 	return 0;
diff --git a/drivers/rtc/rtc-max6916.c b/drivers/rtc/rtc-max6916.c
index 7e908a490cf6..9d4b407cc4b8 100644
--- a/drivers/rtc/rtc-max6916.c
+++ b/drivers/rtc/rtc-max6916.c
@@ -86,7 +86,7 @@ static int max6916_set_time(struct device *dev, struct rtc_time *dt)
 	if (dt->tm_year < 100 || dt->tm_year > 199) {
 		dev_err(&spi->dev, "Year must be between 2000 and 2099. It's %d.\n",
 			dt->tm_year + 1900);
-	return -EINVAL;
+		return -EINVAL;
 	}
 
 	buf[0] = MAX6916_CLOCK_BURST & 0x7F;
diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index 739c0d42e835..b2f9e45e0298 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -400,7 +400,7 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Failed to write RTC status: %d\n", ret);
-			return ret;
+		return ret;
 	}
 
 	device_init_wakeup(&pdev->dev, 1);
-- 
2.19.1

