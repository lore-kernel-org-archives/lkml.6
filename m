Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933780AbeCGR1o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:27:44 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:17964 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933733AbeCGR1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:27:37 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180307172735epoutp03aac53e0bdc18a5563b1ec8d0b9d261b2~Zs3L6J4P22132321323epoutp03e
X-AuditID: b6c32a36-ca9ff70000001028-ea-5aa02106bbc3
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 2/4] ARM: dts: Add audio clocks configuration for
 exynos5250-snow
Date: Wed, 07 Mar 2018 18:27:09 +0100
Message-id: <20180307172711.15697-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180307172711.15697-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCmgS6b4oIog/etihYbZ6xntZh/5Byr
        Rf/j18wW589vYLfY9Pgaq8XlXXPYLGac38dksfbIXXaLw2/aWR04PTat6mTz2Lyk3qNvyypG
        j8+b5AJYorhsUlJzMstSi/TtErgy5vxYw1qwiKti7tQjLA2MJzi6GDk5JARMJPo73jF3MXJx
        CAnsYJTYfPEaE4TznVFi1YeXjDBVxy6fZYNI7GaU6N0zjRXC+cUocXHbDXaQKjYBQ4neo31g
        HSICwhL3li5nByliFvjHKLFu5V42kISwQLDEtAdTwGwWAVWJQ58egzXzClhLLOr9BbVOXuL9
        gvtgNqeAjcTCO9NZQAZJCExgk7h1dy1QMweQ4yJx8LkZRL2wxKvjW9ghwtISl47aQoSrJTrb
        utghWlsYJf5Mu8QGkbCWOHz8IiuIzSzAJ/Huaw8rRC+vREebEESJh0Tr2QssEGFHiXn3jCH+
        7Qd6fu8f9gmMUgsYGVYxiqUWFOempxYbFhjpFSfmFpfmpesl5+duYgRHp5bZDsZF53wOMQpw
        MCrx8B74OT9KiDWxrLgy9xCjBAezkgivkfyCKCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8AQEu
        UUIC6YklqdmpqQWpRTBZJg5OqQbGiA/t9cLGGc5W1mecubMFPermbJe83pwX9slkilj+uf82
        V+zcDU4IX1r+55rcow0LvxhO2BHqxnfHPZ57aYmEvKWgnoWmzNu/Pm821q7afErOqe5jpuY7
        j5b7d3Vb2+ccWXw1KGEC0+RDtloi815ecQuq2Xn9uMgtg20bAzbues0jHrR/v8FaJZbijERD
        Leai4kQAWJsO58oCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsVy+t9jAV02xQVRBo9f8FhsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+Txdojd9ktDr9pZ3Xg9Ni0qpPNY/OSeo++LasY
        PT5vkgtgieKySUnNySxLLdK3S+DKmPNjDWvBIq6KuVOPsDQwnuDoYuTkkBAwkTh2+SwbiC0k
        sJNR4uLGui5GLiD7F6PE5qP97CAJNgFDid6jfYwgtoiAsMS9pcvZQYqYBf4xSjyb/hisW1gg
        WGLagylgNouAqsShT4/BmnkFrCUW9f5ihNgmL/F+wX0wm1PARmLhneksEJutJd7saWKfwMiz
        gJFhFaNkakFxbnpusVGBYV5quV5xYm5xaV66XnJ+7iZGYDhtO6zVt4Px/pL4Q4wCHIxKPLwS
        f+ZHCbEmlhVX5h5ilOBgVhLhNZJfECXEm5JYWZValB9fVJqTWnyIUZqDRUmc93besUghgfTE
        ktTs1NSC1CKYLBMHp1QDY3PzAo6JK5azL1WrYnyervxBhPlUav/VKpHAopXHt+x8/bz05ivb
        Xy/vvNVMf1e3XSPqB2t2yWXWet+WFVZlSuHbFbeXfX4Tpbe03pspZGn118/nl3XzGt06c26j
        dbdCgsgru+LiiTP3mM6uzo+UyrXZtZXFiqHzh0WijfWdR2UF7DV7fdaUKLEUZyQaajEXFScC
        AHrZ+ZgjAgAA
X-CMS-MailID: 20180307172734epcas1p49c88df114f4e3b32999fbfb6159773ed
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180307172734epcas1p49c88df114f4e3b32999fbfb6159773ed
X-RootMTR: 20180307172734epcas1p49c88df114f4e3b32999fbfb6159773ed
References: <20180307172711.15697-1-s.nawrocki@samsung.com>
        <CGME20180307172734epcas1p49c88df114f4e3b32999fbfb6159773ed@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the audio subsystem clocks are not configured properly on Snow
and sound is not working. The MAX98095 CODEC is not getting its master clock
on the MCLK pin connected to the SOC's CLKOUT GPIO. This patch adds CLKOUT
and other clocks configuration so HDMI audio can also be supported.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index 59cf1b202849..bdf59dd3654b 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -225,6 +225,16 @@
 	};
 };
 
+&clock {
+	assigned-clocks = <&clock CLK_FOUT_EPLL>;
+	assigned-clock-rates = <49152000>;
+};
+
+&clock_audss {
+	assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>;
+	assigned-clock-parents = <&clock CLK_FOUT_EPLL>;
+};
+
 &cpu0 {
 	cpu0-supply = <&buck2_reg>;
 };
@@ -649,6 +659,11 @@
 	};
 };
 
+&pmu_system_controller {
+	assigned-clocks = <&pmu_system_controller 0>;
+	assigned-clock-parents = <&clock CLK_FIN_PLL>;
+};
+
 &rtc {
 	status = "okay";
 	clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
-- 
2.14.2
