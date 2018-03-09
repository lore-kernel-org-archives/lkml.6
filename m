Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932472AbeCIRYX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:24:23 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:54062 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbeCIRYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:24:19 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180309172417epoutp046894802a04d2e0de4ffc7696f808ea86~aUG3kFZr_2965729657epoutp04f
X-AuditID: b6c32a38-adbff70000001054-26-5aa2c33f52b9
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org, javierm@redhat.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 3/6] ARM: dts: exynos: Update of the max98095 node in
 exynos5250-snow.dts
Date: Fri, 09 Mar 2018 18:22:47 +0100
Message-id: <20180309172250.23019-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180309172250.23019-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCmrq794UVRBtMOmlpsnLGe1WL+kXOs
        FgunLWe06H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y25x+E07qwOXx6ZVnWwem5fU
        e7zfd5XNo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDJ+HbvPUrCFvaLv0QfWBsaJbF2MnBwS
        AiYSsxYvZe9i5OIQEtjBKLF3xzNGCOc7o0Tv0QlwVRO2H2GCSGxglPj9fAkbhPOLUaJ/40tW
        kCo2AUOgjj5GEFtEQFji3tLl7CA2s8AkJolZ82VBbGGBOIktL9eD1bMIqEq0/tjBDGLzClhL
        XFjUyQSxTV7i/YL7YHM4BWwklsw8DLZMQmAJm8TbDydYIIpcJBa/eQFlC0u8Or4FaBkHkC0t
        cemoLUS4WqKzrYsdoreFUeLPtEtQ71hLHD5+kRXiOD6Jd197WCF6eSU62oQgSjwkTjTPY4Ww
        HSVutz9nhXi4n1Fi15or7BMYpRYwMqxiFEstKM5NTy02LDDRK07MLS7NS9dLzs/dxAiOWS2L
        HYx7zvkcYhTgYFTi4d0xdVGUEGtiWXFl7iFGCQ5mJRHe9zVAId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rwBAS5RQgLpiSWp2ampBalFMFkmDk6pBkY15/MqVU97pB92ZYv/iL9bOi+u8+Vbjpqe
        r6rrnb+vnH8i4KXVOe39LRmSxzr2lc2efTX73FKfEua8pb13dNldNbnWrJj4Tv7331aPMMlQ
        /zkb4pd2PV+zTKImtfli8nyXWauMnSKVO838e1i8lnftvXZwxrMJzk+qZxY9n3bg1kaJudd5
        EwOVWIozEg21mIuKEwE1HPbe1QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsVy+t9jQV27w4uiDL58MbHYOGM9q8X8I+dY
        LRZOW85o0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl93i8Jt2Vgcuj02rOtk8Ni+p
        93i/7yqbR9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGX8OnafpWALe0Xfow+sDYwT2boYOTkk
        BEwkJmw/wtTFyMUhJLCOUaLx3EMo5xejxNslV9hBqtgEDCV6j/YxgtgiAsIS95YuZwcpYhaY
        xCTRtPMnWEJYIE5iy8v1rCA2i4CqROuPHcwgNq+AtcSFRZ1MEOvkJd4vuA9WzylgI7Fk5mGg
        MziAtllLbD0WMIGRZwEjwypGydSC4tz03GKjAsO81HK94sTc4tK8dL3k/NxNjMAQ23ZYq28H
        4/0l8YcYBTgYlXh4BWYsihJiTSwrrsw9xCjBwawkwvu+BijEm5JYWZValB9fVJqTWnyIUZqD
        RUmc93besUghgfTEktTs1NSC1CKYLBMHp1QDY+ryOLGTN5bHrf9+StUwW/DmQ/mH2+9uzxG0
        XyZwdcbln+03PadYWbzg76vW+2npoLHq1Nnej0GlnOuNV19qymE3rP6lIMhw6OjestOPbk6+
        uOTq98SV0zq7bjillv3bnLG7Iv6559V1H4wPtN2wflgXEPDCR19c3y87YILzjw1v1P54B+TP
        FVNiKc5INNRiLipOBACZ4N7bLQIAAA==
X-CMS-MailID: 20180309172414epcas1p36b0c39ad993afcad7f8cf8941cc6bf68
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180309172414epcas1p36b0c39ad993afcad7f8cf8941cc6bf68
X-RootMTR: 20180309172414epcas1p36b0c39ad993afcad7f8cf8941cc6bf68
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
        <CGME20180309172414epcas1p36b0c39ad993afcad7f8cf8941cc6bf68@epcas1p3.samsung.com>
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
Changes since v1:
 - edited commit summary line.
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
