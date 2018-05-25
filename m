Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966244AbeEYKgM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:36:12 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:44208 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965883AbeEYKcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:32:22 -0400
X-Google-Smtp-Source: AB8JxZprRgkvD/K2n8gM+NcW1mDh32NADQp2mhyfKaOUO/hizju5RdFZ+9iJiRXiSAyzFp/sRraVXQ==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arm@kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, chris.redpath@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] arm: dts: armada: Fix "#cooling-cells" property's name
Date: Fri, 25 May 2018 16:01:47 +0530
Message-Id: <26a0666368694db610414a85a08843435ea070a7.1527244201.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1527244200.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1527244200.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be "#cooling-cells" instead of "cooling-cells". Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/armada-385-synology-ds116.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-385-synology-ds116.dts b/arch/arm/boot/dts/armada-385-synology-ds116.dts
index 6782ce481ac9..d8769956cbfc 100644
--- a/arch/arm/boot/dts/armada-385-synology-ds116.dts
+++ b/arch/arm/boot/dts/armada-385-synology-ds116.dts
@@ -139,7 +139,7 @@
 					      3700 5
 					      3900 6
 					      4000 7>;
-			cooling-cells = <2>;
+			#cooling-cells = <2>;
 		};
 
 		gpio-leds {
-- 
2.15.0.194.g9af6a3dea062
