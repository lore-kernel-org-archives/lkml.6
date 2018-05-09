Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965247AbeEIVfK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 17:35:10 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46456 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964984AbeEIVfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 17:35:08 -0400
X-Google-Smtp-Source: AB8JxZp7DV0cSlYRiQy6a7nk5l4SS+Nea0fsi8H3Cj4LNRn9MNfeRHU9/ejM98UNdAktZABeMJjzNQ==
From: Douglas Anderson <dianders@chromium.org>
To: andy.gross@linaro.org
Cc: bjorn.andersson@linaro.org, rnayak@codeaurora.org,
        evgreen@chromium.org, ilina@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-soc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: sdm845: Add command DB node
Date: Wed,  9 May 2018 14:34:39 -0700
Message-Id: <20180509213439.165623-1-dianders@chromium.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add command DB node based on the bindings example.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 486ace9a9e8b..7b5f2b3982a3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -21,6 +21,18 @@
 		reg = <0 0x80000000 0 0>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		reserved-memory@85fe0000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x0 0x85fe0000 0x0 0x20000>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
-- 
2.17.0.441.gb46fe60e1d-goog
