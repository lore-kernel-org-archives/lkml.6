Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF443601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeFFPK1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:10:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56832 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeFFPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:09:16 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Paolo Cretaro <paolocretaro@gmail.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v3 11/12] iio: cros_ec: Switch to SPDX identifier.
Date: Wed,  6 Jun 2018 17:08:59 +0200
Message-Id: <20180606150900.8342-12-enric.balletbo@collabora.com>
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

 drivers/iio/accel/cros_ec_accel_legacy.c      | 27 +++++++------------
 .../common/cros_ec_sensors/cros_ec_sensors.c  | 24 +++++------------
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 18 +++----------
 .../cros_ec_sensors/cros_ec_sensors_core.h    | 12 ++-------
 drivers/iio/light/cros_ec_light_prox.c        | 18 +++----------
 drivers/iio/pressure/cros_ec_baro.c           | 18 +++----------
 6 files changed, 30 insertions(+), 87 deletions(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 063e89eff791..1fc59984216b 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -1,21 +1,12 @@
-/*
- * Driver for older Chrome OS EC accelerometer
- *
- * Copyright 2017 Google, Inc
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
- * This driver uses the memory mapper cros-ec interface to communicate
- * with the Chrome OS EC about accelerometer data.
- * Accelerometer access is presented through iio sysfs.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Driver for older ChromeOS EC accelerometer
+//
+// Copyright (C) 2017 Google, Inc.
+// Author: Gwendal Grignou <gwendal@chromium.org>
+//
+// This driver uses the memory mapper cros-ec interface to communicate
+// with the ChromeOS EC about accelerometer data.
+// Accelerometer access is presented through iio sysfs.
 
 #include <linux/delay.h>
 #include <linux/device.h>
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 705cb3e72663..39d4eecc97ea 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -1,20 +1,10 @@
-/*
- * cros_ec_sensors - Driver for Chrome OS Embedded Controller sensors.
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
- * This driver uses the cros-ec interface to communicate with the Chrome OS
- * EC about sensors data. Data access is presented through iio sysfs.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Driver for ChromeOS Embedded Controller sensors.
+//
+// Copyright (C) 2016 Google, Inc.
+//
+// This driver uses the cros-ec interface to communicate with the ChromeOS
+// EC about sensors data. Data access is presented through iio sysfs.
 
 #include <linux/delay.h>
 #include <linux/device.h>
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index a620eb5ce202..05221994197c 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -1,17 +1,7 @@
-/*
- * cros_ec_sensors_core - Common function for Chrome OS EC sensor driver.
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
- */
+// SPDX-License-Identifier: GPL-2.0
+// Common functions for ChromeOS EC sensor driver.
+//
+// Copyright (C) 2016 Google, Inc.
 
 #include <linux/delay.h>
 #include <linux/device.h>
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
index 2edf68dc7336..a9935489030e 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
@@ -1,16 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * ChromeOS EC sensor hub
  *
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
+ * Copyright (C) 2016 Google, Inc.
  */
 
 #ifndef __CROS_EC_SENSORS_CORE_H
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 8e8a0e7f78d1..8635e1c18cd5 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -1,17 +1,7 @@
-/*
- * cros_ec_light_prox - Driver for light and prox sensors behing CrosEC.
- *
- * Copyright (C) 2017 Google, Inc
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
+// Driver for light and prox sensors behind ChromeOS EC.
+//
+// Copyright (C) 2017 Google, Inc.
 
 #include <linux/delay.h>
 #include <linux/device.h>
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 4599fde4dd25..8e134d65d18d 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -1,17 +1,7 @@
-/*
- * cros_ec_baro - Driver for barometer sensor behind CrosEC.
- *
- * Copyright (C) 2017 Google, Inc
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
+// Driver for barometer sensor behind ChromeOS EC.
+//
+// Copyright (C) 2017 Google, Inc.
 
 #include <linux/delay.h>
 #include <linux/device.h>
-- 
2.17.1
