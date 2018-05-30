Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753572AbeE3MSC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:18:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34188 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeE3MQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:16:36 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180530121634euoutp02761fd7918578fc9bce0bf7db246019b2~zaznLwV5z0118901189euoutp02g
X-AuditID: cbfec7f4-b4fc79c0000043e4-94-5b0e961f517f
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v2 10/10] ARM: dts: exynos5250-arndale: add DSI and panel
 nodes
Date: Wed, 30 May 2018 14:16:01 +0200
Message-id: <1527682561-1386-11-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSaUhUURTHu2/e5uDYYzS8WZoMRCFkVn64WUiBxEuihb6EI+mUzwXHpRl3
        KRfcRnNPnUrUyDE1d83SHE2zJrFGzd0yBSNcRiPMUNTK8em33/9/zv2fc+DSAnEyYUX7BYZw
        ikCZXEIK8eb3a/pjh/LNpA6jT+zRRI2eQOn6HgzFpywSqF5dS6Di7i1vaOUniXKmsnA0+20A
        R5kzCwLU11dHoU/xBgqpsksp1DAzQqDB1kISqfvaMVQyN4Gj6u5JCmlGBzCUqO2mkDp3jkRr
        rUX4uX1sVVEVYAcz0jG25dEkxT5OeUiwDZUqkn35Z5pgp9J0GNtYGsNmNFUCdrnB5qrQTXjW
        i5P7hXGK486eQt/e+x2C4BbziNnVaTwW1O5NBSY0ZBzh2LslMhUIaTFTDuBmZjHBi2UAC1OX
        wG7XUlI5xhfKAEx7Fkfx4h+ALTMaPBXQNMnYwapkD6NvwVQC2Di2CIxCwOQRsL94gTBGmTPX
        YEJ2PGlknDkMDUMPtlnEuEDtm6cUP84GjutVAmOoyZb/vM3ZmAOZXArONdfurOQCqzpGSJ7N
        4byuaeftQahK6cR4DoKJP2Z2/AjYnt5L8HwGvtUNbLOAMYM5zQXbsyAjgilJYr6Fhbq8bMAf
        WQCgZn4VywL7S8CeSmDJhSoDfDjlyUAu3F4pC1CGBvrY3w4KaABb36P3r+73K9C6casLMDSQ
        mIocboikYkIWpowM6AKQFkgsRKFaU6lY5CWLjOIUQR6KUDmn7AIHaFxiKbp59J6bmPGRhXD+
        HBfMKXarGG1iFQtKrkgj8hlDW/XQ62jtZ+sNX0OZbbVrP3Z+/E4G6/71hq5Ef2ElzdZpRX7a
        ddOxrk7mVlt46Yg8LsFDbfjY82GlXthb8aW9c72mrIYtHHZXSS0cXOO0LdYePtjl71HCjLvL
        UzHBnqvqXy+G/dMTNOHe152iF7xPtS/krYszK0wuSnClr+yEnUChlP0H8ITf2BoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xy7py0/iiDWY081vcWneO1aL33Ekm
        i6aOt6wWG2esZ7WYfwQoduXrezaLSfcnsFi8uHeRxaL/8Wtmi/PnN7BbnG16w27ROXEJu8Wm
        x9dYLS7vmsNmMeP8PiaLBS9vsVisPXKX3WLp9YtMFq17j7BbzJj8ks3i5655LA6iHmvmrWH0
        uNzXy+Sxc9Zddo/ZHTNZPTat6mTz2P7tAavH/e7jTB6bl9R79G1ZxejxeZNcAFcUl01Kak5m
        WWqRvl0CV8bpnv3MBTuFK178eMDSwLiev4uRk0NCwETiXdsKpi5GLg4hgSWMEocaXrNCOI1M
        EvM2nmTpYuTgYBPQkljTHg8SFxFYxSgx9e8ddhCHWWA2q8SrRxMYQUYJC/hLnDu2gRnEZhFQ
        lXhzZQobiM0r4CKx98Bidoh1chI3z3UygwzlBIqv3mMHEhYScJbY19LJOIGRZwEjwypGkdTS
        4tz03GJDveLE3OLSvHS95PzcTYzAwN927OfmHYyXNgYfYhTgYFTi4TWI4I0WYk0sK67MPcQo
        wcGsJMJbupcnWog3JbGyKrUoP76oNCe1+BCjNAeLkjjveYPKKCGB9MSS1OzU1ILUIpgsEwen
        VANjsV/i7hXzZ0itePDD4fCsTVOa1rqsr90myrD9XLlXZmNxRLnLc863Flv6jEo/BUXUWRwI
        6D3vIpPkHG/aeTjAXTtlgvCWZRW5kzX5mtr9Rb6azWCNtXO8+bj/Outi7xoNDo4lcx1s6q81
        744K3vVZfvKrXYZpO+UV36Y4J/z5t1nx2J4Lm9SUWIozEg21mIuKEwFobRvaeAIAAA==
X-CMS-MailID: 20180530121630eucas1p1584c59b67815a65d0747afab214979ef
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530121630eucas1p1584c59b67815a65d0747afab214979ef
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
        <CGME20180530121630eucas1p1584c59b67815a65d0747afab214979ef@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds bridge and panel nodes.
It adds also DSI properties specific for arndale board and
regulators required by the bridge.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 61 ++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 7a8a5c5..816d89d 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -71,6 +71,17 @@
 		};
 	};
 
+	panel: panel {
+		compatible = "boe,hv070wsa-100";
+		power-supply = <&vcc_3v3_reg>;
+		enable-gpios = <&gpd1 3 GPIO_ACTIVE_HIGH>;
+		port {
+			panel_ep: endpoint {
+				remote-endpoint = <&bridge_out_ep>;
+			};
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -97,6 +108,30 @@
 			reg = <2>;
 			regulator-name = "hdmi-en";
 		};
+
+		vcc_1v2_reg: regulator@3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "VCC_1V2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		vcc_1v8_reg: regulator@4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "VCC_1V8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vcc_3v3_reg: regulator@5 {
+			compatible = "regulator-fixed";
+			reg = <5>;
+			regulator-name = "VCC_3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
 	};
 
 	fixed-rate-clocks {
@@ -119,6 +154,32 @@
 	cpu0-supply = <&buck2_reg>;
 };
 
+&dsi_0 {
+	vddcore-supply = <&ldo8_reg>;
+	vddio-supply = <&ldo10_reg>;
+	samsung,pll-clock-frequency = <24000000>;
+	samsung,burst-clock-frequency = <320000000>;
+	samsung,esc-clock-frequency = <10000000>;
+	status = "okay";
+
+	bridge@0 {
+		reg = <0>;
+		compatible = "toshiba,tc358764";
+		vddc-supply = <&vcc_1v2_reg>;
+		vddio-supply = <&vcc_1v8_reg>;
+		vddlvds-supply = <&vcc_3v3_reg>;
+		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port@1 {
+			reg = <1>;
+			bridge_out_ep: endpoint {
+				remote-endpoint = <&panel_ep>;
+			};
+		};
+	};
+};
+
 &dp {
 	status = "okay";
 	samsung,color-space = <0>;
-- 
2.7.4
