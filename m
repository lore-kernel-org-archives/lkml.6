Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbeCIRXy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:23:54 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:38927 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbeCIRXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:23:52 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180309172350epoutp01392dadd51cae5de9908a8a80fa1fd022~aUGenXgj12139221392epoutp01t
X-AuditID: b6c32a47-19fff7000000100c-c4-5aa2c325d77f
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org, javierm@redhat.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 1/6] ARM: dts: exynos: Add #sound-dai-cells property to
 hdmi node in exynos5250.dtsi
Date: Fri, 09 Mar 2018 18:22:45 +0100
Message-id: <20180309172250.23019-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCmua7q4UVRBjvm6VhsnLGe1WL+kXOs
        FgunLWe06H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y25x+E07qwOXx6ZVnWwem5fU
        e7zfd5XNo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDJeHpvDWnCDteJg6wOmBsarLF2MnBwS
        AiYSd7qbmUFsIYEdjBK7L/B2MXIB2d8ZJWYtX8kGU/T8wTVWiMQGRomFsxcyQji/GCUePb3I
        CFLFJmAo0Xu0D8wWERCWuLd0OTuIzSwwiUli1nxZEFtYIFPi3KZ3rCA2i4CqxLqF08HO4BWw
        lri9dSrUNnmJ9wvuM0LYHWwSv7cyQdguEjvPX4CKC0u8Or6FHcKWlni2aiNUvFqis62LHeQ4
        CYEWRok/0y5BDbWWOHz8IivEQXwSHYf/AhVxAMV5JTrahCBKPCT+nO2Fmuko8fXnYXZIsMRK
        NHxfzjaBUXIBI8MqRrHUguLc9NRiowJjveLE3OLSvHS95PzcTYzguNRy38G47ZzPIUYBDkYl
        Ht4dUxdFCbEmlhVX5h5ilOBgVhLhfV8DFOJNSaysSi3Kjy8qzUktPsQozcGiJM7bGuASJSSQ
        nliSmp2aWpBaBJNl4uCUamDMv3jomf/sF+LSDyLNryjtulC4oiTzwabK2bOn5viExey7JrOA
        90OroMLnL7zGNR0z/mpKvy63X+nw8O75clndr6mx4REnDjpKX7oy2Z7fxiLQRjsqO/Va+Rw1
        lUObYjQXicZmqM37+EzfSo4pZ3u+YHNu9TXJA4dK2mXDQpadVvx2T1h30UwlluKMREMt5qLi
        RAD+xoPXxwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42I5/e+xoK7q4UVRBg1bhC02zljPajH/yDlW
        i4XTljNa9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbc4/Kad1YHLY9OqTjaPzUvq
        Pd7vu8rm0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBkvj81hLbjBWnGw9QFTA+NVli5GTg4J
        AROJ5w+usXYxcnEICaxjlDi49QkbhPOLUeJ68wRWkCo2AUOJ3qN9jCC2iICwxL2ly9lBipgF
        JjFJNO38CZYQFsiU2PDiN9hYFgFViXULp4PZvALWEre3TmWDWCcv8X7BfcYJjFwLGBlWMUqm
        FhTnpucWGxUY5aWW6xUn5haX5qXrJefnbmIEBs22w1r9OxgfL4k/xCjAwajEwyswY1GUEGti
        WXFl7iFGCQ5mJRHe9zVAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rz8+ccihQTSE0tSs1NTC1KL
        YLJMHJxSDYw6cpZCNyTD68RXCpSyqh588kuotJJdelNCe+VyzWIj3R3GFbvuPJ8h7p3yMn1N
        7drIqJl7Q41qtu67uZHl5NW/BS/2rpA0iD3lKMP/lscwXunMQ50ZBXzR16V3mipNWHRDnv3k
        aVa/OIXC8wVvg8KP5ah/esm5cLFQxRbmu3nrDO+kTn8ZsV6JpTgj0VCLuag4EQANJQ1lFgIA
        AA==
X-CMS-MailID: 20180309172349epcas2p120eb4533e672b52eb13ddba97f3e6833
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180309172349epcas2p120eb4533e672b52eb13ddba97f3e6833
X-RootMTR: 20180309172349epcas2p120eb4533e672b52eb13ddba97f3e6833
References: <CGME20180309172349epcas2p120eb4533e672b52eb13ddba97f3e6833@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is required for specifying link between the HDMI IP block
and the SoC's audio subsystem.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1:
 - edited commit summary line.
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
