Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbeBTQ3N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:29:13 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36989 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbeBTQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:25:51 -0500
X-Google-Smtp-Source: AH8x224UbLb0KwgLshovbl+tZdG3+mwDXyHqUcK8O3XDDtRws5MJcm2E315gIcpfiR6vuWXaO/8XuQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/15] dt-bindings: memory: tegra: Add hot resets definitions
Date: Tue, 20 Feb 2018 19:25:17 +0300
Message-Id: <8b54af80e13406fc873dcc5932223f5d1c196172.1519141896.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1519141896.git.digetx@gmail.com>
References: <cover.1519141896.git.digetx@gmail.com>
In-Reply-To: <cover.1519141896.git.digetx@gmail.com>
References: <cover.1519141896.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definitions for the Tegra20+ memory controller hot resets.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/dt-bindings/memory/tegra114-mc.h | 19 +++++++++++++++++++
 include/dt-bindings/memory/tegra124-mc.h | 25 +++++++++++++++++++++++++
 include/dt-bindings/memory/tegra20-mc.h  | 21 +++++++++++++++++++++
 include/dt-bindings/memory/tegra210-mc.h | 31 +++++++++++++++++++++++++++++++
 include/dt-bindings/memory/tegra30-mc.h  | 19 +++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 include/dt-bindings/memory/tegra20-mc.h

diff --git a/include/dt-bindings/memory/tegra114-mc.h b/include/dt-bindings/memory/tegra114-mc.h
index 27c8386987ff..54a12adec7b8 100644
--- a/include/dt-bindings/memory/tegra114-mc.h
+++ b/include/dt-bindings/memory/tegra114-mc.h
@@ -23,4 +23,23 @@
 #define TEGRA_SWGROUP_EMUCIF	18
 #define TEGRA_SWGROUP_TSEC	19
 
+#define TEGRA114_MC_RESET_AFI		0
+#define TEGRA114_MC_RESET_AVPC		1
+#define TEGRA114_MC_RESET_DC		2
+#define TEGRA114_MC_RESET_DCB		3
+#define TEGRA114_MC_RESET_EPP		4
+#define TEGRA114_MC_RESET_2D		5
+#define TEGRA114_MC_RESET_HC		6
+#define TEGRA114_MC_RESET_HDA		7
+#define TEGRA114_MC_RESET_ISP		8
+#define TEGRA114_MC_RESET_MPCORE	9
+#define TEGRA114_MC_RESET_MPCORELP	10
+#define TEGRA114_MC_RESET_MPE		11
+#define TEGRA114_MC_RESET_3D		12
+#define TEGRA114_MC_RESET_3D2		13
+#define TEGRA114_MC_RESET_PPCS		14
+#define TEGRA114_MC_RESET_SATA		15
+#define TEGRA114_MC_RESET_VDE		16
+#define TEGRA114_MC_RESET_VI		17
+
 #endif
diff --git a/include/dt-bindings/memory/tegra124-mc.h b/include/dt-bindings/memory/tegra124-mc.h
index f534d7c06019..186e6b7e9b35 100644
--- a/include/dt-bindings/memory/tegra124-mc.h
+++ b/include/dt-bindings/memory/tegra124-mc.h
@@ -29,4 +29,29 @@
 #define TEGRA_SWGROUP_VIC	24
 #define TEGRA_SWGROUP_VI	25
 
+#define TEGRA124_MC_RESET_AFI		0
+#define TEGRA124_MC_RESET_AVPC		1
+#define TEGRA124_MC_RESET_DC		2
+#define TEGRA124_MC_RESET_DCB		3
+#define TEGRA124_MC_RESET_HC		4
+#define TEGRA124_MC_RESET_HDA		5
+#define TEGRA124_MC_RESET_ISP2		6
+#define TEGRA124_MC_RESET_MPCORE	7
+#define TEGRA124_MC_RESET_MPCORELP	8
+#define TEGRA124_MC_RESET_MSENC		9
+#define TEGRA124_MC_RESET_PPCS		10
+#define TEGRA124_MC_RESET_SATA		11
+#define TEGRA124_MC_RESET_VDE		12
+#define TEGRA124_MC_RESET_VI		13
+#define TEGRA124_MC_RESET_VIC		14
+#define TEGRA124_MC_RESET_XUSB_HOST	15
+#define TEGRA124_MC_RESET_XUSB_DEV	16
+#define TEGRA124_MC_RESET_TSEC		17
+#define TEGRA124_MC_RESET_SDMMC1	18
+#define TEGRA124_MC_RESET_SDMMC2	19
+#define TEGRA124_MC_RESET_SDMMC3	20
+#define TEGRA124_MC_RESET_SDMMC4	21
+#define TEGRA124_MC_RESET_ISP2B		22
+#define TEGRA124_MC_RESET_GPU		23
+
 #endif
diff --git a/include/dt-bindings/memory/tegra20-mc.h b/include/dt-bindings/memory/tegra20-mc.h
new file mode 100644
index 000000000000..35e131eee198
--- /dev/null
+++ b/include/dt-bindings/memory/tegra20-mc.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef DT_BINDINGS_MEMORY_TEGRA20_MC_H
+#define DT_BINDINGS_MEMORY_TEGRA20_MC_H
+
+#define TEGRA20_MC_RESET_AVPC		0
+#define TEGRA20_MC_RESET_DC		1
+#define TEGRA20_MC_RESET_DCB		2
+#define TEGRA20_MC_RESET_EPP		3
+#define TEGRA20_MC_RESET_2D		4
+#define TEGRA20_MC_RESET_HC		5
+#define TEGRA20_MC_RESET_ISP		6
+#define TEGRA20_MC_RESET_MPCORE		7
+#define TEGRA20_MC_RESET_MPEA		8
+#define TEGRA20_MC_RESET_MPEB		9
+#define TEGRA20_MC_RESET_MPEC		10
+#define TEGRA20_MC_RESET_3D		11
+#define TEGRA20_MC_RESET_PPCS		12
+#define TEGRA20_MC_RESET_VDE		13
+#define TEGRA20_MC_RESET_VI		14
+
+#endif
diff --git a/include/dt-bindings/memory/tegra210-mc.h b/include/dt-bindings/memory/tegra210-mc.h
index 4490f7cf4772..cacf05617e03 100644
--- a/include/dt-bindings/memory/tegra210-mc.h
+++ b/include/dt-bindings/memory/tegra210-mc.h
@@ -34,4 +34,35 @@
 #define TEGRA_SWGROUP_ETR	29
 #define TEGRA_SWGROUP_TSECB	30
 
+#define TEGRA210_MC_RESET_AFI		0
+#define TEGRA210_MC_RESET_AVPC		1
+#define TEGRA210_MC_RESET_DC		2
+#define TEGRA210_MC_RESET_DCB		3
+#define TEGRA210_MC_RESET_HC		4
+#define TEGRA210_MC_RESET_HDA		5
+#define TEGRA210_MC_RESET_ISP2		6
+#define TEGRA210_MC_RESET_MPCORE	7
+#define TEGRA210_MC_RESET_NVENC		8
+#define TEGRA210_MC_RESET_PPCS		9
+#define TEGRA210_MC_RESET_SATA		10
+#define TEGRA210_MC_RESET_VI		11
+#define TEGRA210_MC_RESET_VIC		12
+#define TEGRA210_MC_RESET_XUSB_HOST	13
+#define TEGRA210_MC_RESET_XUSB_DEV	14
+#define TEGRA210_MC_RESET_A9AVP		15
+#define TEGRA210_MC_RESET_TSEC		16
+#define TEGRA210_MC_RESET_SDMMC1	17
+#define TEGRA210_MC_RESET_SDMMC2	18
+#define TEGRA210_MC_RESET_SDMMC3	19
+#define TEGRA210_MC_RESET_SDMMC4	20
+#define TEGRA210_MC_RESET_ISP2B		21
+#define TEGRA210_MC_RESET_GPU		22
+#define TEGRA210_MC_RESET_NVDEC		23
+#define TEGRA210_MC_RESET_APE		24
+#define TEGRA210_MC_RESET_SE		25
+#define TEGRA210_MC_RESET_NVJPG		26
+#define TEGRA210_MC_RESET_AXIAP		27
+#define TEGRA210_MC_RESET_ETR		28
+#define TEGRA210_MC_RESET_TSECB		29
+
 #endif
diff --git a/include/dt-bindings/memory/tegra30-mc.h b/include/dt-bindings/memory/tegra30-mc.h
index 3cac81919023..169f005fbc78 100644
--- a/include/dt-bindings/memory/tegra30-mc.h
+++ b/include/dt-bindings/memory/tegra30-mc.h
@@ -22,4 +22,23 @@
 #define TEGRA_SWGROUP_MPCORE	17
 #define TEGRA_SWGROUP_ISP	18
 
+#define TEGRA30_MC_RESET_AFI		0
+#define TEGRA30_MC_RESET_AVPC		1
+#define TEGRA30_MC_RESET_DC		2
+#define TEGRA30_MC_RESET_DCB		3
+#define TEGRA30_MC_RESET_EPP		4
+#define TEGRA30_MC_RESET_2D		5
+#define TEGRA30_MC_RESET_HC		6
+#define TEGRA30_MC_RESET_HDA		7
+#define TEGRA30_MC_RESET_ISP		8
+#define TEGRA30_MC_RESET_MPCORE		9
+#define TEGRA30_MC_RESET_MPCORELP	10
+#define TEGRA30_MC_RESET_MPE		11
+#define TEGRA30_MC_RESET_3D		12
+#define TEGRA30_MC_RESET_3D2		13
+#define TEGRA30_MC_RESET_PPCS		14
+#define TEGRA30_MC_RESET_SATA		15
+#define TEGRA30_MC_RESET_VDE		16
+#define TEGRA30_MC_RESET_VI		17
+
 #endif
-- 
2.16.1
