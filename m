Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0809AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD992082E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfA2JjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:39:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32852 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfA2Jih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:38:37 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 36D642762BA
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org
Subject: [PATCH v3 06/12] platform/chrome: cros_ec_i2c: switch to SPDX identifier
Date:   Tue, 29 Jan 2019 10:38:17 +0100
Message-Id: <20190129093823.27137-7-enric.balletbo@collabora.com>
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
management. Also fix the module license mismatch and change the
description for a more descriptive phrase.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3:
- cros_ec_i2c: Fix SPDX license tag.

Changes in v2: None

 drivers/platform/chrome/cros_ec_i2c.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index 739b985c97e1..419d1b9fa143 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -1,17 +1,7 @@
-/*
- * ChromeOS EC multi-function device (I2C)
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
+// I2C interface for ChromeOS Embedded Controller
+//
+// Copyright (C) 2012 Google, Inc
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
@@ -373,5 +363,5 @@ static struct i2c_driver cros_ec_driver = {
 
 module_i2c_driver(cros_ec_driver);
 
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("ChromeOS EC multi function device");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("I2C interface for ChromeOS Embedded Controller");
-- 
2.20.1

