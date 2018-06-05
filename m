Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeFER4J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:56:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50770 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbeFERym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:54:42 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 3/8] mfd: cros_ec: Add or fix SPDX-License-Identifier in all files.
Date: Tue,  5 Jun 2018 19:54:24 +0200
Message-Id: <20180605175429.9072-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605175429.9072-1-enric.balletbo@collabora.com>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And get rid of the license text that is no longer necessary. Also fix
the license as sometimes doesn't match what the header with the value in
the MODULE_LICENSE macro. Assuming that the desired license is GPL-2.0+,
all the files are updated to this license version.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2: None

 drivers/mfd/cros_ec.c                | 26 ++++++++------------------
 drivers/mfd/cros_ec_dev.c            | 23 +++++------------------
 drivers/mfd/cros_ec_dev.h            | 16 ++--------------
 drivers/mfd/cros_ec_i2c.c            | 18 ++++--------------
 drivers/mfd/cros_ec_spi.c            | 20 +++++---------------
 include/linux/mfd/cros_ec.h          | 10 +---------
 include/linux/mfd/cros_ec_commands.h | 10 +---------
 include/linux/mfd/cros_ec_lpc_mec.h  | 14 +++-----------
 include/linux/mfd/cros_ec_lpc_reg.h  | 14 +++-----------
 9 files changed, 32 insertions(+), 119 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 58e05069163e..5b6a1c541543 100644
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
+// SPDX-License-Identifier: GPL-2.0+
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
index ef9b4763356f..5f3a356467df 100644
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
+// SPDX-License-Identifier: GPL-2.0+
+// ChromeOS EC multi-function device (I2C).
+//
+// Copyright (C) 2012 Google, Inc
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
index 2060d1483043..861ea6dcb816 100644
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
+// SPDX-License-Identifier: GPL-2.0+
+// ChromeOS EC multi-function device (SPI).
+//
+// Copyright (C) 2012 Google, Inc
 
 #include <linux/delay.h>
 #include <linux/kernel.h>
@@ -739,5 +729,5 @@ static struct spi_driver cros_ec_driver_spi = {
 
 module_spi_driver(cros_ec_driver_spi);
 
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ChromeOS EC multi function device (SPI)");
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 32421dfeb996..f6ed58166111 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -1,16 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
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
index f2edd9969b40..bf762ae46378 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
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
index 176496ddc66c..ba4204f05172 100644
--- a/include/linux/mfd/cros_ec_lpc_mec.h
+++ b/include/linux/mfd/cros_ec_lpc_mec.h
@@ -1,18 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
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
index 5560bef63c2b..b5a6277cb465 100644
--- a/include/linux/mfd/cros_ec_lpc_reg.h
+++ b/include/linux/mfd/cros_ec_lpc_reg.h
@@ -1,18 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
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
