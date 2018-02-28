Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeB1KsD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:48:03 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45250 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752571AbeB1KsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:48:00 -0500
X-Google-Smtp-Source: AH8x226PSGj5xBHo9iZKaxTEzNKwLQn8UE1UedLQLws5ZlzUc7WNiTcuWZ88Iov75pXSutE4ABuetQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de
Cc: chunyan.zhang@linaro.org, orson.zhai@spreadtrum.com,
        mathieu.poirier@linaro.org, devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [RESEND PATCH 3/7] arm64: dts: Add pin controller node for Spreadtrum SC9860
Date: Wed, 28 Feb 2018 18:47:06 +0800
Message-Id: <378c75289917a9686814f2870752f953977f564c.1519814593.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
References: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
In-Reply-To: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
References: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
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
