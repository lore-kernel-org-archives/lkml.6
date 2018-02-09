Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBII7B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:59:01 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43506 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeBII64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:58:56 -0500
X-Google-Smtp-Source: AH8x226BCdbSwTXxyBx7kY4XncU3rJwPG/cHnIOc9oNn6vDUd1pfYTdTIYDG/fTqxchmBFrP3sbbSA==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] ARM64: dts: meson: Remove "cooling-{min|max}-level" for CPU nodes
Date: Fri,  9 Feb 2018 14:28:06 +0530
Message-Id: <6c91ebfecf86da98a7682c6d262ff1218a1d7343.1518166039.git.viresh.kumar@linaro.org>
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
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 1448c3dba08e..658215c9822c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -209,14 +209,10 @@
 };
 
 &cpu0 {
-	cooling-min-level = <0>;
-	cooling-max-level = <6>;
 	#cooling-cells = <2>;
 };
 
 &cpu4 {
-	cooling-min-level = <0>;
-	cooling-max-level = <4>;
 	#cooling-cells = <2>;
 };
 
-- 
2.15.0.194.g9af6a3dea062
