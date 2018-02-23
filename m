Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeBWKSc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:18:32 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:28937 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751629AbeBWKQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:16:58 -0500
X-UUID: 47cbfa237b4b420c900c6a40e34753c4-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v1 09/19] arm: dts: mt7623: add related clock properties to cpu[1-3] nodes
Date: Fri, 23 Feb 2018 18:16:29 +0800
Message-ID: <8cfae2c1d9464cf82e431a6e0c7c275c46133578.1519378872.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Complement the missing clock properties cpu[1-3] should depend on.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 arch/arm/boot/dts/mt7623.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index da56c54..5cf93a4 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -94,6 +94,9 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x1>;
+			clocks = <&infracfg CLK_INFRA_CPUSEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cpu_opp_table>;
 			clock-frequency = <1300000000>;
 		};
@@ -102,6 +105,9 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x2>;
+			clocks = <&infracfg CLK_INFRA_CPUSEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cpu_opp_table>;
 			clock-frequency = <1300000000>;
 		};
@@ -110,6 +116,9 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x3>;
+			clocks = <&infracfg CLK_INFRA_CPUSEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cpu_opp_table>;
 			clock-frequency = <1300000000>;
 		};
-- 
2.7.4
