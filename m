Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeBTMCQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:02:16 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19685 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbeBTMAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:00:22 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Feb 2018 04:00:22 -0800
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <talho@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pombredanne@nexb.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v4 4/7] dt-bindings: tegra: Add missing chips and NVIDIA boards
Date: Tue, 20 Feb 2018 13:58:09 +0200
Message-ID: <20180220115812.24108-5-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220115812.24108-1-mperttunen@nvidia.com>
References: <20180220115812.24108-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibility strings for supported but undocumented Tegra chips
(Tegra114/124/132/210/186/194) and reference boards.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v2:
    - add patch

 Documentation/devicetree/bindings/arm/tegra.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
index 7f1411bbabf7..32f62bb7006d 100644
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ b/Documentation/devicetree/bindings/arm/tegra.txt
@@ -9,6 +9,12 @@ following compatible values:
 
   nvidia,tegra20
   nvidia,tegra30
+  nvidia,tegra114
+  nvidia,tegra124
+  nvidia,tegra132
+  nvidia,tegra210
+  nvidia,tegra186
+  nvidia,tegra194
 
 Boards
 -------------------------------------------
@@ -26,8 +32,18 @@ board-specific compatible values:
   nvidia,cardhu
   nvidia,cardhu-a02
   nvidia,cardhu-a04
+  nvidia,dalmore
   nvidia,harmony
+  nvidia,jetson-tk1
+  nvidia,norrin
+  nvidia,p2371-0000
+  nvidia,p2371-2180
+  nvidia,p2571
+  nvidia,p2771-0000
+  nvidia,p2972-0000
+  nvidia,roth
   nvidia,seaboard
+  nvidia,tn7
   nvidia,ventana
   toradex,apalis_t30
   toradex,apalis_t30-eval
-- 
2.16.1
