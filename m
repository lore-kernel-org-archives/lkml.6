Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DFDC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1A02184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfBLNqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:46:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38876 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLNqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:46:18 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gtYO8-00009F-Si; Tue, 12 Feb 2019 13:46:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: max77802-regulator: fix indentation in if statement
Date:   Tue, 12 Feb 2019 13:46:16 +0000
Message-Id: <20190212134616.8270-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several lines in an if statement that are not indented
correctly. Fix these by removing the tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/max77802-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max77802-regulator.c b/drivers/regulator/max77802-regulator.c
index c30cf5c9f2de..ea7b50397300 100644
--- a/drivers/regulator/max77802-regulator.c
+++ b/drivers/regulator/max77802-regulator.c
@@ -248,9 +248,9 @@ static int max77802_set_ramp_delay_2bit(struct regulator_dev *rdev,
 	unsigned int ramp_value;
 
 	if (id > MAX77802_BUCK4) {
-			dev_warn(&rdev->dev,
-				 "%s: regulator: ramp delay not supported\n",
-				 rdev->desc->name);
+		dev_warn(&rdev->dev,
+			 "%s: regulator: ramp delay not supported\n",
+			 rdev->desc->name);
 		return -EINVAL;
 	}
 	ramp_value = max77802_find_ramp_value(rdev, ramp_table_77802_2bit,
-- 
2.20.1

