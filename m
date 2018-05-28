Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754550AbeE1Jzc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:55:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57632 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754377AbeE1Jz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:55:27 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180528095525euoutp0192174bf36d539348673e2470a72897cc~yxlzG4tr22242722427euoutp01b
X-AuditID: cbfec7f5-b45ff700000028a9-8f-5b0bd20c3201
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
Subject: [PATCH 11/12] ARM: dts: exynos5250-arndale: add display regulators
Date: Mon, 28 May 2018 11:55:11 +0200
Message-id: <1527501311-16428-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTURjHO+/d6epl3o5aflhEIXnJCxxIRMLwDUP8EBRa6dIXZzq1zWsf
        SiXnLS9NxJVhahqxluYUM8NRupw1nJeZlWBGinklUDStyJzTb7/n//zO5TkcBhcVke5MUmoG
        L0+VpIgpAdE1sGX2dhizj/FTLh5Ck61mEpWb32OooHiFRO3qNhI9Muxk4+s/KaSariLQ/NdR
        AlXOLOFoePgFjYYKlmlUcq+ZRrqZCRJZeh5SSD2sx1DDwiSBnhumaNTyaRRDhb0GGqmrFyi0
        1VNPhDpz2not4CwV5Rj36sEUzdUV3yc5naaE4l5ufCO56TIjxnU03+YqOjWAW9N5RgmiBcEJ
        fEpSFi/3DYkTSKuMs1R6iyCnv7QMywNaphTYMZANhJ1Nb6hSIGBE7FMAJ36X07ZiDcD81UZq
        3xqr0dNWFrFPAJxT+9ukbQAtw1ugFDAMxXpBbVGsNXdiNQB2fF4B1gJna0g48miJtK52ZCNg
        Zcvy7q4Eewze3WzYZSEbBvtX1vdO84RfzCW4le3Ys9DSq9y9H2Qraaj61YjZpDDYNr5K2tgR
        Lho7aRsfhpbqMsLGabBwbmYvz4H6ctOefxr2G0d3GWcPQlVXLW6dALJCWKwU2RQODk2/23sX
        NYAm/QxVBdwawAENcOUzFbJEXhGQymf7KCQyRWZqok98mkwHdr6H6Z9xvRvo/17rAywDxA7C
        vD+CGBEpyVLkyvoAZHCxk1DgvRMJEyS5N3l5Wqw8M4VX9AEPhhC7Cq+euBUtYhMlGXwyz6fz
        8v0uxti554GQ7DuRH+PPbwUFp8dvx3fnpqyZsFbfpmcq1eD3+vm2x1xe3JRyU5qd1edy1M0y
        4O3y9tJr54bxiuP5QVh+eJTrmcvX+eWTDoNSeiAtNDBCF7gxm3Dxxti52ZFaZVtrTsAHg8Gk
        dRvxs69tH6obk45qXbrsrnisrCYficQv+P8IFxMKqeSUFy5XSP4DEf6KmRoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xq7rcl7ijDe58Fba4te4cq0XvuZNM
        Fk0db1ktNs5Yz2ox/whQ7MrX92wWk+5PYLF4ce8ii0X/49fMFufPb2C3ONv0ht2ic+ISdotN
        j6+xWlzeNYfNYsb5fUwWC17eYrFYe+Quu8XS6xeZLFr3HmG3mDH5JZvFz13zWBxEPdbMW8Po
        cbmvl8lj56y77B6zO2ayemxa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5AK4oLpuU1JzM
        stQifbsErowJx5+wFSzlqjjc1c3UwLiGo4uRk0NCwETi0tR97F2MXBxCAksYJVae38YGkhAS
        aGSS+P+hsouRg4NNQEtiTXs8SI2IwCpGial/74A1MAvMZpV49WgCI0iDsIC3RP/SN2DNLAKq
        Ej0/FoDZvAIuEofffmWD2CYncfNcJzOIzSngKnF5bxvUMheJ7Y2zWCYw8ixgZFjFKJJaWpyb
        nltspFecmFtcmpeul5yfu4kRGPjbjv3csoOx613wIUYBDkYlHl6Nn1zRQqyJZcWVuYcYJTiY
        lUR4uXSBQrwpiZVVqUX58UWlOanFhxilOViUxHnPG1RGCQmkJ5akZqemFqQWwWSZODilGhid
        k7b42E/dvix36tHFrz+axV24IX78x5/sXZ0rheZ6z2f7uf3SYrPKvUalGRvOP5T3SVFK2bfy
        93s+kbB7B14euHgmzjDaQ+Dn3w6bC5sPV7KnmU7YcuOkwFyVibfKD2ZXrim9seUJS+WmtQvK
        Cl389rg0RM+Y17jRN8pWcF3ZKvdLkvFlLJ1NSizFGYmGWsxFxYkAR0P+PHgCAAA=
X-CMS-MailID: 20180528095523eucas1p1039e1b62aaef415b66d6f62e86dbef93
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528095523eucas1p1039e1b62aaef415b66d6f62e86dbef93
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
        <CGME20180528095523eucas1p1039e1b62aaef415b66d6f62e86dbef93@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds fixed regulators used by DSI/LVDS bridge
and panel. Regulators are named according to schematics.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 7a8a5c5..80221fa 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -97,6 +97,30 @@
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
-- 
2.7.4
