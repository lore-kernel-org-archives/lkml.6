Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932142AbeE1J4C (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:56:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43340 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754173AbeE1Jz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:55:59 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180528095557euoutp029eaf52a9a56b61998e52ddd42d5c8e2b~yxmRECyFr1886818868euoutp02i
X-AuditID: cbfec7f2-1c1ff70000011644-97-5b0bd22cae38
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
Subject: [PATCH 12/12] ARM: dts: exynos5250-arndale: add dsi and panel nodes
Date: Mon, 28 May 2018 11:55:47 +0200
Message-id: <1527501347-16521-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTYRTHfXbv3b0ur1ym4aOFHxaSSJpCH5600sjghn2IUAJNbeVliq9t
        amqkJs3mzJdm0jJTC5WaZjZ1lqWBWirSpi7KDJuwsPka5EtNIvM2/fY////vnOc5cChMXEx4
        UUlpmZw8TZoiEYpwwzu70f/AxK6YQF0bjabajAQqM44IUJFqiUDPtc8IVD+45X1Y+yFEGksl
        jmxfx3FUYV3AkMnUTqL3RYskKrndSCK99SOBzD21QqQ19QlQw9wUjp4OTpOo6dO4ACl7B0mk
        rZoTIntPHR62m22tawWsubxMwL6smSbZ+6p7BKvXlQjZ7vUZgrWUDgnYjsYCtrxTB9gVvfcZ
        UbToSAKXkpTNyQ8euyBKHP5txzO66ByVsQMvBBaRGjhTkDkEH6g1mBqIKDHzGMDymjWBo1gB
        sGV6U7BDjXW+xR1BM4Dmb4uAD8TMJoCznZQaUJSQ8YOtN+N5xp3RAdgxuQT4AmOqCThWv0Dw
        DW7Mabg8MEPyDTjjAye+R/E2zYTDX7bu7ce84WdjCcZrZ+YkNPcWC/k5kKki4XKXBndA4bB8
        2QYc2g3OD3WSDr0XmqtKt5l0qJy1bvs5sK9slHDoEDgwNP5fY4wr1BjuYvx/IENDVbHYgbDw
        1oZB6FhYu7XwqhWrBJ4NwEkHPLgsRaqMUwSlcVcCFNJURVaaLOBSeqoebF3H6N+hny/A2sTF
        fsBQQOJC+9pFMWJCmq3ITe0HkMIk7rTIf8uiE6S5eZw8PV6elcIp+sEeCpd40HG++dFiRibN
        5JI5LoOT76QCytmrEHj6N6v8KueDZ7r1wYYQf1PbiZprqsslrSF0QaT9y0pkWH3t8qST0i8/
        JuL1kwq21+fGpJchzutOcsTG6tVQE/2maViT0RU6ezi9dt/xQJvbq5YoRh1bnd14NK6iSLv+
        aNFytsL9T7WrS9z19pFzS3myJp9TsVNK9vzD/aTHnGVKgisSpUF+mFwh/QdzVg9bGQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xq7ral7ijDSY3yFrcWneO1aL33Ekm
        i6aOt6wWG2esZ7WYfwQoduXrezaLSfcnsFi8uHeRxaL/8Wtmi/PnN7BbnG16w27ROXEJu8Wm
        x9dYLS7vmsNmMeP8PiaLBS9vsVisPXKX3WLp9YtMFq17j7BbzJj8ks3i5655LA6iHmvmrWH0
        uNzXy+Sxc9Zddo/ZHTNZPTat6mTz2P7tAavH/e7jTB6bl9R79G1ZxejxeZNcAFcUl01Kak5m
        WWqRvl0CV8aJHz9ZCrbyVnSc28zSwHifq4uRk0NCwETiwpajLF2MXBxCAksYJbr/rWeHcBqZ
        JE4+ecfWxcjBwSagJbGmPR4kLiKwilFi6t87YEXMArNZJV49msAIMkpYwEfi3eEH7CANLAKq
        Epeeh4KEeQVcJL6/2M4EsU1O4ua5TmYQm1PAVeLy3jY2EFsIqGZ74yyWCYw8CxgZVjGKpJYW
        56bnFhvpFSfmFpfmpesl5+duYgQG/rZjP7fsYOx6F3yIUYCDUYmHV+MnV7QQa2JZcWXuIUYJ
        DmYlEV4uXaAQb0piZVVqUX58UWlOavEhRmkOFiVx3vMGlVFCAumJJanZqakFqUUwWSYOTqkG
        xhNB4g/1rOe7nyrp/OCqMfuLy6XXe/ZOLEsIDvzNs+tl3QGdhZOf9i/ka6gJFbhyIclbsK5h
        W6LNZxmXOsPVU+ICejr4HFemxL7WM17FKRsUkKo0zbXlztEjHxY0JPpffvbj7puvu1//m77W
        8NdEZqt331/lq3ybW7rQYHnJilVrxSY/vib4oV+JpTgj0VCLuag4EQApDQNueAIAAA==
X-CMS-MailID: 20180528095555eucas1p2fb61f362a3aa2d0082b8c4001b17f176
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528095555eucas1p2fb61f362a3aa2d0082b8c4001b17f176
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
        <CGME20180528095555eucas1p2fb61f362a3aa2d0082b8c4001b17f176@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds bridge and panel nodes.
It adds also DSI properties specific for arndale board.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 80221fa..6f0b1c4 100644
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
@@ -476,6 +487,34 @@
 	};
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
+		vddmipi-supply = <&vcc_1v2_reg>;
+		vddlvds133-supply = <&vcc_3v3_reg>;
+		vddlvds112-supply = <&vcc_1v2_reg>;
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
 &i2c_2 {
 	status = "okay";
 	/* used by HDMI DDC */
-- 
2.7.4
