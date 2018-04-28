Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933394AbeD1Fm5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 01:42:57 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33081 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbeD1Fmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 01:42:53 -0400
X-Google-Smtp-Source: AB8JxZrdbncqj8l5PDeLQhqGKO1F5kO0iJc0ZwGzO9p2SSqHhIM7KJlne+Kb8qwRF3hXxvJBVCPBdw==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2 2/2] arm64: dts: qcom: msm8998: Add rpm and regulators for MTP
Date: Fri, 27 Apr 2018 22:42:48 -0700
Message-Id: <20180428054248.22387-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180428054248.22387-1-bjorn.andersson@linaro.org>
References: <20180428054248.22387-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the rpm and rpm regulators to the msm8998 platform and mtp.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 142 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi     |  83 +++++++++++++++++
 2 files changed, 225 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index e30c95f63a05..4780751b560e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -18,3 +18,145 @@
 		status = "okay";
 	};
 };
+
+&rpm_glink {
+	rpm_requests {
+		pm8998-regulators {
+			s2 {
+				regulator-min-microvolt = <1128000>;
+				regulator-max-microvolt = <1128000>;
+			};
+			s3 {
+				regulator-min-microvolt = <1352000>;
+				regulator-max-microvolt = <1352000>;
+			};
+			s4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+			s5 {
+				regulator-min-microvolt = <1904000>;
+				regulator-max-microvolt = <2040000>;
+			};
+			s7 {
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1028000>;
+			};
+			s8 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+			};
+			l1 {
+				regulator-min-microvolt = <880000>;
+				regulator-max-microvolt = <880000>;
+			};
+			l2 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+			};
+			l3 {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+			};
+			l5 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+			};
+			l6 {
+				regulator-min-microvolt = <1808000>;
+				regulator-max-microvolt = <1808000>;
+			};
+			l7 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+			l8 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+			};
+			l9 {
+				regulator-min-microvolt = <1808000>;
+				regulator-max-microvolt = <2960000>;
+			};
+			l10 {
+				regulator-min-microvolt = <1808000>;
+				regulator-max-microvolt = <2960000>;
+			};
+			l11 {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+			};
+			l12 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+			l13 {
+				regulator-min-microvolt = <1808000>;
+				regulator-max-microvolt = <2960000>;
+			};
+			l14 {
+				regulator-min-microvolt = <1880000>;
+				regulator-max-microvolt = <1880000>;
+			};
+			l15 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+			l16 {
+				regulator-min-microvolt = <2704000>;
+				regulator-max-microvolt = <2704000>;
+			};
+			l17 {
+				regulator-min-microvolt = <1304000>;
+				regulator-max-microvolt = <1304000>;
+			};
+			l18 {
+				regulator-min-microvolt = <2704000>;
+				regulator-max-microvolt = <2704000>;
+			};
+			l19 {
+				regulator-min-microvolt = <3008000>;
+				regulator-max-microvolt = <3008000>;
+			};
+			l20 {
+				regulator-min-microvolt = <2960000>;
+				regulator-max-microvolt = <2960000>;
+			};
+			l21 {
+				regulator-min-microvolt = <2960000>;
+				regulator-max-microvolt = <2960000>;
+			};
+			l22 {
+				regulator-min-microvolt = <2864000>;
+				regulator-max-microvolt = <2864000>;
+			};
+			l23 {
+				regulator-min-microvolt = <3312000>;
+				regulator-max-microvolt = <3312000>;
+			};
+			l24 {
+				regulator-min-microvolt = <3088000>;
+				regulator-max-microvolt = <3088000>;
+			};
+			l25 {
+				regulator-min-microvolt = <3104000>;
+				regulator-max-microvolt = <3312000>;
+			};
+			l26 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+			};
+			l28 {
+				regulator-min-microvolt = <3008000>;
+				regulator-max-microvolt = <3008000>;
+			};
+		};
+
+		pmi8998-regulators {
+			bob {
+				regulator-min-microvolt = <3312000>;
+				regulator-max-microvolt = <3600000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index d6665e4f801f..ccbf6347aacb 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -220,6 +220,16 @@
 		method = "smc";
 	};
 
+	rpm_glink: rpm-glink {
+		compatible = "qcom,glink-rpm";
+
+		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+
+		mboxes = <&apcs_glb 0>;
+	};
+
 	soc: soc {};
 };
 
@@ -337,4 +347,77 @@
 		#interrupt-cells = <4>;
 		cell-index = <0>;
 	};
+
+	rpm_msg_ram: memory@68000 {
+		compatible = "qcom,rpm-msg-ram";
+		reg = <0x778000 0x7000>;
+	};
+
+	apcs_glb: mailbox@9820000 {
+		compatible = "qcom,msm8998-apcs-hmss-global";
+		reg = <0x17911000 0x1000>;
+
+		#mbox-cells = <1>;
+	};
+};
+
+&rpm_glink {
+	rpm_requests {
+		compatible = "qcom,rpm-msm8998";
+		qcom,glink-channels = "rpm_requests";
+
+		pm8998-regulators {
+			compatible = "qcom,rpm-pm8998-regulators";
+
+			pm8998_s1: s1 {};
+			pm8998_s2: s2 {};
+			pm8998_s3: s3 {};
+			pm8998_s4: s4 {};
+			pm8998_s5: s5 {};
+			pm8998_s6: s6 {};
+			pm8998_s7: s7 {};
+			pm8998_s8: s8 {};
+			pm8998_s9: s9 {};
+			pm8998_s10: s10 {};
+			pm8998_s11: s11 {};
+			pm8998_s12: s12 {};
+			pm8998_s13: s13 {};
+			pm8998_l1: l1 {};
+			pm8998_l2: l2 {};
+			pm8998_l3: l3 {};
+			pm8998_l4: l4 {};
+			pm8998_l5: l5 {};
+			pm8998_l6: l6 {};
+			pm8998_l7: l7 {};
+			pm8998_l8: l8 {};
+			pm8998_l9: l9 {};
+			pm8998_l10: l10 {};
+			pm8998_l11: l11 {};
+			pm8998_l12: l12 {};
+			pm8998_l13: l13 {};
+			pm8998_l14: l14 {};
+			pm8998_l15: l15 {};
+			pm8998_l16: l16 {};
+			pm8998_l17: l17 {};
+			pm8998_l18: l18 {};
+			pm8998_l19: l19 {};
+			pm8998_l20: l20 {};
+			pm8998_l21: l21 {};
+			pm8998_l22: l22 {};
+			pm8998_l23: l23 {};
+			pm8998_l24: l24 {};
+			pm8998_l25: l25 {};
+			pm8998_l26: l26 {};
+			pm8998_l27: l27 {};
+			pm8998_l28: l28 {};
+			pm8998_lvs1: lvs1 {};
+			pm8998_lvs2: lvs2 {};
+		};
+
+		pmi8998-regulators {
+			compatible = "qcom,rpm-pmi8998-regulators";
+
+			pmi8998_bob: bob {};
+		};
+	};
 };
-- 
2.16.2
