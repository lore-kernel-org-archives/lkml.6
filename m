Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeEBOae (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:30:34 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50843 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbeEBOaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:30:30 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180502143028euoutp020f46ae588f357f5b8c4ae1b1e8a85fd8~q2khW3bYN3053930539euoutp02h
X-AuditID: cbfec7f2-1c1ff70000011644-40-5ae9cb823281
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] ARM: EXYNOS: no need to select ARCH_HAS_BANDGAP any longer
Date: Wed, 02 May 2018 16:30:26 +0200
Message-id: <9721484.FBO9LEPOs5@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7djP87rNp19GGXy6wmTR//g1s8X58xvY
        LTY9vsZqcXnXHDaLGef3MTmwemxa1cnmsXlJvcfnTXIBzFFcNimpOZllqUX6dglcGQdvTGAq
        eMFacXmZVwNjA2sXIyeHhICJxPYJNxm7GLk4hARWMErsfP8ayvnMKLHs8CW4qq9vjzNDJJYx
        Sly4eweq6jejxLGZj8Cq2ASsJCa2r2IEsUUE3CUW/F/DBmIzC+RInJjylgXEFhbwllj6fgOY
        zSKgKtF28AZYL6+ApsTCT9vYQWxRAS+JLfvamSDighI/Jt9jgZgjL7Fv/1RWCFtH4uyxdWBH
        SAj8ZJW43rAM6lQXibnHpzNB2MISr45vYYewZSQuT+5mgWhoZpT4tmMPM0RiAqPEnvVCELa1
        xOHjF6E28ElM2jYdqIYDKM4r0dEGVeIhMelrLwuE7Sjx+8YtsCeFBGIlFv96yjyBUWYWkrtn
        Ibl7FpK7FzAyr2IUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAiM8tP/jn/awfj1UtIhRgEO
        RiUeXoO8F1FCrIllxZW5hxglOJiVRHhXdjyLEuJNSaysSi3Kjy8qzUktPsQozcGiJM4bp1EX
        JSSQnliSmp2aWpBaBJNl4uCUamA0qXb/krrF1HlBu+G39kN/Hsjt6r7HvsL9/ZvLBg9XLn2h
        x/jPWOppw7wtHQnlzY1xAVcE5042jNlarsUqLzKTtaNc8O7t39/VJXPXPmb9//moYeypyMxH
        OaUm16WCk9lqzj3Ocn7v/9RUPODP5bmHqplnPrJwe2C7smIyzxSZupginbvblLcpsRRnJBpq
        MRcVJwIAly77we4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsVy+t/xy7pNp19GGVw+qWjR//g1s8X58xvY
        LTY9vsZqcXnXHDaLGef3MTmwemxa1cnmsXlJvcfnTXIBzFFcNimpOZllqUX6dglcGQdvTGAq
        eMFacXmZVwNjA2sXIyeHhICJxNe3x5m7GLk4hASWMErs61sG5fxllOhu+AtWxSZgJTGxfRUj
        iC0i4C6x4P8aNhCbWSBHYsnLvSwgtrCAt8TS9xvAbBYBVYm2gzfAenkFNCUWftrGDmKLCnhJ
        bNnXzgQRF5T4MfkeC8QceYl9+6eyQthaEut3HmeawMg7C0nZLCRls5CULWBkXsUoklpanJue
        W2ykV5yYW1yal66XnJ+7iREYcNuO/dyyg7HrXfAhRgEORiUeXoO8F1FCrIllxZW5hxglOJiV
        RHhXdjyLEuJNSaysSi3Kjy8qzUktPsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cC4
        TPvajJLJbS+b1dof2divLBbazHP2V0CsUJfJrHPnbs1R3HtaQumOnvUWfuHfs3rfvDir+2n5
        z1zLZ7rSaRyx7tZHmGavPKwnFnryXl7QzYiK8Ol1H7Q4Vnw4yClyRPTlP76Q2ysqDgk9Ylao
        YpNannbr09qY0i3ct08zHLBIutWuY7ZpYxKHEktxRqKhFnNRcSIAXPcjXjQCAAA=
X-CMS-MailID: 20180502143026eucas1p144f0f581196615d9c0fba89a562e6e12
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180502143026eucas1p144f0f581196615d9c0fba89a562e6e12
X-RootMTR: 20180502143026eucas1p144f0f581196615d9c0fba89a562e6e12
References: <CGME20180502143026eucas1p144f0f581196615d9c0fba89a562e6e12@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not needed since commit fcbb1e02ee54 ("drivers: thermal:
Remove ARCH_HAS_BANDGAP dependency for samsung") from 2014.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/Kconfig |    1 -
 1 file changed, 1 deletion(-)

Index: b/arch/arm/mach-exynos/Kconfig
===================================================================
--- a/arch/arm/mach-exynos/Kconfig	2018-03-07 13:57:25.249409707 +0100
+++ b/arch/arm/mach-exynos/Kconfig	2018-05-02 16:23:38.573626832 +0200
@@ -8,7 +8,6 @@
 menuconfig ARCH_EXYNOS
 	bool "Samsung EXYNOS"
 	depends on ARCH_MULTI_V7
-	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
