Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeBII7H (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:59:07 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44160 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752214AbeBII7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:59:04 -0500
X-Google-Smtp-Source: AH8x227YlcbFDO96hL7nyu+THN0QqXcpyu/qqBBH7tMep4E9mEm8X80ntFHk15HhTR2dAzBn0+s+6A==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] dt-bindings: cpufreq-dt: Remove "cooling-{min|max}-level" properties
Date: Fri,  9 Feb 2018 14:28:09 +0530
Message-Id: <aef1b506b365920d82b17c0712a3428196f72dc5.1518166039.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "cooling-min-level" and "cooling-max-level" properties are not
parsed by any part of kernel currently and the max cooling state of a
CPU cooling device is found by referring to the cpufreq table instead.

Remove the unused bindings.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
index dd3929e85dec..332aed8f4597 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
@@ -18,8 +18,6 @@ under node /cpus/cpu@0.
   in unit of nanoseconds.
 - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
 - #cooling-cells:
-- cooling-min-level:
-- cooling-max-level:
      Please refer to Documentation/devicetree/bindings/thermal/thermal.txt.
 
 Examples:
@@ -40,8 +38,6 @@ cpus {
 		>;
 		clock-latency = <61036>; /* two CLK32 periods */
 		#cooling-cells = <2>;
-		cooling-min-level = <0>;
-		cooling-max-level = <2>;
 	};
 
 	cpu@1 {
-- 
2.15.0.194.g9af6a3dea062
