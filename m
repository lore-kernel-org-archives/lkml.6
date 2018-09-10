Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9DBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331CB20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDXX6LfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331CB20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbeIJWA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbeIJWA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:00:27 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB722075A;
        Mon, 10 Sep 2018 17:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536599125;
        bh=84c0BPwjb653s9n1XQKhY3AeU+MhXPM+WTk1Ec/BsPE=;
        h=From:To:Subject:Date:From;
        b=EDXX6LfUXD2psbRC+LaMfZK4rZOmzg/0vO3sybic+2o7EKzTzmL7o6Pb+gwBtvA7Y
         b4Kjvy3KyhRveLl+7dGjolarktMwjLcOILNRgzAxGmBP/e4aNhYVdRGcZPwZ1/1GM9
         KMTXD2+sk+AE+7egvaAev1MJU8ihhKZIWsAi7BYc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: s3c24xx: Consistently use tab for indenting member assignments
Date:   Mon, 10 Sep 2018 19:05:01 +0200
Message-Id: <20180910170501.14190-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code was mixing spaces and tabs for indenting members in structures.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 4a0bf6abba8c..925ff1b3198e 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -70,25 +70,25 @@ static struct map_desc mini2440_iodesc[] __initdata = {
 
 static struct s3c2410_uartcfg mini2440_uartcfgs[] __initdata = {
 	[0] = {
-		.hwport	     = 0,
-		.flags	     = 0,
-		.ucon	     = UCON,
-		.ulcon	     = ULCON,
-		.ufcon	     = UFCON,
+		.hwport		= 0,
+		.flags		= 0,
+		.ucon		= UCON,
+		.ulcon		= ULCON,
+		.ufcon		= UFCON,
 	},
 	[1] = {
-		.hwport	     = 1,
-		.flags	     = 0,
-		.ucon	     = UCON,
-		.ulcon	     = ULCON,
-		.ufcon	     = UFCON,
+		.hwport		= 1,
+		.flag		= 0,
+		.ucon		= UCON,
+		.ulcon		= ULCON,
+		.ufcon		= UFCON,
 	},
 	[2] = {
-		.hwport	     = 2,
-		.flags	     = 0,
-		.ucon	     = UCON,
-		.ulcon	     = ULCON,
-		.ufcon	     = UFCON,
+		.hwport		= 2,
+		.flags		= 0,
+		.ucon		= UCON,
+		.ulcon		= ULCON,
+		.ufcon		= UFCON,
 	},
 };
 
@@ -234,10 +234,10 @@ static struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
 /* MMC/SD  */
 
 static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
-	.gpio_detect   = S3C2410_GPG(8),
-	.gpio_wprotect = S3C2410_GPH(8),
-	.set_power     = NULL,
-	.ocr_avail     = MMC_VDD_32_33|MMC_VDD_33_34,
+	.gpio_detect	= S3C2410_GPG(8),
+	.gpio_wprotect	= S3C2410_GPH(8),
+	.set_power	= NULL,
+	.ocr_avail	= MMC_VDD_32_33|MMC_VDD_33_34,
 };
 
 /* NAND Flash on MINI2440 board */
@@ -285,7 +285,7 @@ static struct s3c2410_platform_nand mini2440_nand_info __initdata = {
 	.nr_sets	= ARRAY_SIZE(mini2440_nand_sets),
 	.sets		= mini2440_nand_sets,
 	.ignore_unset_ecc = 1,
-	.ecc_mode       = NAND_ECC_HW,
+	.ecc_mode	= NAND_ECC_HW,
 };
 
 /* DM9000AEP 10/100 ethernet controller */
-- 
2.14.1

