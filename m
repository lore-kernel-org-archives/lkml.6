Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B84C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26807213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26807213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbeJLXKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:10:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47191 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbeJLXKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:10:20 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gAzV8-0005lb-1g; Fri, 12 Oct 2018 15:37:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: em28xx: fix spelling mistake, "Cinnergy" -> "Cinergy"
Date:   Fri, 12 Oct 2018 16:37:17 +0100
Message-Id: <20181012153717.22252-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Fix name of the Hybrid T USB XS em28xx card, should be Cinergy.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 Documentation/media/v4l-drivers/em28xx-cardlist.rst | 2 +-
 drivers/media/usb/em28xx/em28xx-cards.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/media/v4l-drivers/em28xx-cardlist.rst b/Documentation/media/v4l-drivers/em28xx-cardlist.rst
index dfe882ca945f..4332da0ac8da 100644
--- a/Documentation/media/v4l-drivers/em28xx-cardlist.rst
+++ b/Documentation/media/v4l-drivers/em28xx-cardlist.rst
@@ -233,7 +233,7 @@ EM28xx cards list
      - em2882
      - eb1a:e323
    * - 55
-     - Terratec Cinnergy Hybrid T USB XS (em2882)
+     - Terratec Cinergy Hybrid T USB XS (em2882)
      - em2882
      - 0ccd:005e, 0ccd:0042
    * - 56
diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index 87b887b7604e..1283c7ca9ad5 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -1958,7 +1958,7 @@ const struct em28xx_board em28xx_boards[] = {
 		} },
 	},
 	[EM2882_BOARD_TERRATEC_HYBRID_XS] = {
-		.name         = "Terratec Cinnergy Hybrid T USB XS (em2882)",
+		.name         = "Terratec Cinergy Hybrid T USB XS (em2882)",
 		.tuner_type   = TUNER_XC2028,
 		.tuner_gpio   = default_tuner_gpio,
 		.mts_firmware = 1,
-- 
2.17.1

