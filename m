Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeBIJAQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:00:16 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39662 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBII67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:58:59 -0500
X-Google-Smtp-Source: AH8x225+Xv5vbRW2qrXn7TjV4cUp+Q16lMBkHkWpQDxB38/Y+QpxDSJQfQvidoTpO1VEkfYRxBH0pA==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] ARM: dts: gemini: Remove "cooling-{min|max}-level" for gpio-fan node
Date: Fri,  9 Feb 2018 14:28:07 +0530
Message-Id: <01ddf0ac8962feb63e8871a2c2c3498c763f649b.1518166039.git.viresh.kumar@linaro.org>
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
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
index 08568ce24d06..727d16eb02d9 100644
--- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
@@ -78,8 +78,6 @@
 		gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>,
 			<&gpio0 12 GPIO_ACTIVE_HIGH>;
 		gpio-fan,speed-map = <0 0>, <3000 1>, <6000 2>;
-		cooling-min-level = <0>;
-		cooling-max-level = <2>;
 		#cooling-cells = <2>;
 	};
 
-- 
2.15.0.194.g9af6a3dea062
