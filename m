Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeEGRwn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:52:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49016 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbeEGRwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:52:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4806F6022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH] drivers: thermal: Update license to SPDX format
Date: Mon,  7 May 2018 11:52:29 -0600
Message-Id: <20180507175229.864-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update licences format for core thermal files.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/thermal/of-thermal.c      | 19 +------------------
 drivers/thermal/thermal_core.c    |  5 +----
 drivers/thermal/thermal_core.h    | 17 +----------------
 drivers/thermal/thermal_helpers.c |  5 +----
 drivers/thermal/thermal_hwmon.c   | 17 +----------------
 drivers/thermal/thermal_hwmon.h   | 17 +----------------
 drivers/thermal/thermal_sysfs.c   |  5 +----
 include/linux/thermal.h           | 17 +----------------
 8 files changed, 8 insertions(+), 94 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index e09f0354a4bc..eea2fce82bf7 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -1,26 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  of-thermal.c - Generic Thermal Management device tree support.
  *
  *  Copyright (C) 2013 Texas Instruments
  *  Copyright (C) 2013 Eduardo Valentin <eduardo.valentin@ti.com>
- *
- *
- *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <linux/thermal.h>
 #include <linux/slab.h>
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d64325e078db..589925ac0994 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  thermal.c - Generic Thermal Management Sysfs support.
  *
  *  Copyright (C) 2008 Intel Corp
  *  Copyright (C) 2008 Zhang Rui <rui.zhang@intel.com>
  *  Copyright (C) 2008 Sujith Thomas <sujith.thomas@intel.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 5e4150261500..7f8ace4c0142 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -1,24 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  thermal_core.h
  *
  *  Copyright (C) 2012  Intel Corp
  *  Author: Durgadoss R <durgadoss.r@intel.com>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
 #ifndef __THERMAL_CORE_H__
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index eb03d7e099bb..2ba756af76b7 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  thermal_helpers.c - helper functions to handle thermal devices
  *
@@ -7,10 +8,6 @@
  *  Copyright (C) 2008 Intel Corp
  *  Copyright (C) 2008 Zhang Rui <rui.zhang@intel.com>
  *  Copyright (C) 2008 Sujith Thomas <sujith.thomas@intel.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index c4a508a124dc..11278836ed12 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  thermal_hwmon.c - Generic Thermal Management hwmon support.
  *
@@ -8,22 +9,6 @@
  *
  *  Copyright (C) 2013 Texas Instruments
  *  Copyright (C) 2013 Eduardo Valentin <eduardo.valentin@ti.com>
- *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <linux/hwmon.h>
 #include <linux/thermal.h>
diff --git a/drivers/thermal/thermal_hwmon.h b/drivers/thermal/thermal_hwmon.h
index c798fdb2ae43..019f6f88224e 100644
--- a/drivers/thermal/thermal_hwmon.h
+++ b/drivers/thermal/thermal_hwmon.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  thermal_hwmon.h - Generic Thermal Management hwmon support.
  *
@@ -8,22 +9,6 @@
  *
  *  Copyright (C) 2013 Texas Instruments
  *  Copyright (C) 2013 Eduardo Valentin <eduardo.valentin@ti.com>
- *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #ifndef __THERMAL_HWMON_H__
 #define __THERMAL_HWMON_H__
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 23b5e0a709b0..275ffee292bf 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  thermal.c - sysfs interface of thermal devices
  *
@@ -7,10 +8,6 @@
  *  Copyright (C) 2008 Intel Corp
  *  Copyright (C) 2008 Zhang Rui <rui.zhang@intel.com>
  *  Copyright (C) 2008 Sujith Thomas <sujith.thomas@intel.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7834be668d80..5f4705f46c2f 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -1,25 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  thermal.h  ($Revision: 0 $)
  *
  *  Copyright (C) 2008  Intel Corp
  *  Copyright (C) 2008  Zhang Rui <rui.zhang@intel.com>
  *  Copyright (C) 2008  Sujith Thomas <sujith.thomas@intel.com>
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
 #ifndef __THERMAL_H__
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
