Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbeFERyw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:54:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50770 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753311AbeFERyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:54:43 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH v2 5/8] Input: cros_ec_keyb - Switch to SPDX identifier.
Date: Tue,  5 Jun 2018 19:54:26 +0200
Message-Id: <20180605175429.9072-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605175429.9072-1-enric.balletbo@collabora.com>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2:
- [6/9] Do not remove last paragraph.

 drivers/input/keyboard/cros_ec_keyb.c | 34 ++++++++++-----------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 79eb29550c34..91b2839c12df 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -1,25 +1,15 @@
-/*
- * ChromeOS EC keyboard driver
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
- *
- * This driver uses the Chrome OS EC byte-level message-based protocol for
- * communicating the keyboard state (which keys are pressed) from a keyboard EC
- * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
- * but everything else (including deghosting) is done here.  The main
- * motivation for this is to keep the EC firmware as simple as possible, since
- * it cannot be easily upgraded and EC flash/IRAM space is relatively
- * expensive.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// ChromeOS EC keyboard driver
+//
+// Copyright (C) 2012 Google, Inc.
+//
+// This driver uses the ChromeOS EC byte-level message-based protocol for
+// communicating the keyboard state (which keys are pressed) from a keyboard EC
+// to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
+// but everything else (including deghosting) is done here.  The main
+// motivation for this is to keep the EC firmware as simple as possible, since
+// it cannot be easily upgraded and EC flash/IRAM space is relatively
+// expensive.
 
 #include <linux/module.h>
 #include <linux/bitops.h>
-- 
2.17.1
