Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FC51601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeFFPJO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:09:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56832 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752443AbeFFPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:09:12 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 04/12] mfd: cros_ec: Switch to SPDX identifier.
Date: Wed,  6 Jun 2018 17:08:52 +0200
Message-Id: <20180606150900.8342-5-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180606150900.8342-1-enric.balletbo@collabora.com>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mfd/cros_ec.c                | 26 ++++++++------------------
 drivers/mfd/cros_ec_dev.c            | 23 +++++------------------
 drivers/mfd/cros_ec_dev.h            | 16 ++--------------
 drivers/mfd/cros_ec_i2c.c            | 18 ++++--------------
 drivers/mfd/cros_ec_spi.c            | 18 ++++--------------
 include/linux/mfd/cros_ec.h          | 10 +---------
 include/linux/mfd/cros_ec_commands.h | 10 +---------
 include/linux/mfd/cros_ec_lpc_mec.h  | 14 +++-----------
 include/linux/mfd/cros_ec_lpc_reg.h  | 14 +++-----------
 9 files changed, 31 insertions(+), 118 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 0da7c785cb18..3b564a00bee5 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -1,21 +1,11 @@
-/*
- * ChromeOS EC multi-function device
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
- * The ChromeOS EC multi function device is used to mux all the requests
- * to the EC device for its multiple features: keyboard controller,
- * battery charging and regulator control, firmware update.
- */
+// SPDX-License-Identifier: GPL-2.0
+// ChromeOS EC multi-function device.
+//
+// Copyright (C) 2012 Google, Inc
+//
+// The ChromeOS EC multi function device is used to mux all the requests
+// to the EC device for its multiple features: keyboard controller,
+// battery charging and regulator control, firmware update.
 
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index d37c79426c87..0ce7be132a09 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -1,21 +1,8 @@
-/*
- * cros_ec_dev - expose the Chrome OS Embedded Controller to user-space
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
+// Expose the ChromeOS Embedded Controller to user-space.
+//
+// Copyright (C) 2014 Google, Inc.
+// Author: Bill Richardson <wfrichar@chromium.org>
 
 #include <linux/fs.h>
 #include <linux/mfd/core.h>
diff --git a/drivers/mfd/cros_ec_dev.h b/drivers/mfd/cros_ec_dev.h
index 45e9453608c5..a63cf80234c7 100644
--- a/drivers/mfd/cros_ec_dev.h
+++ b/drivers/mfd/cros_ec_dev.h
@@ -1,20 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * cros_ec_dev - expose the Chrome OS Embedded Controller to userspace
+ * Expose the ChromeOS Embedded Controller to userspace
  *
  * Copyright (C) 2014 Google, Inc.
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
  */
 
 #ifndef _CROS_EC_DEV_H_
diff --git a/drivers/mfd/cros_ec_i2c.c b/drivers/mfd/cros_ec_i2c.c
index 606157076e7f..689635b81f6a 100644
--- a/drivers/mfd/cros_ec_i2c.c
+++ b/drivers/mfd/cros_ec_i2c.c
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
+// ChromeOS EC multi-function device (I2C).
+//
+// Copyright (C) 2012 Google, Inc
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
index 2060d1483043..dcb9b2cf2db5 100644
--- a/drivers/mfd/cros_ec_spi.c
+++ b/drivers/mfd/cros_ec_spi.c
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
+// ChromeOS EC multi-function device (SPI).
+//
+// Copyright (C) 2012 Google, Inc
 
 #include <linux/delay.h>
 #include <linux/kernel.h>
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 32421dfeb996..57995418c305 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -1,16 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * ChromeOS EC multi-function device
  *
  * Copyright (C) 2012 Google, Inc
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __LINUX_MFD_CROS_EC_H
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index f2edd9969b40..007f9ded445c 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Host communication command constants for ChromeOS EC
  *
  * Copyright (C) 2012 Google, Inc
  *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * The ChromeOS EC multi function device is used to mux all the requests
  * to the EC device for its multiple features: keyboard controller,
  * battery charging and regulator control, firmware update.
diff --git a/include/linux/mfd/cros_ec_lpc_mec.h b/include/linux/mfd/cros_ec_lpc_mec.h
index 176496ddc66c..0badd24ab4b5 100644
--- a/include/linux/mfd/cros_ec_lpc_mec.h
+++ b/include/linux/mfd/cros_ec_lpc_mec.h
@@ -1,18 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * cros_ec_lpc_mec - LPC variant I/O for Microchip EC
+ * LPC variant I/O for Microchip EC
  *
  * Copyright (C) 2016 Google, Inc
  *
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
+ * This driver uses the ChromeOS EC byte-level message-based protocol for
  * communicating the keyboard state (which keys are pressed) from a keyboard EC
  * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
  * but everything else (including deghosting) is done here.  The main
diff --git a/include/linux/mfd/cros_ec_lpc_reg.h b/include/linux/mfd/cros_ec_lpc_reg.h
index 5560bef63c2b..011071b87457 100644
--- a/include/linux/mfd/cros_ec_lpc_reg.h
+++ b/include/linux/mfd/cros_ec_lpc_reg.h
@@ -1,18 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * cros_ec_lpc_reg - LPC access to the Chrome OS Embedded Controller
+ * LPC register access to the ChromeOS Embedded Controller
  *
  * Copyright (C) 2016 Google, Inc
  *
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
+ * This driver uses the ChromeOS EC byte-level message-based protocol for
  * communicating the keyboard state (which keys are pressed) from a keyboard EC
  * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
  * but everything else (including deghosting) is done here.  The main
-- 
2.17.1
