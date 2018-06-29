Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F314C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBA527070
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBA527070
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936842AbeF2P5n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:57:43 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:23538 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934265AbeF2P5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:57:42 -0400
X-Greylist: delayed 2214 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jun 2018 11:57:42 EDT
Received: from bsmtp7.bon.at (unknown [192.168.181.106])
        by bsmtp8.bon.at (Postfix) with ESMTPS id 41HL284cxwz5v6W
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:20:48 +0200 (CEST)
Received: from rdostal-desktop.sue.net (vpn.streamunlimited.com [91.114.0.140])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41HL2617j9z5tlP;
        Fri, 29 Jun 2018 17:20:46 +0200 (CEST)
From:   =?UTF-8?q?Radek=20Dost=C3=A1l?= <radek.dostal@streamunlimited.com>
To:     thomas.petazzoni@free-electrons.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radek=20Dost=C3=A1l?= <radek.dostal@streamunlimited.com>
Subject: [PATCH] staging: fbtft: fix line indent
Date:   Fri, 29 Jun 2018 17:20:32 +0200
Message-Id: <1530285632-13967-1-git-send-email-radek.dostal@streamunlimited.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Radek Dostál <radek.dostal@streamunlimited.com>
---
 drivers/staging/fbtft/fbtft_device.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft_device.c b/drivers/staging/fbtft/fbtft_device.c
index 4a54b46..cad244c 100644
--- a/drivers/staging/fbtft/fbtft_device.c
+++ b/drivers/staging/fbtft/fbtft_device.c
@@ -1232,14 +1232,14 @@ static struct fbtft_device_display displays[] = {
 			.name = "",
 			.id = 0,
 			.dev = {
-			.release = fbtft_device_pdev_release,
-			.platform_data = &(struct fbtft_platform_data) {
-				.gpios = (const struct fbtft_gpio []) {
-					{},
+				.release = fbtft_device_pdev_release,
+				.platform_data = &(struct fbtft_platform_data) {
+					.gpios = (const struct fbtft_gpio []) {
+						{},
+					},
 				},
 			},
 		},
-		},
 	}
 };
 
-- 
2.7.4

