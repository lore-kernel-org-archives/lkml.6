Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B63C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095132190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403905AbeLUXMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 18:12:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58378 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390875AbeLUXMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 18:12:43 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gaTyD-0002Fc-H8; Fri, 21 Dec 2018 23:12:41 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] input: drv2667: fix indentation issues, remove extra tabs
Date:   Fri, 21 Dec 2018 23:12:41 +0000
Message-Id: <20181221231241.15925-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are some statements that are indented incorrectly, fix this by
removinf the extra tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/misc/drv2667.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
index 2849bb6906a8..6091f0490e8f 100644
--- a/drivers/input/misc/drv2667.c
+++ b/drivers/input/misc/drv2667.c
@@ -177,9 +177,9 @@ static int drv2667_set_waveform_freq(struct drv2667_data *haptics)
 		error = regmap_write(haptics->regmap, DRV2667_PAGE, read_buf);
 		if (error) {
 			dev_err(&haptics->client->dev,
-					"Failed to set the page: %d\n", error);
-				return -EIO;
-			}
+				"Failed to set the page: %d\n", error);
+			return -EIO;
+		}
 	}
 
 	return error;
-- 
2.19.1

