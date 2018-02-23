Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeBWGlp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 01:41:45 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:32938 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbeBWGlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 01:41:42 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180223064141epoutp012f62e186e56c9b0d094a1ee350b17a4c~V4Tzynzr33123231232epoutp01E
X-AuditID: b6c32a48-9adff70000000ff0-ee-5a8fb7a47ff8
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        manabian@gmail.com, dinguyen@kernel.org, will.deacon@arm.com,
        xuwei5@hisilicon.com, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 5/6] ARM: dts: lpc18xx: remove 'num-slots' property for
 dwmmc
Date: Fri, 23 Feb 2018 15:41:37 +0900
Message-id: <20180223064138.18401-5-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.15.1
In-reply-to: <20180223064138.18401-1-jh80.chung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTURzHPbt7WU1um9nBXuNGRJFzW9u8+aLI5EJRo/5IF2oXPehyL3c3
        ywiRqKX22MRBZQ8rTGr0UNG0bCRzphEtRGq9jF4ujaB3ZvS627X/Pud3vl++v3P4ijHpgCBZ
        bLQ4kN1CmwjhDP61/mXalJZut0E51JpKNgdDAnLgfi+PfPTTJSBHbpwUksG/bkD2hkOAPB8e
        5pH7/UEROXh5KznxaYhPvhnwYqtnUpdOXwLU9aZREfX6VLuI6vDVCalnD28KqSOdPkB96Vio
        FxlQZhmiS5BdjizF1hKjpTSLWL+laG2RVqdUpahWkWmE3EKbURaRs0Gfkms0sTsS8kra5GRH
        epphiNTsTLvV6UDyMivjyCK2qVRqhUqZplCr1QrNyoJ0tZaVbEdl73sMtnOCXTf6ymvAeX49
        iBdDXAO/hf1YlKV4D4AvWzLqwQyWJwE88vym6L/oga9HyF20AdgyWc/nDj8AbBq+wouqhPgK
        2P19MMaJeD5s9vVjURGGBwEcefk0liHDN8Guiw8EUebjS+Bxf3NsDwmeAe80hqbjFkFP597Y
        PB7PhJ5f47E0iLcJofeVi8eJcmD35dsCjmXw3WDntHkejPjaAccHALx3QsaZvQBeOHZw2rwS
        Rs7WxxjDE2Bt/2/WLGbnEljrknISCk59aRdyvAYGX9fwuCe7Abw1eZjnAclnQJwPJCEbYy5F
        jNqmUTC0mXFaShXFVnMHiFVoOdUD+kIbAgAXA2KWJM9x2CAV0JVMlTkAoBgjEiWrfW6DVFJC
        V+1GdmuR3WlCTABo2c9pwJLnFFvZQlocRSrNKqVGp1On6Ui2DXMlLn2OQYqX0g5UjpAN2f/7
        eOL45BrgloHWLaT/rt8ZKiyo6MvzyA69OVA7nHpiqfHj+qPhiou1dTuq9i0umBgZu1r3VlYu
        wUrkcQ14xLVx1p6v2a0bXwBMeWvnn8o6M3bcO9YralwSyBQ8kowi0+d1jfnVCbnpcHYBrQW5
        SYWvyqcSuj7MX5D95FgkVfe4mtzcUDhO8JkyWrUcszP0PwpDS/lYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsVy+t9jQd0l2/ujDH4dlLOYf+Qcq8XR87uZ
        LG78amO1uLxrDpvFkf/9jBa7r59jtFh6/SKTReveI+wWx9eGW7z8eILF4snRKcwO3B5r5q1h
        9Ng56y67x+O5G9k9Nq3qZPO4c20Pm0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBlvNkRVbCI
        tWLXgewGxqUsXYycHBICJhJXV+1g62Lk4hASWMcoseHfI1YI5wejxI6eRnaQKjYBHYnt344z
        gdgiApESB35PYQIpYhY4wiixc8NUsISwgK/E+lsHwGwWAVWJmXvng63gFbCWODn5HDvEOnmJ
        CVuawOKcAjYSE/68ALOFgGrenf/NMoGRZwEjwypGydSC4tz03GKjAqO81HK94sTc4tK8dL3k
        /NxNjMDw23ZYq38H4+Ml8YcYBTgYlXh4I0p6o4RYE8uKK3MPMUpwMCuJ8Dqs6o8S4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkzsuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwOihYvvq5oVDJmV3t4RN
        7A+IvnFCVONM3qWfVj1urQHP69b8yJ4vaJ0vt8HyZ5tg8/r7Tj/z8zdntdxenzwr0E435LKQ
        fIu1k0/dqvO1vl3pLDZCzom2m8tnG2df/r+i7N1xAYuen43Z908dWXdgxROBbEWez1yrGA86
        iOxeeWqTsebqZ/UPhJRYijMSDbWYi4oTAXCxEqI7AgAA
X-CMS-MailID: 20180223064140epcas2p1bf475ebcbfa8a0c46e92402e31590891
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180223064140epcas2p1bf475ebcbfa8a0c46e92402e31590891
X-RootMTR: 20180223064140epcas2p1bf475ebcbfa8a0c46e92402e31590891
References: <20180223064138.18401-1-jh80.chung@samsung.com>
        <CGME20180223064140epcas2p1bf475ebcbfa8a0c46e92402e31590891@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'num-slots' had already deprecated, remove the property in
device-tree file.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 7cae9c5e27db..10b8249b8ab6 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -115,7 +115,6 @@
 			compatible = "snps,dw-mshc";
 			reg = <0x40004000 0x1000>;
 			interrupts = <6>;
-			num-slots = <1>;
 			clocks = <&ccu2 CLK_SDIO>, <&ccu1 CLK_CPU_SDIO>;
 			clock-names = "ciu", "biu";
 			resets = <&rgu 20>;
-- 
2.15.1
