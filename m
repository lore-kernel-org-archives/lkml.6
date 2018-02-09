Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbeBII7s (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:59:48 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39667 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeBII7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:59:02 -0500
X-Google-Smtp-Source: AH8x225im59ZqqaiZ90KsQgDGadpVn2N7iSUFNjUCMyJF4fmxY+kJ37JCboxMzOkQYMuDhP9UcMi3A==
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
Subject: [PATCH 08/10] ARM64: dts: meson: Remove "cooling-{min|max}-level" for gpio-fan node
Date: Fri,  9 Feb 2018 14:28:08 +0530
Message-Id: <24b53440922491982c781a3eb032b04c167d733d.1518166039.git.viresh.kumar@linaro.org>
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
gpio-fan cooling device is found by referring to the
"gpio-fan,speed-map" instead.

Remove the unused properties from the gpio-fan node.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 658215c9822c..8ee4a693c438 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -59,8 +59,6 @@
 				      1 1
 				      2 2
 				      3 3>;
-		cooling-min-level = <0>;
-		cooling-max-level = <3>;
 		#cooling-cells = <2>;
 	};
 
-- 
2.15.0.194.g9af6a3dea062
