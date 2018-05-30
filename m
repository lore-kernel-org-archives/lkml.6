Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbeE3PMA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:12:00 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38720 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbeE3PKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:10:24 -0400
X-Google-Smtp-Source: ADUXVKI2F96K5mLg4fmiqeqnJ97mJePpmqPyIDTTV8YtRaWZw84TdZvlMxki3r/Twr4e1XuEJVI2fQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] dt: bindings: tegra20-emc: Document interrupt property
Date: Wed, 30 May 2018 18:06:43 +0300
Message-Id: <20180530150646.19030-2-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530150646.19030-1-digetx@gmail.com>
References: <20180530150646.19030-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EMC has a dedicated interrupt that is used to notify about completion of
HW operations. Document the interrupt property.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
index 4c33b29dc660..a6fe401d0d48 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
@@ -10,6 +10,7 @@ Properties:
   and chosen using the ramcode board selector. If omitted, only one
   set of tables can be present and said tables will be used
   irrespective of ram-code configuration.
+- interrupts : Should contain EMC General interrupt.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
@@ -20,6 +21,7 @@ Example:
 		#size-cells = < 0 >;
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f4000 0x200>;
+		interrupts = <0 78 0x04>;
 	}
 
 
-- 
2.17.0
