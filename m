Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD4CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E382087E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfAPS4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:56:50 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:62298 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729866AbfAPS4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:56:50 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:a08c:f56:b2dd:7ae0])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id 03DE1B0051E;
        Wed, 16 Jan 2019 19:56:39 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH 5/6] spi: ath79: Remove some useless includes
Date:   Wed, 16 Jan 2019 19:55:48 +0100
Message-Id: <20190116185549.23295-5-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190116185549.23295-1-albeu@free.fr>
References: <20190116185549.23295-1-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several include are not needed, remove them to keep the list clean.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/spi/spi-ath79.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 847f354ebef1..257acfb07819 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -12,15 +12,12 @@
  *
  */
 
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/spinlock.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
-#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/platform_data/spi-ath79.h>
-- 
2.19.1

