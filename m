Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbeBFJaM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:30:12 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45110 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbeBFJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:28:56 -0500
X-Google-Smtp-Source: AH8x226wMBNVzOr/HHEWTsVT+fLL6h2Qy7usiGcYQ5fUeLj6w6OWBXOFC+RbjZp+uRMl1FjsIHyqEw==
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de
Cc: chunyan.zhang@spreadtrum.com, orson.zhai@spreadtrum.com,
        mathieu.poirier@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 3/7] arm64: dts: Add pin controller node for Spreadtrum SC9860
Date: Tue,  6 Feb 2018 17:28:22 +0800
Message-Id: <07e3668174e3000be036da54dd5435e9ed2fd91a.1517908478.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
References: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
In-Reply-To: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
References: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the pin controller device node for Spreadtrum
SC9860 platform.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 63fe89e..23cedbd 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -129,6 +129,11 @@
 				clock-names = "enable";
 				clocks = <&aon_gate CLK_SPLK_EB>;
 			};
+
+			pin_controller: pinctrl@402a0000 {
+				compatible = "sprd,sc9860-pinctrl";
+				reg = <0 0x402a0000 0 0x10000>;
+			};
 		};
 	};
 
-- 
1.7.9.5
