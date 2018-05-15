Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeEOEnT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 00:43:19 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37237 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeEOEnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 00:43:17 -0400
X-Google-Smtp-Source: AB8JxZr5LQwtq3rUO4LW0NqC61lk1va8wgOti8k6JETHd73u09jzJq2RF6Nwl8H9xkzj9bL0tsFXFQ==
From: Douglas Anderson <dianders@chromium.org>
To: andy.gross@linaro.org
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-soc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] arm64: dts: qcom: sdm845: Sort nodes in the reserved mem by address
Date: Mon, 14 May 2018 21:43:06 -0700
Message-Id: <20180515044306.40735-1-dianders@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's keep the reserved-memory node tidy and neat and keep it sorted
by address.  This should have no functional change.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Oops!  v1 accidentally changed the node name.  Fixed.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 7c85e7c596db..73f71061fef8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -31,6 +31,12 @@
 			no-map;
 		};
 
+		memory@85fe0000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x0 0x85fe0000 0x0 0x20000>;
+			no-map;
+		};
+
 		smem_mem: memory@86000000 {
 			reg = <0x0 0x86000000 0x0 0x200000>;
 			no-map;
@@ -40,12 +46,6 @@
 			reg = <0 0x86200000 0 0x2d00000>;
 			no-map;
 		};
-
-		memory@85fe0000 {
-			compatible = "qcom,cmd-db";
-			reg = <0x0 0x85fe0000 0x0 0x20000>;
-			no-map;
-		};
 	};
 
 	cpus {
-- 
2.17.0.441.gb46fe60e1d-goog
