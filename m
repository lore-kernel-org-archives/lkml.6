Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeFEJWV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:22:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47908 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeFEJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:22:19 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>
Subject: [PATCH 1/9] platform/chrome: cros_ec: Switch to SPDX identifier.
Date: Tue,  5 Jun 2018 11:22:01 +0200
Message-Id: <20180605092209.22887-2-enric.balletbo@collabora.com>
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

 drivers/platform/chrome/cros_ec_debugfs.c     | 22 +++-------------
 drivers/platform/chrome/cros_ec_lightbar.c    | 22 +++-------------
 drivers/platform/chrome/cros_ec_lpc.c         | 26 +++----------------
 drivers/platform/chrome/cros_ec_lpc_mec.c     | 26 +++----------------
 drivers/platform/chrome/cros_ec_lpc_reg.c     | 26 +++----------------
 drivers/platform/chrome/cros_ec_proto.c       | 19 +++-----------
 drivers/platform/chrome/cros_ec_sysfs.c       | 22 +++-------------
 drivers/platform/chrome/cros_ec_vbc.c         | 24 ++++-------------
 .../platform/chrome/cros_kbd_led_backlight.c  | 19 +++-----------
 9 files changed, 37 insertions(+), 169 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index c62ee8e610a0..67c62934368a 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -1,21 +1,7 @@
-/*
- * cros_ec_debugfs - debug logs for Chrome OS EC
- *
- * Copyright 2015 Google, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Debug logs for ChromeOS EC.
+//
+// Copyright (C) 2012 Google, Inc.
 
 #include <linux/circ_buf.h>
 #include <linux/debugfs.h>
diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 68193bb53383..c5a6dd4ffa01 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -1,21 +1,7 @@
-/*
- * cros_ec_lightbar - expose the Chromebook Pixel lightbar to userspace
- *
- * Copyright (C) 2014 Google, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Expose the Chromebook Pixel lightbar to userspace.
+//
+// Copyright (C) 2014 Google, Inc.
 
 #define pr_fmt(fmt) "cros_ec_lightbar: " fmt
 
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 3682e1539251..07d3404971cb 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -1,25 +1,7 @@
-/*
- * cros_ec_lpc - LPC access to the Chrome OS Embedded Controller
- *
- * Copyright (C) 2012-2015 Google, Inc
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
+// LPC access to the ChromeOS Embedded Controller.
+//
+// Copyright (C) 2012-2015 Google, Inc.
 
 #include <linux/acpi.h>
 #include <linux/dmi.h>
diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
index 2eda2c2fc210..68c9344ed275 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.c
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
@@ -1,25 +1,7 @@
-/*
- * cros_ec_lpc_mec - LPC variant I/O for Microchip EC
- *
- * Copyright (C) 2016 Google, Inc
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
+// LPC variant I/O for Microchip EC.
+//
+// Copyright (C) 2016 Google, Inc.
 
 #include <linux/delay.h>
 #include <linux/io.h>
diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform/chrome/cros_ec_lpc_reg.c
index dcc7a3e30604..65af9007549a 100644
--- a/drivers/platform/chrome/cros_ec_lpc_reg.c
+++ b/drivers/platform/chrome/cros_ec_lpc_reg.c
@@ -1,25 +1,7 @@
-/*
- * cros_ec_lpc_reg - LPC access to the Chrome OS Embedded Controller
- *
- * Copyright (C) 2016 Google, Inc
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
+// LPC access to the ChromeOS Embedded Controller.
+//
+// Copyright (C) 2016 Google, Inc.
 
 #include <linux/io.h>
 #include <linux/mfd/cros_ec.h>
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 8350ca2311c7..13b925aba61d 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -1,18 +1,7 @@
-/*
- * ChromeOS EC communication protocol helper functions
- *
- * Copyright (C) 2015 Google, Inc
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
- */
+// SPDX-License-Identifier: GPL-2.0+
+// ChromeOS EC communication protocol helper functions.
+//
+// Copyright (C) 2015 Google, Inc.
 
 #include <linux/mfd/cros_ec.h>
 #include <linux/delay.h>
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index f34a50121064..c440f96dbde6 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -1,21 +1,7 @@
-/*
- * cros_ec_sysfs - expose the Chrome OS EC through sysfs
- *
- * Copyright (C) 2014 Google, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Expose the Chrome OS EC through sysfs.
+//
+// Copyright (C) 2014 Google, Inc.
 
 #define pr_fmt(fmt) "cros_ec_sysfs: " fmt
 
diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index 5356f26bc022..a4934f41f462 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -1,22 +1,8 @@
-/*
- * cros_ec_vbc - Expose the vboot context nvram to userspace
- *
- * Copyright (C) 2015 Collabora Ltd.
- *
- * based on vendor driver,
- *
- * Copyright (C) 2012 The Chromium OS Authors
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Expose the vboot context nvram to userspace.
+//
+// Copyright (C) 2012 Google, Inc.
+// Copyright (C) 2015 Collabora Ltd.
 
 #include <linux/of.h>
 #include <linux/platform_device.h>
diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index ca3e4da852b4..bd4aa9331806 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -1,18 +1,7 @@
-/*
- *  Keyboard backlight LED driver for Chrome OS.
- *
- *  Copyright (C) 2012 Google, Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Keyboard backlight LED driver for ChromeOS.
+//
+// Copyright (C) 2012 Google, Inc.
 
 #include <linux/acpi.h>
 #include <linux/leds.h>
-- 
2.17.1
