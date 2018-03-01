Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163295AbeCAXmo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:42:44 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:16444 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163088AbeCAXmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:42:42 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180301234240epoutp01b6df302e84115f198fedea49128e8775~X8G_DL5R_0864308643epoutp01Z
X-AuditID: b6c32a48-9c5ff70000000ff0-27-5a988ff0f39a
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A988FF0.3080302@samsung.com>
Date: Fri, 02 Mar 2018 08:42:40 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        acourbot@chromium.org, kernel@collabora.com
Subject: Re: [PATCH] arm64: defconfig: Enable typec-phy and
 extcon-usbc-cros-ec for rk3399
In-reply-to: <20180228140251.22232-1-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmme6H/hlRBl8mqVi0HXnDaPF+WQ+j
        xZrbhxgtNp/rYbXY9Pgaq8XlXXPYLF5+PMHiwO6xZt4aRo/ZDRdZPHbcXcLosXlJvcfnTXIB
        rFGpNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVygp
        lCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWiDQ2N9AwNzPWMjIz0TIxjrYxMgUoSUjOOvrvD
        WrCEs2LHirOMDYyv2bsYOTkkBEwkLny+yNrFyMUhJLCDUaLn11IWCOc7o8T07XtYYarO7HjP
        CJHYzShx8F4LWDuvgKDEj8n3gDo4OJgF5CWOXMoGCTMLaEps3b2eHaL+HqNE79nFUPVaEjeP
        HAMbyiKgKnFq4T1GEJsNKL7/xQ02EJtfQFHi6o/HYHFRgQiJnfO/gQ0SEehklNjwo4cJYkOp
        xP8DT8AahAViJPq7HrCDHMEp4CTxbgIHxNFn2CROboJ6wEVi4eYFTBC2sMSr41ug3peWeLZq
        I9hjEgLtjBLte+cxQzhTGCXOXb8H1WEs8WxhF9RiPomOw3/BlkkI8Ep0tAlBlHhIXPz8lw3C
        dpT4vWQZG8T3Uxklrj9YwDaBUW4WUoDNQgTYLKQAW8DIvIpRLLWgODc9tdiowESvODG3uDQv
        XS85P3cTIzjhaXnsYDxwzucQowAHoxIPrwDPjCgh1sSy4srcQ4wSHMxKIrynt0+LEuJNSays
        Si3Kjy8qzUktPsRoCgzvicxSosn5wGScVxJvaGJpYGJmZmRuZgFMYeK8bQEuUUIC6Yklqdmp
        qQWpRTB9TBycUg2M+5zKg+7YKGopTm4+EOC2UOtra6+lbOeBqNSCuSXrH3idXltgd+X/3j6u
        TgGWX2F3euYt1PvGEKlQEfhWW26vnaEzq9KnTWUPZvoXeAR7/Qg75ydwYUlXnUz6JjHOEhXJ
        aM7b71a8qZy2N/1B3qGla/g3bq6UFPn3pIE5IIS9MS/r0dL/9TZKLMUZiYZazEXFiQBaEMvR
        jgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsVy+t9jAd0P/TOiDCZNELFoO/KG0eL9sh5G
        izW3DzFabD7Xw2qx6fE1VovLu+awWbz8eILFgd1jzbw1jB6zGy6yeOy4u4TRY/OSeo/Pm+QC
        WKO4bFJSczLLUov07RK4Mo6+u8NasISzYseKs4wNjK/Zuxg5OSQETCTO7HjP2MXIxSEksJNR
        YsXXbWwgCV4BQYkfk++xdDFycDALyEscuZQNEmYWUJeYNG8RM0T9A0aJreeuQ9VrSdw8cowV
        xGYRUJU4tfAeI4jNBhTf/+IGWA2/gKLE1R+PGUFmigpESHSfqASZIyLQySgx494HNogFpRJt
        s1vBjhMWiJE4duU11HHTGSU2Hd8NdhCngJPEuwkcExgFZiE5dRbCqbOQnLqAkXkVo2RqQXFu
        em6xUYFRXmq5XnFibnFpXrpecn7uJkZgoG87rNW/g/HxkvhDjAIcjEo8vDs4Z0QJsSaWFVfm
        HmKU4GBWEuE9vX1alBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe/vxjkUIC6YklqdmpqQWpRTBZ
        Jg5OqQbG/bO6TKbsUEx/H7Fs3YS6iqqvB/nUz1pPu+tmKi0hqFxvM0PFvHtW9xpexgMB9R80
        W/bIP1n8au1s4X1rH2z/LXj+wNIfnxme3EmPmXNh4h6PB6bJv19XOZ4JimZ9a1Gwo8TsWOB3
        oT2rDOdesFM94cVnExTGIPPDSPO+7baD91s2v9sTrb1xvRJLcUaioRZzUXEiAJCnkRdwAgAA
X-CMS-MailID: 20180301234240epcas2p4ee9c3b9a428311e50747e09d165841d6
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180228140304epcas3p377c02db2d4f9f5d2549f433e08b51ea4
X-RootMTR: 20180228140304epcas3p377c02db2d4f9f5d2549f433e08b51ea4
References: <CGME20180228140304epcas3p377c02db2d4f9f5d2549f433e08b51ea4@epcas3p3.samsung.com>
        <20180228140251.22232-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 02월 28일 23:02, Enric Balletbo i Serra wrote:
> Enables typec phyter and extcon driver for cable detection that is used by
> USB 3.0 controller for Rockchip rk3399 SoCs.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 78b47bc7dc54..d4c25aa55785 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -544,6 +544,7 @@ CONFIG_ARCH_TEGRA_132_SOC=y
>  CONFIG_ARCH_TEGRA_210_SOC=y
>  CONFIG_ARCH_TEGRA_186_SOC=y
>  CONFIG_EXTCON_USB_GPIO=y
> +CONFIG_EXTCON_USBC_CROS_EC=y
>  CONFIG_IIO=y
>  CONFIG_EXYNOS_ADC=y
>  CONFIG_ROCKCHIP_SARADC=m
> @@ -564,6 +565,7 @@ CONFIG_PHY_MVEBU_CP110_COMPHY=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PHY_ROCKCHIP_EMMC=y
>  CONFIG_PHY_ROCKCHIP_PCIE=m
> +CONFIG_PHY_ROCKCHIP_TYPEC=y
>  CONFIG_PHY_XGENE=y
>  CONFIG_PHY_TEGRA_XUSB=y
>  CONFIG_QCOM_L2_PMU=y
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
