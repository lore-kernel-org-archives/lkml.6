Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E09C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CEB20880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761161;
	bh=v4hN8c05nwRcSY7U6xL94LZA30KN67DFw1PZLzBQdMQ=;
	h=From:To:Subject:Date:List-ID:From;
	b=tbFfxX0PuYF6xX3+UfgQJyPEd8bUmVhbX86/0vJDNxLT/lPo7hCANfNJ/G/TpqiFK
	 r+KAw3pUnjxSJWTIc6hjEGhd78/QTjvhcqEC5KCZpaTWwm7n/PgkA8TNo4ca8YgTi+
	 aA9iatZZ/yBh3eSH4SuDYmudGowWVr+Rxct985yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfA2LZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:25:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfA2LZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:25:59 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB45520880;
        Tue, 29 Jan 2019 11:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761158;
        bh=v4hN8c05nwRcSY7U6xL94LZA30KN67DFw1PZLzBQdMQ=;
        h=From:To:Subject:Date:From;
        b=ouegjwgrNgxDKqfSe38VOnvtmUScPz9SEBtbn+PvDr47KLecX9FQH0dCagQSv6r/d
         TTbE0P6rjdb3refA58KsdpM1qEOBDRdP14WYs6yJXB7NgK5a6PeToR5ztqQfQ7kQ0l
         hZxu7sIBjuaSJ4wbenB2qwRyhHCJxAvm+ELnhzd0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/2] mfd: sec-core: Cleanup formatting to a consistent style
Date:   Tue, 29 Jan 2019 12:25:52 +0100
Message-Id: <1548761153-28114-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the formatting to have consistent style across the file (only
white-space issues).  No expected difference in code.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/sec-core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index e0835c9df7a1..c3bb53f79e63 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -70,9 +70,11 @@ static const struct mfd_cell s2mps11_devs[] = {
 };
 
 static const struct mfd_cell s2mps13_devs[] = {
-	{ .name = "s2mps13-regulator", },
-	{ .name = "s2mps13-rtc", },
 	{
+		.name = "s2mps13-regulator",
+	}, {
+		.name = "s2mps13-rtc",
+	}, {
 		.name = "s2mps13-clk",
 		.of_compatible = "samsung,s2mps13-clk",
 	},
@@ -114,7 +116,8 @@ static const struct mfd_cell s2mpu02_devs[] = {
 
 #ifdef CONFIG_OF
 static const struct of_device_id sec_dt_match[] = {
-	{	.compatible = "samsung,s5m8767-pmic",
+	{
+		.compatible = "samsung,s5m8767-pmic",
 		.data = (void *)S5M8767X,
 	}, {
 		.compatible = "samsung,s2mps11-pmic",
@@ -309,8 +312,8 @@ static void sec_pmic_configure(struct sec_pmic_dev *sec_pmic)
  * the sub-modules need not instantiate another instance while parsing their
  * platform data.
  */
-static struct sec_platform_data *sec_pmic_i2c_parse_dt_pdata(
-					struct device *dev)
+static struct sec_platform_data *
+sec_pmic_i2c_parse_dt_pdata(struct device *dev)
 {
 	struct sec_platform_data *pd;
 
@@ -331,8 +334,8 @@ static struct sec_platform_data *sec_pmic_i2c_parse_dt_pdata(
 	return pd;
 }
 #else
-static struct sec_platform_data *sec_pmic_i2c_parse_dt_pdata(
-					struct device *dev)
+static struct sec_platform_data *
+sec_pmic_i2c_parse_dt_pdata(struct device *dev)
 {
 	return NULL;
 }
-- 
2.7.4

