Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754575AbeCGR24 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:28:56 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:27857 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933736AbeCGR1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:27:42 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180307172740epoutp02ddaafd065aaa65501c86cda3c8f458b4~Zs3QlWrqb1384813848epoutp02e
X-AuditID: b6c32a45-3ebff70000001023-1a-5aa0210b524b
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 3/4] ARM: dts: exynos5250-snow MAX98095 CODEC node update
Date: Wed, 07 Mar 2018 18:27:10 +0100
Message-id: <20180307172711.15697-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180307172711.15697-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCmmS634oIog8a/shYbZ6xntZh/5Byr
        Rf/j18wW589vYLfY9Pgaq8XlXXPYLGac38dksfbIXXaLw2/aWR04PTat6mTz2Lyk3qNvyypG
        j8+b5AJYorhsUlJzMstSi/TtErgy/j+cwlzwi63iUd8fxgbGZ6xdjJwcEgImEouP7WPvYuTi
        EBLYwShx88wqNgjnO6PE2lVd7DBVn2YtYIZI7GaUuP9xEZTzi1Fiff8MsFlsAoYSvUf7GEFs
        EQFhiXtLl4PNZRb4xyixbuVeNpCEsICnxNsJH5hAbBYBVYl3dxaDNfAKWEu8mPOZCWKdvMT7
        BffB4pwCNhIL70xnARkkITCBTaL91EpmiCIXiWNr70B9ISzx6vgWqFulJZ6t2sgIYVdLdLZ1
        sUM0tzBK/Jl2iQ0iYS1x+PhFsGZmAT6JjsN/gYo4gOK8Eh1tQhAlHhLdm7qgDnKU2H6sAerl
        fkaJTbNPM05glFrAyLCKUSy1oDg3PbXYqMBQrzgxt7g0L10vOT93EyM4RrVcdzDOOOdziFGA
        g1GJh1fiz/woIdbEsuLK3EOMEhzMSiK8RvILooR4UxIrq1KL8uOLSnNSiw8xSnOwKInztgW4
        RAkJpCeWpGanphakFsFkmTg4pRoYX1x1uThpQ+zi5uVHf85ffXC6YmX0X7nLzBpl/u1aFp3H
        rln13fwsMsM4uzerZluH84Kfzyetm83M8FVWnuOixm6XqEnLJobeme82R8O34Xguk+8ity/N
        whmnkyafzLnCWfLKhcPvj+DRDlVJrevnJq45vFY/em4059HqErEw1/dt5yYXGNxkVWIpzkg0
        1GIuKk4EACEbfeTNAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsVy+t9jAV0uxQVRBvs/8FtsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+Txdojd9ktDr9pZ3Xg9Ni0qpPNY/OSeo++LasY
        PT5vkgtgieKySUnNySxLLdK3S+DK+P9wCnPBL7aKR31/GBsYn7F2MXJySAiYSHyatYC5i5GL
        Q0hgJ6PEvDUfWCCcX0DO9oNsIFVsAoYSvUf7GEFsEQFhiXtLl7ODFDEL/GOUeDb9MViRsICn
        xNsJH5hAbBYBVYl3dxaDNfAKWEu8mPOZCWKdvMT7BffB4pwCNhIL70xnAbGFgGre7Glin8DI
        s4CRYRWjZGpBcW56brFRgVFearlecWJucWleul5yfu4mRmBAbTus1b+D8fGS+EOMAhyMSjy8
        En/mRwmxJpYVV+YeYpTgYFYS4TWSXxAlxJuSWFmVWpQfX1Sak1p8iFGag0VJnJc//1ikkEB6
        YklqdmpqQWoRTJaJg1OqgZGl0GEOQwC3W6OM3OmuTJ93WfNiWNwyz03ZdPfC04kWJkEc6ifS
        Nkwrff99dvGu27sDG5m3MX6RiBIzkFrqqakbxbJwak7K9SsWz3LOX0/lE963+VJT0UyDjM9+
        a2UePrhhWCxmcV/Vtv3mvM6G+uxPsxL7QrrE8r9kv3Aru77njJjkMbn7akosxRmJhlrMRcWJ
        AKgVRJ0kAgAA
X-CMS-MailID: 20180307172738epcas2p20b57ae0b00fc1a422cd3e9b1b297753c
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180307172738epcas2p20b57ae0b00fc1a422cd3e9b1b297753c
X-RootMTR: 20180307172738epcas2p20b57ae0b00fc1a422cd3e9b1b297753c
References: <20180307172711.15697-1-s.nawrocki@samsung.com>
        <CGME20180307172738epcas2p20b57ae0b00fc1a422cd3e9b1b297753c@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing clocks, clock-names properties so the CODEC can
properly handle its master clock. Without this change sound on exynos5250-snow
doesn't work.
Missing #sound-dai-cells property is also added so it is possible to specify
the DAI links properly for HDMI audio support.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 4827cb506fa3..16e37c337a3f 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -27,6 +27,9 @@
 		reg = <0x11>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max98095_en>;
+		clocks = <&pmu_system_controller 0>;
+		clock-names = "mclk";
+		#sound-dai-cells = <1>;
 	};
 };

--
2.14.2
