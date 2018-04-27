Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbeD0MK2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:10:28 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:47355 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758196AbeD0MKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:10:08 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <kishon@ti.com>
Subject: [PATCH v4 14/14] Documentation: ARM: Add new MMC requirements for DRA7/K2G
Date: Fri, 27 Apr 2018 17:39:05 +0530
Message-ID: <20180427120905.3665-15-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427120905.3665-1-kishon@ti.com>
References: <20180427120905.3665-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From 4.18 kernel, all the MMC controller instances in DRA7
are programmed using sdhci based driver (sdhci-omap.c). Document
this new requirement here. Both omap2plus_defconfig and
multi_v7_defconfig has CONFIG_MMC_SDHCI_OMAP enabled.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/arm/OMAP/README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/arm/OMAP/README b/Documentation/arm/OMAP/README
index 75645c45d14a..90c6c57d61e8 100644
--- a/Documentation/arm/OMAP/README
+++ b/Documentation/arm/OMAP/README
@@ -5,3 +5,7 @@ KERNEL		NEW DEPENDENCIES
 v4.3+		Update is needed for custom .config files to make sure
 		CONFIG_REGULATOR_PBIAS is enabled for MMC1 to work
 		properly.
+
+v4.18+		Update is needed for custom .config files to make sure
+		CONFIG_MMC_SDHCI_OMAP is enabled for all MMC instances
+		to work in DRA7 and K2G based boards.
-- 
2.17.0
