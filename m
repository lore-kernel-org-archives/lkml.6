Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeBWAa6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:30:58 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:55391 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeBWAaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:30:55 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180223003054epoutp016269afed8a3f4448ddc87cd29bd6f4ce~VzQEssMoD0483404834epoutp01O
X-AuditID: b6c32a39-47fff70000000fc5-1d-5a8f60bdf5ab
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A8F60BE.8060405@samsung.com>
Date: Fri, 23 Feb 2018 09:30:54 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] ARM: dts: exynos: Fix unit addresses of PDMA nodes
 in Exynos5410
In-reply-to: <20180222191111.23747-2-krzk@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTURzm7O7uIa5u6/XLwuxCxRbO3en0WtmDxEZFjIqKSehFD87aQ3Y3
        ySAyopnrMcMokay0ItJqubRMs0iXWYSWmibko6TsIUZFpRDUtlvUf9/5zved7/w+fjJC6ZZE
        yXJtTuywcRZaEiG+2arSxjZnek3aoUI9W1vmI9mzgQ6S9Y58JNjOzutS1j/SS7LdjaclbFnn
        XRF7NTAgZX0nJ0m2dayIXBVhuF0+IDX4q4slhhsX9hmO1VUjw1d/tJE04eVmzGVjRwy2Zdmz
        c205KfT6zRlrMvSJWiaWSWaT6BgbZ8UpdOoGY2xariX4KTomn7O4gpSR43k6bsVyh93lxDFm
        O+9ModMZRqdhtEkanU6nSYjfsVSnD0oysXm07DyZ1xW5+9OTCnEh+iz3IJkMqAS41JrrQXKZ
        kmpAcPF1ogdFBPEPBFc8I+Rfzbv3nMA3ITh/8KckZFBQ02CidFAc0hDUfAh07QrRBKWC+iaf
        VHhzEEFZe5ogV0Nr3UsihMXUQghcHg4/Iwny9969COOp1AJ4PjGCQngmtR1un/0uDeXOoPpF
        UHu9XyQEsFBfXxMOmE6lQ3fl/rBBTunhQE8bGTIANSSBlp4SMnQBVCo87WsnBDwdPjyskwqD
        zYWuBymCvghBUfMZQjicQNDRNygSDPHwttLzJ3kKjH878qcVBRxyKwWJAR7VeJGAV8PQyVqR
        MP0NBJO31pag6PL/+ir/11f5f32dQ0Q1moXzeGsO5pk8vYbnrLzLlqPJslv9KLyD6uQG1Nax
        oQVRMkRHKrY7j5qUJJfPF1hbEMgIeobijtJrUiqyuYI92GHPcLgsmG9B+mDfx4momVn24Ebb
        nBlMQrI2IVEX3K1khqFnK4zGVJOSyuGceBfGedjx1yeSyaMK0c7UlfJZX2q2tg87C18tvhl9
        eNu6uMsH5tc8Uy1TF515kzmqqmjm9ExT1TG/OrJRZfVht6J3i6/U1yv5eN/+/op7CjwuTfs1
        2TC2KD+R3ls8sW382mblNb32UlTxnKoSv7zHspoN9Hq13aKIC5s2zvElzTOfOt3tnuvasmSs
        L34NLebNHKMmHDz3GxhmobmZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jAd29Cf1RBufPSVhsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+Txdojd9kt1k/7yWpx+E07qwOXx85Zd9k9Nq3q
        ZPPYvKTeo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDKez1jMWnCJp+L9mbksDYwfObsYOTgk
        BEwkXrxM7GLk5BAS2MkosbNRHMTmFRCU+DH5HgtICbOAvMSRS9kgYWYBdYlJ8xYxQ5Q/YJR4
        OU8XolxL4vCWO2BxFgFViSMrH7CB2GxA8f0vboDZ/AKKEld/PGYEGSkqECHRfaKyi5GLQ0Tg
        NpPElyuTmCHmW0hs3bqaHcQWFoiWOLP0LNSuzYwSS5vDQWxOAVOJ5ivHWCcwCsxCcukshEtn
        Ibl0ASPzKkbJ1ILi3PTcYqMCw7zUcr3ixNzi0rx0veT83E2MwAjYdlirbwfj/SXxhxgFOBiV
        eHgjSnqjhFgTy4orcw8xSnAwK4nw7hHqjxLiTUmsrEotyo8vKs1JLT7EKM3BoiTOezvvWKSQ
        QHpiSWp2ampBahFMlomDU6qBUa2f9XZgiTFXDZ+Zr0BIlJzNt3ghkXXnLoj1yR1/Xvc8tGOr
        6/bdIglaHnt4Yjb6fOk0XBx/TtMvJ7hN4u509i+CN9IYKorCjxR+cTgzb/ZJ6xLLOtnMM9kr
        WtUyJ5fuSDjW9Ft09ckiJ9+QlZfqazwWhvRMOfV48fIaZouJb4OsbkWHWLArsRRnJBpqMRcV
        JwIAmd1gfnwCAAA=
X-CMS-MailID: 20180223003053epcas1p4f9a0625512bb26fc82c3eacfee0b7a81
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180222191201epcas4p2e23264bce9d1d3b3cc3737c3d30b544d
X-RootMTR: 20180222191201epcas4p2e23264bce9d1d3b3cc3737c3d30b544d
References: <20180222191111.23747-1-krzk@kernel.org>
        <CGME20180222191201epcas4p2e23264bce9d1d3b3cc3737c3d30b544d@epcas4p2.samsung.com>
        <20180222191111.23747-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 02월 23일 04:11, Krzysztof Kozlowski wrote:
> Fix the unit addresses of PDMA nodes in Exynos5410 (the reg property is
> correct) to get rid of DTC warnings like:
> 
>     arch/arm/boot/dts/exynos5410-odroidxu.dtb: Warning (simple_bus_reg):
>         Node /soc/amba/pdma@12680000 simple-bus unit address format error, expected "121a0000"
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos5410.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index 1e6b57d013c4..55509c690328 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -196,9 +196,9 @@
>  			interrupt-parent = <&gic>;
>  			ranges;
>  
> -			pdma0: pdma@12680000 {
> +			pdma0: pdma@121a0000 {
>  				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121A0000 0x1000>;
> +				reg = <0x121a0000 0x1000>;
>  				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clock CLK_PDMA0>;
>  				clock-names = "apb_pclk";
> @@ -207,9 +207,9 @@
>  				#dma-requests = <32>;
>  			};
>  
> -			pdma1: pdma@12690000 {
> +			pdma1: pdma@121b0000 {
>  				compatible = "arm,pl330", "arm,primecell";
> -				reg = <0x121B0000 0x1000>;
> +				reg = <0x121b0000 0x1000>;
>  				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clock CLK_PDMA1>;
>  				clock-names = "apb_pclk";
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
