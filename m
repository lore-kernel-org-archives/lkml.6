Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758159AbeD0LsV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:48:21 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:46598 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758127AbeD0LsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:48:15 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <kishon@ti.com>
Subject: [PATCH v5 13/14] dt-bindings: sdhci-omap: Add pinctrl bindings
Date: Fri, 27 Apr 2018 17:17:22 +0530
Message-ID: <20180427114723.2687-14-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427114723.2687-1-kishon@ti.com>
References: <20180427114723.2687-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl binding rquired to get the mux mode and IODelay
values from devicetree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
index 8d09b837e350..393848c2138e 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
@@ -7,6 +7,11 @@ Required properties:
 	      Should be "ti,k2g-sdhci" for K2G
 - ti,hwmods: Must be "mmc<n>", <n> is controller instance starting 1
 	     (Not required for K2G).
+- pinctrl-names: Should be subset of "default", "hs", "sdr12", "sdr25", "sdr50",
+		 "ddr50-rev11", "sdr104-rev11", "ddr50", "sdr104",
+		 "ddr_1_8v-rev11", "ddr_1_8v" or "ddr_3_3v", "hs200_1_8v-rev11",
+		 "hs200_1_8v",
+- pinctrl-<n> : Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
 
 Example:
 	mmc1: mmc@4809c000 {
-- 
2.17.0
