Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754406AbeDYM4a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:56:30 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:61821 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753354AbeDYM4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:56:06 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: =?UTF-8?q?Beno=C3=AEt=20Cousson=20?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <linux-doc@vger.kernel.org>,
        <kishon@ti.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v3 15/15] Documentation: ARM: Add new MMC requirements for DRA7/K2G
Date: Wed, 25 Apr 2018 18:24:49 +0530
Message-ID: <20180425125449.19755-16-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425125449.19755-1-kishon@ti.com>
References: <20180425125449.19755-1-kishon@ti.com>
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
index 75645c45d14a..5bf5ac3b3ed4 100644
--- a/Documentation/arm/OMAP/README
+++ b/Documentation/arm/OMAP/README
@@ -5,3 +5,7 @@ KERNEL		NEW DEPENDENCIES
 v4.3+		Update is needed for custom .config files to make sure
 		CONFIG_REGULATOR_PBIAS is enabled for MMC1 to work
 		properly.
+
+v4.18+		Update is needed for custom .config files to make sure
+		CONFIG_MMC_SDHCI_OMAP is enabled for all MMC instances
+		to work in DRA7 based boards.
-- 
2.17.0
