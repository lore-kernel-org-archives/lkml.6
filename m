Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeDSKmZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:42:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35002 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbeDSKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:40:52 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, heiko@sntech.de, linux-pm@vger.kernel.org,
        dbasehore@chromium.org, linux-kernel@vger.kernel.org,
        dianders@google.com, groek@google.com, kernel@collabora.com,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/6] dt-bindings: clock: add DDR3 standard speed bins.
Date: Thu, 19 Apr 2018 12:40:15 +0200
Message-Id: <20180419104019.24406-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419104019.24406-1-enric.balletbo@collabora.com>
References: <20180419104019.24406-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DDR3 SDRAM Standard (JESD79-3F) defines some standard speed bins for
DDR3 memories. The devfreq/rk3399_dmc.txt binding refers to this file
which does not exist, so add a ddr.h file with the standard speed bins
for DDR3.

Fixes: c1ceb8f7c167 (Documentation: bindings: add dt documentation for rk3399 dmc)
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 include/dt-bindings/clock/ddr.h | 34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 include/dt-bindings/clock/ddr.h

diff --git a/include/dt-bindings/clock/ddr.h b/include/dt-bindings/clock/ddr.h
new file mode 100644
index 000000000000..506aef7e609e
--- /dev/null
+++ b/include/dt-bindings/clock/ddr.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+#ifndef DT_BINDINGS_DDR_H
+#define DT_BINDINGS_DDR_H
+
+/* DDR3-800 Standard Speed Bins */
+#define DDR3_800D	15
+#define DDR3_800E	18
+/* DDR3-1066 Standard Speed Bins */
+#define DDR3_1066E	18
+#define DDR3_1066F	21
+#define DDR3_1066G	24
+/* DDR3-1333 Standard Speed Bins */
+#define DDR3_1333F	21
+#define DDR3_1333G	24
+#define DDR3_1333H	27
+#define DDR3_1333J	30
+/* DDR3-1600 Standard Speed Bins */
+#define DDR3_1600G	24
+#define DDR3_1600H	27
+#define DDR3_1600J	30
+#define DDR3_1600K	33
+/* DDR3-1600 Standard Speed Bins */
+#define DDR3_1866J	30
+#define DDR3_1866K	33
+#define DDR3_1866L	36
+#define DDR3_1866M	39
+/* DDR3-2133 Standard Speed Bins */
+#define DDR3_2133K	33
+#define DDR3_2133L	36
+#define DDR3_2133M	39
+#define DDR3_2133N	42
+
+#endif
-- 
2.17.0
