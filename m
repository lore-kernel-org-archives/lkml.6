Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033625AbeBOOxa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:53:30 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9080 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032957AbeBOOxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:53:25 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 15 Feb 2018 06:53:25 -0800
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <talho@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v3 5/7] dt-bindings: tegra: Add documentation for nvidia,tegra194-pmc
Date: Thu, 15 Feb 2018 16:52:04 +0200
Message-ID: <20180215145206.24775-6-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215145206.24775-1-mperttunen@nvidia.com>
References: <20180215145206.24775-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra194 power management controller has one additional register
aperture to be specified in the device tree node.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
index 078a58b0302f..5a3bf7c5a7a0 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
@@ -3,6 +3,7 @@ NVIDIA Tegra Power Management Controller (PMC)
 Required properties:
 - compatible: Should contain one of the following:
   - "nvidia,tegra186-pmc": for Tegra186
+  - "nvidia,tegra194-pmc": for Tegra194
 - reg: Must contain an (offset, length) pair of the register set for each
   entry in reg-names.
 - reg-names: Must include the following entries:
@@ -10,6 +11,7 @@ Required properties:
   - "wake"
   - "aotag"
   - "scratch"
+  - "misc" (Only for Tegra194)
 
 Optional properties:
 - nvidia,invert-interrupt: If present, inverts the PMU interrupt signal.
-- 
2.16.1
