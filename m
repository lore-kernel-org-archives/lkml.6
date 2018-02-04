Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeBDQrY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 11:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbeBDQrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 11:47:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DFF21785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: [PATCH v2] ARM: dts: exynos: Add SPDX license identifiers
Date: Sun,  4 Feb 2018 17:46:45 +0100
Message-Id: <20180204164645.27865-1-krzk@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few files missed recent conversion of GPL v2.0 license statements to
SPDX identifiers

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Update also exynos4412-tmu-sensor-conf.dtsi, exynos4412-tiny4412.dts
   and exynos4412-trats2.dts.
---
 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi | 5 +----
 arch/arm/boot/dts/exynos-syscon-restart.dtsi      | 5 +----
 arch/arm/boot/dts/exynos4412-tiny4412.dts         | 7 ++-----
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi | 6 +-----
 arch/arm/boot/dts/exynos4412-trats2.dts           | 7 ++-----
 arch/arm/boot/dts/exynos5800-peach-pi.dts         | 5 +----
 arch/arm/boot/dts/exynos5800.dtsi                 | 5 +----
 7 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi b/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
index 25186ac4188d..1dbf3bbff8d3 100644
--- a/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
+++ b/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos SoC MFC (Video Codec) reserved memory common definition.
  *
  * Copyright (c) 2016 Samsung Electronics Co., Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 / {
diff --git a/arch/arm/boot/dts/exynos-syscon-restart.dtsi b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
index 09a2040054ed..4b3dd0549a54 100644
--- a/arch/arm/boot/dts/exynos-syscon-restart.dtsi
+++ b/arch/arm/boot/dts/exynos-syscon-restart.dtsi
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos SoC syscon reboot/poweroff nodes common definition.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 / {
diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index 5504398e6e37..01f37b5ac9c4 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * FriendlyARM's Exynos4412 based TINY4412 board device tree source
  *
@@ -5,11 +6,7 @@
  *
  * Device tree source file for FriendlyARM's TINY4412 board which is based on
  * Samsung's Exynos4412 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos4412.dtsi"
diff --git a/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
index e3f7934d19d0..489b58c619ee 100644
--- a/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
+++ b/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device tree sources for Exynos4412 TMU sensor configuration
  *
  * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <dt-bindings/thermal/thermal_exynos.h>
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index f285790e8e04..7da66003a3e3 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Samsung's Exynos4412 based Trats 2 board device tree source
  *
@@ -6,11 +7,7 @@
  *
  * Device tree source file for Samsung's Trats 2 board which is based on
  * Samsung's Exynos4412 SoC.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
+ */
 
 /dts-v1/;
 #include "exynos4412.dtsi"
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 0029ec27819c..c8a66a12dbeb 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Google Peach Pi Rev 10+ board device tree source
  *
  * Copyright (c) 2014 Google, Inc
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 9ddb6bacac5a..57d3b319fd65 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SAMSUNG EXYNOS5800 SoC device tree source
  *
@@ -7,10 +8,6 @@
  * SAMSUNG EXYNOS5800 SoC device nodes are listed in this file.
  * EXYNOS5800 based board files can include this file and provide
  * values for board specfic bindings.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include "exynos5420.dtsi"
-- 
2.11.0
