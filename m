Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF38C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552B62082E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfA2Ji5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:38:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32856 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbfA2Jij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:38:39 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 33404276423
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org
Subject: [PATCH v3 09/12] platform/chrome: cros_ec_spi: switch to SPDX identifier
Date:   Tue, 29 Jan 2019 10:38:20 +0100
Message-Id: <20190129093823.27137-10-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129093823.27137-1-enric.balletbo@collabora.com>
References: <20190129093823.27137-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management. Also change the description for one more appropriate.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3:
- cros_ec_spi: Fix SPDX license tag.

Changes in v2: None

 drivers/platform/chrome/cros_ec_spi.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 2be41e8afa47..63020d000c3d 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -1,17 +1,7 @@
-/*
- * ChromeOS EC multi-function device (SPI)
- *
- * Copyright (C) 2012 Google, Inc
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+// SPI interface for ChromeOS Embedded Controller
+//
+// Copyright (C) 2012 Google, Inc
 
 #include <linux/delay.h>
 #include <linux/kernel.h>
@@ -730,4 +720,4 @@ static struct spi_driver cros_ec_driver_spi = {
 module_spi_driver(cros_ec_driver_spi);
 
 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("ChromeOS EC multi function device (SPI)");
+MODULE_DESCRIPTION("SPI interface for ChromeOS Embedded Controller");
-- 
2.20.1

