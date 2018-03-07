Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbeCGR3T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:29:19 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:41832 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933598AbeCGR10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:27:26 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180307172724epoutp046a978fe8ada2f1406661a810465a8706~Zs3BoBLEr2863728637epoutp04G
X-AuditID: b6c32a35-891ff70000001031-bd-5aa020fcd4f3
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 1/4] ARM: dts: exynos5250: Add #sound-dai-cells property to
 hdmi device node
Date: Wed, 07 Mar 2018 18:27:08 +0100
Message-id: <20180307172711.15697-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCmvu4fhQVRBns/8VtsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+Txdojd9ktDr9pZ3Xg9Ni0qpPNY/OSeo++LasY
        PT5vkgtgieKySUnNySxLLdK3S+DKeLF4C2PBAtaKjxOzGxhXsXQxcnJICJhIHOqezNTFyMUh
        JLCDUeLM+vesEM53RollvbOZuxg5wKr+TlSBiO9mlJjybR0jhPOLUeL7pgnMIKPYBAwleo/2
        MYLYIgLCEveWLmcHKWIW+McosW7lXjaQhLBAnMTPo/OYQGwWAVWJU0sPgTXzClhLdD2BGCQh
        IC/xfsF9sA0SAj9ZJXYsamaHSLhITL35mhXCFpZ4dXwLO8R50hKXjtpChKslOtu62CF6Wxgl
        /ky7xAaRsJY4fPwiWC+zAJ/Eu689rBC9vBIdbUIQJR4SfQdPQ8PFUWLC7Y9MICVCArESP3cU
        T2CUXMDIsIpRLLWgODc9tdiwwFCvODG3uDQvXS85P3cTIzgCtUx3ME4553OIUYCDUYmHV+LP
        /Cgh1sSy4srcQ4wSHMxKIrxG8guihHhTEiurUovy44tKc1KLDzFKc7AoifMGBLhECQmkJ5ak
        ZqemFqQWwWSZODilGhj7fPi1HuiZ58RsE7t7aFfGkj03f3T6Bwm+270i/e0sxq4Hm1494nab
        Mu23/47Uefvn+e+PSVlwQqZ47bM/h+WtbXjUMj77qSVYmX33zF1TmWr3befGydt1Z06Ztfxr
        doUV04KjHlabrVsmzK65sf2d3d2Sh3/tX35KOf9JIfTLw+4Hv/0fXrq4RImlOCPRUIu5qDgR
        AI++GlG8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOJMWRmVeSWpSXmKPExsVy+t9jAd3fCguiDPomWVhsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+Txdojd9ktDr9pZ3Xg9Ni0qpPNY/OSeo++LasY
        PT5vkgtgieKySUnNySxLLdK3S+DKeLF4C2PBAtaKjxOzGxhXsXQxcnBICJhI/J2o0sXIxSEk
        sJNRYmnXdUYI5xejRO+cR0BFnBxsAoYSvUf7GEFsEQFhiXtLl7ODFDEL/GOUeDb9MRtIQlgg
        TuLn0XlMIDaLgKrEqaWHmEFsXgFria4nE8BsCQF5ifcL7jNOYORawMiwilEytaA4Nz232KjA
        MC+1XK84Mbe4NC9dLzk/dxMjMDi2Hdbq28F4f0n8IUYBDkYlHl6JP/OjhFgTy4orcw8xSnAw
        K4nwGskviBLiTUmsrEotyo8vKs1JLT7EKM3BoiTOezvvWKSQQHpiSWp2ampBahFMlomDU6qB
        scP08A65p/YNi04wyvVfumB6Zqey+L7L79yn2U31VJ+SF796vlTom/DFSU6pcg3v+BUm9IUu
        UGxiT3V2TfqZWHfzwe7D588kBzT1zi6pv5R8pOlogbBR9DfL/af+Sj8zk1Z1adt/9PqR1LRT
        TNHHdLJsmZt0cmzXKLHc3czuP3eqTFpOBv8dJZbijERDLeai4kQAjLVv7AoCAAA=
X-CMS-MailID: 20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56
X-RootMTR: 20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56
References: <CGME20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is required for specifying link between the HDMI IP block
and the SoC's audio subsystem.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 56626d1a4235..71d2ede118e3 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -700,6 +700,7 @@
 					"sclk_hdmiphy", "mout_hdmi";
 			samsung,syscon-phandle = <&pmu_system_controller>;
 			phy = <&hdmiphy>;
+			#sound-dai-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.14.2
