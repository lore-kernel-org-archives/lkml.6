Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeBII6y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:58:54 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46575 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbeBII6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:58:51 -0500
X-Google-Smtp-Source: AH8x224BLOlde0uYsw73qX7JTcQ6kldOZ8cbWq5R5zG6XlXKSu3L+Ckg3nKIAAvLZd6k80J8WXi/fQ==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] ARM: dts: sun[4-7]i: Remove "cooling-{min|max}-level" for CPU nodes
Date: Fri,  9 Feb 2018 14:28:04 +0530
Message-Id: <4d489d040ec1fc3821d8e4bf31ffcc2eebfa41e1.1518166039.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "cooling-min-level" and "cooling-max-level" properties are not
parsed by any part of the kernel currently and the max cooling state of
a CPU cooling device is found by referring to the cpufreq table instead.

Remove the unused properties from the CPU nodes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 1 -
 arch/arm/boot/dts/sun4i-a10.dtsi               | 2 --
 arch/arm/boot/dts/sun5i-a13.dtsi               | 2 --
 arch/arm/boot/dts/sun6i-a31.dtsi               | 2 --
 arch/arm/boot/dts/sun7i-a20.dtsi               | 2 --
 5 files changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 49247fbe6acd..e3d1d0f63caf 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -97,7 +97,6 @@
 		864000  1300000
 		624000  1250000
 		>;
-	cooling-max-level = <2>;
 };
 
 &de {
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 4f2f2eea0755..77e8436beed4 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -123,8 +123,6 @@
 				624000	1250000
 				>;
 			#cooling-cells = <2>;
-			cooling-min-level = <0>;
-			cooling-max-level = <3>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 4e830f5cb7f1..b1d827765530 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -116,8 +116,6 @@
 		432000	1200000
 		>;
 	#cooling-cells = <2>;
-	cooling-min-level = <0>;
-	cooling-max-level = <5>;
 };
 
 &pio {
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 72d3fe44ecaf..c72992556a86 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -113,8 +113,6 @@
 				480000	1000000
 				>;
 			#cooling-cells = <2>;
-			cooling-min-level = <0>;
-			cooling-max-level = <3>;
 		};
 
 		cpu@1 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index bd0cd3204273..a3a6ce489fda 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -116,8 +116,6 @@
 				144000	1000000
 				>;
 			#cooling-cells = <2>;
-			cooling-min-level = <0>;
-			cooling-max-level = <6>;
 		};
 
 		cpu@1 {
-- 
2.15.0.194.g9af6a3dea062
