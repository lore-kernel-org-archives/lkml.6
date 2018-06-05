Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeFEJXh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:23:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47944 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeFEJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:22:22 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: [PATCH 5/9] rtc: cros-ec: Switch to SPDX identifier.
Date: Tue,  5 Jun 2018 11:22:05 +0200
Message-Id: <20180605092209.22887-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605092209.22887-1-enric.balletbo@collabora.com>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/rtc/rtc-cros-ec.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index bf7ced095c94..e42e863b203a 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -1,19 +1,8 @@
-/*
- * RTC driver for Chrome OS Embedded Controller
- *
- * Copyright (c) 2017, Google, Inc
- *
- * Author: Stephen Barber <smbarber@chromium.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// RTC driver for ChromeOS Embedded Controller.
+//
+// Copyright (C) 2017 Google, Inc.
+// Author: Stephen Barber <smbarber@chromium.org>
 
 #include <linux/kernel.h>
 #include <linux/mfd/cros_ec.h>
-- 
2.17.1
